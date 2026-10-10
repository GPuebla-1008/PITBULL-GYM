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

  static DateTime calcularMismoDiaMesSiguiente(DateTime baseDate) {
    int year = baseDate.year;
    int month = baseDate.month + 1;
    if (month > 12) {
      year += 1;
      month = 1;
    }
    int day = baseDate.day;
    int maxDays = DateTime(year, month + 1, 0).day;
    if (day > maxDays) {
      day = maxDays;
    }
    return DateTime(year, month, day, 23, 59, 59);
  }

  Future<bool> registrarPagoMesActual(String idSocio, double monto) async {
    final now = DateTime.now();
    return cobrarSocio(
      idSocio: idSocio,
      fechaVencimiento: calcularMismoDiaMesSiguiente(now),
      plan: '1 Mes',
      monto: monto,
    );
  }

  Future<bool> cobrarSocio({
    required String idSocio,
    required DateTime fechaVencimiento,
    required String plan,
    required double monto,
  }) async {
    try {
      final now = DateTime.now();
      final batch = _db.batch();

      // 1. Actualizar usuario con nuevo estado y fecha exacta establecida por el admin
      final userRef = _db.collection('usuarios').doc(idSocio);
      batch.update(userRef, {
        'subscriptionStatus': 'activo',
        'expiryDate': Timestamp.fromDate(fechaVencimiento),
      });

      // 2. Registrar pago en historial
      final newHistoryRef = _db.collection('pagos').doc();
      final dias = fechaVencimiento.difference(now).inDays.clamp(1, 9999);
      final nuevoPago = PagoModel(
        idPago: newHistoryRef.id,
        idSocio: idSocio,
        mes: now.month,
        anio: now.year,
        monto: monto,
        fechaPago: now,
        plan: plan,
        duracionDias: dias,
      );
      batch.set(newHistoryRef, nuevoPago.toFirestore());

      await batch.commit();
      await fetchData();
      return true;
    } catch (e) {
      _errorMessage = 'Error al registrar cobro: $e';
      notifyListeners();
      return false;
    }
  }

  String getEstadoSocio(UsuarioModel socio) {
    if (socio.isAdmin || socio.rol == 'admin') return 'ADMIN';

    final now = DateTime.now();
    if (socio.expiryDate != null) {
      if (socio.expiryDate!.isAfter(now)) {
        return 'AL DÍA';
      } else {
        return 'VENCIDO';
      }
    }

    if (socio.subscriptionStatus == 'activo') {
      return 'AL DÍA';
    }

    return 'INACTIVO';
  }

  Color getColorEstado(String estado) {
    if (estado == 'AL DÍA') return Colors.greenAccent.shade400;
    if (estado == 'ADMIN') return Colors.blueAccent.shade400;
    if (estado == 'VENCIDO' || estado == 'DEUDOR') return Colors.redAccent.shade400;
    return Colors.amberAccent.shade400; // INACTIVO / PENDIENTE
  }

  // ── Gestión de Pagos Pendientes ──────────────────────────────────────────

  Stream<QuerySnapshot> getPendingPaymentsStream() {
    return _db
        .collection('pagos_pendientes')
        .where('estado', isEqualTo: 'pendiente')
        .snapshots();
  }

  Future<bool> approvePayment({
    required String paymentId,
    required String userId,
    required DateTime fechaVencimiento,
    required String plan,
    double monto = 0.0,
  }) async {
    try {
      final now = DateTime.now();
      final batch = _db.batch();

      // 1. Actualizar estado del pago pendiente
      final paymentRef = _db.collection('pagos_pendientes').doc(paymentId);
      batch.update(paymentRef, {
        'estado': 'aprobado',
        'aprobadoEn': Timestamp.fromDate(now),
        'plan': plan,
        'expiryDate': Timestamp.fromDate(fechaVencimiento),
        'monto': monto,
      });

      // 2. Actualizar datos del socio
      final userRef = _db.collection('usuarios').doc(userId);
      batch.update(userRef, {
        'subscriptionStatus': 'activo',
        'expiryDate': Timestamp.fromDate(fechaVencimiento),
      });

      // 3. Registrar en la colección histórica de pagos
      final newHistoryRef = _db.collection('pagos').doc();
      final dias = fechaVencimiento.difference(now).inDays.clamp(1, 9999);
      final nuevoPago = PagoModel(
        idPago: newHistoryRef.id,
        idSocio: userId,
        mes: now.month,
        anio: now.year,
        monto: monto,
        fechaPago: now,
        plan: plan,
        duracionDias: dias,
      );
      batch.set(newHistoryRef, nuevoPago.toFirestore());

      await batch.commit();
      await fetchData();
      return true;
    } catch (e) {
      _errorMessage = 'Error al aprobar pago: $e';
      notifyListeners();
      return false;
    }
  }
}
