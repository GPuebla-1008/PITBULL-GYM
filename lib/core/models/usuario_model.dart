import 'package:cloud_firestore/cloud_firestore.dart';

class UsuarioModel {
  final String uid;
  final String nombre;
  final String email;
  final String documento;
  final String objetivo;
  final List<String> rutinasAsignadas;
  final String rol;
  final DateTime fechaRegistro;
  final int diaPagoFijo;

  UsuarioModel({
    required this.uid,
    required this.nombre,
    required this.email,
    required this.documento,
    required this.objetivo,
    this.rutinasAsignadas = const [],
    this.rol = 'miembro',
    required this.fechaRegistro,
    this.diaPagoFijo = 10,
  });

  factory UsuarioModel.fromFirestore(DocumentSnapshot doc) {
    final d = doc.data() as Map<String, dynamic>;
    return UsuarioModel(
      uid: doc.id,
      nombre: d['nombre'] ?? '',
      email: d['email'] ?? '',
      documento: d['documento'] ?? '',
      objetivo: d['objetivo'] ?? '',
      rutinasAsignadas: List<String>.from(d['rutinas_asignadas'] ?? []),
      rol: d['rol'] ?? 'miembro',
      fechaRegistro: (d['fecha_registro'] as Timestamp?)?.toDate() ?? DateTime.now(),
      diaPagoFijo: d['dia_pago_fijo'] ?? 10,
    );
  }

  Map<String, dynamic> toFirestore() => {
        'nombre': nombre,
        'email': email,
        'documento': documento,
        'objetivo': objetivo,
        'rutinas_asignadas': rutinasAsignadas,
        'rol': rol,
        'fecha_registro': Timestamp.fromDate(fechaRegistro),
        'dia_pago_fijo': diaPagoFijo,
      };
}
