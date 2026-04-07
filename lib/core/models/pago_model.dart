import 'package:cloud_firestore/cloud_firestore.dart';

class PagoModel {
  final String idPago;
  final String idSocio;
  final int mes;
  final int anio;
  final double monto;
  final DateTime fechaPago;

  PagoModel({
    required this.idPago,
    required this.idSocio,
    required this.mes,
    required this.anio,
    required this.monto,
    required this.fechaPago,
  });

  factory PagoModel.fromFirestore(DocumentSnapshot doc) {
    final d = doc.data() as Map<String, dynamic>;
    return PagoModel(
      idPago: doc.id,
      idSocio: d['id_socio'] ?? '',
      mes: d['mes'] ?? 1,
      anio: d['anio'] ?? 2024,
      monto: (d['monto'] ?? 0).toDouble(),
      fechaPago: (d['fecha_pago'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toFirestore() => {
        'id_socio': idSocio,
        'mes': mes,
        'anio': anio,
        'monto': monto,
        'fecha_pago': Timestamp.fromDate(fechaPago),
      };
}
