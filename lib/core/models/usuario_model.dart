import 'package:cloud_firestore/cloud_firestore.dart';

class UsuarioModel {
  final String uid;
  final String nombre;
  final String email;
  final String objetivo;
  final List<String> rutinasAsignadas;
  final String rol;
  final DateTime fechaRegistro;

  UsuarioModel({
    required this.uid,
    required this.nombre,
    required this.email,
    required this.objetivo,
    this.rutinasAsignadas = const [],
    this.rol = 'miembro',
    required this.fechaRegistro,
  });

  factory UsuarioModel.fromFirestore(DocumentSnapshot doc) {
    final d = doc.data() as Map<String, dynamic>;
    return UsuarioModel(
      uid: doc.id,
      nombre: d['nombre'] ?? '',
      email: d['email'] ?? '',
      objetivo: d['objetivo'] ?? '',
      rutinasAsignadas: List<String>.from(d['rutinas_asignadas'] ?? []),
      rol: d['rol'] ?? 'miembro',
      fechaRegistro: (d['fecha_registro'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toFirestore() => {
        'nombre': nombre,
        'email': email,
        'objetivo': objetivo,
        'rutinas_asignadas': rutinasAsignadas,
        'rol': rol,
        'fecha_registro': Timestamp.fromDate(fechaRegistro),
      };
}
