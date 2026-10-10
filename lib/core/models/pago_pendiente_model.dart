import 'package:cloud_firestore/cloud_firestore.dart';

class PagoPendienteModel {
  final String id;
  final String userId;
  final String nombre;
  final DateTime fecha;
  final String estado;
  final String plan;
  final int duracionDias;
  final double monto;

  PagoPendienteModel({
    required this.id,
    required this.userId,
    required this.nombre,
    required this.fecha,
    this.estado = 'pendiente',
    this.plan = '1 Mes',
    this.duracionDias = 30,
    this.monto = 0.0,
  });

  factory PagoPendienteModel.fromFirestore(DocumentSnapshot doc) {
    final d = doc.data() as Map<String, dynamic>;
    return PagoPendienteModel(
      id: doc.id,
      userId: d['userId'] ?? '',
      nombre: d['nombre'] ?? '',
      fecha: (d['fecha'] as Timestamp?)?.toDate() ?? DateTime.now(),
      estado: d['estado'] ?? 'pendiente',
      plan: d['plan'] ?? '1 Mes',
      duracionDias: d['duracionDias'] ?? 30,
      monto: (d['monto'] ?? 0.0).toDouble(),
    );
  }

  Map<String, dynamic> toFirestore() => {
    'userId': userId,
    'nombre': nombre,
    'fecha': Timestamp.fromDate(fecha),
    'estado': estado,
    'plan': plan,
    'duracionDias': duracionDias,
    'monto': monto,
  };
}
