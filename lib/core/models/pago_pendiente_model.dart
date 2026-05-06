import 'package:cloud_firestore/cloud_firestore.dart';

class PagoPendienteModel {
  final String id;
  final String userId;
  final String nombre;
  final DateTime fecha;
  final String estado;

  PagoPendienteModel({
    required this.id,
    required this.userId,
    required this.nombre,
    required this.fecha,
    this.estado = 'pendiente',
  });

  factory PagoPendienteModel.fromFirestore(DocumentSnapshot doc) {
    final d = doc.data() as Map<String, dynamic>;
    return PagoPendienteModel(
      id: doc.id,
      userId: d['userId'] ?? '',
      nombre: d['nombre'] ?? '',
      fecha: (d['fecha'] as Timestamp?)?.toDate() ?? DateTime.now(),
      estado: d['estado'] ?? 'pendiente',
    );
  }

  Map<String, dynamic> toFirestore() => {
    'userId': userId,
    'nombre': nombre,
    'fecha': Timestamp.fromDate(fecha),
    'estado': estado,
  };
}
