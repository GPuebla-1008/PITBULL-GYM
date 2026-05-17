import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/usuario_model.dart';
import '../models/pago_model.dart';

class AdminProvider with ChangeNotifier {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  List<UsuarioModel> _socios = [];
  List<PagoModel> _pagosMesActual = [];
  bool _loading = false;
  String? _errorMessage;

  List<UsuarioModel> get socios => _socios;
  List<PagoModel> get pagosMesActual => _pagosMesActual;
  bool get loading => _loading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchData() async {
    _loading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final now = DateTime.now();

      // Consultar socios
      final sociosSnapshot = await _db.collection('usuarios').get();
      _socios = sociosSnapshot.docs
          .map((doc) => UsuarioModel.fromFirestore(doc))
          .toList();

      // Consultar pagos del mes en curso
      final pagosSnapshot = await _db
          .collection('pagos')
          .where('anio', isEqualTo: now.year)
          .where('mes', isEqualTo: now.month)
          .get();
      _pagosMesActual = pagosSnapshot.docs
          .map((doc) => PagoModel.fromFirestore(doc))
          .toList();
    } catch (e) {
      _errorMessage = 'Error al cargar datos: $e';
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future<bool> registrarPagoMesActual(String idSocio, double monto) async {
    try {
      final now = DateTime.now();
      final nuevoPago = PagoModel(
        idPago: _db.collection('pagos').doc().id,
        idSocio: idSocio,
        mes: now.month,
        anio: now.year,
        monto: monto,
        fechaPago: now,
      );

      await _db
          .collection('pagos')
          .doc(nuevoPago.idPago)
          .set(nuevoPago.toFirestore());
      _pagosMesActual.add(nuevoPago);
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = 'Error al registrar pago: $e';
      notifyListeners();
      return false;
    }
  }

  String getEstadoSocio(UsuarioModel socio) {
    // Buscar si ya pagó este mes
    final pagado = _pagosMesActual.any((p) => p.idSocio == socio.uid);
    if (pagado) return 'AL DÍA';

    // Si no pagó, revisar vencimiento
    final now = DateTime.now();
    if (now.day > socio.diaPagoFijo) {
      return 'DEUDOR';
    } else {
      return 'PENDIENTE';
    }
  }

  Color getColorEstado(String estado) {
    if (estado == 'AL DÍA') return Colors.greenAccent.shade400;
    if (estado == 'DEUDOR') return Colors.redAccent.shade400;
    return Colors.amberAccent.shade400; // PENDIENTE
  }

  // ── Gestión de Pagos Pendientes ──────────────────────────────────────────

  Stream<QuerySnapshot> getPendingPaymentsStream() {
    return _db
        .collection('pagos_pendientes')
        .where('estado', isEqualTo: 'pendiente')
        .snapshots();
  }

  Future<bool> approvePayment(String paymentId, String userId) async {
    try {
      final batch = _db.batch();

      // 1. Actualizar estado del pago
      final paymentRef = _db.collection('pagos_pendientes').doc(paymentId);
      batch.update(paymentRef, {'estado': 'aprobado'});

      // 2. Actualizar datos del socio
      final userRef = _db.collection('usuarios').doc(userId);
      final now = DateTime.now();
      final newExpiryDate = now.add(const Duration(days: 30));

      batch.update(userRef, {
        'subscriptionStatus': 'activo',
        'expiryDate': Timestamp.fromDate(newExpiryDate),
      });

      // 3. Registrar en la colección histórica de pagos (opcional pero recomendado)
      final newHistoryRef = _db.collection('pagos').doc();
      batch.set(newHistoryRef, {
        'id_socio': userId,
        'mes': now.month,
        'anio': now.year,
        'monto': 0.0, // El monto se podría parametrizar si fuera necesario
        'fecha_pago': Timestamp.fromDate(now),
      });

      await batch.commit();
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = 'Error al aprobar pago: $e';
      notifyListeners();
      return false;
    }
  }
}
