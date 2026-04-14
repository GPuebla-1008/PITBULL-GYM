import 'package:cloud_firestore/cloud_firestore.dart';

class UsuarioModel {
  final String uid;
  final String nombre;
  final String email;
  final String documento;
  final String objetivo;
  final String telefono;
  final String telefonoEmergencia;
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
    this.telefono = '',
    this.telefonoEmergencia = '',
    this.rutinasAsignadas = const [],
    this.rol = 'miembro',
    required this.fechaRegistro,
    this.diaPagoFijo = 10,
  });

  UsuarioModel copyWith({
    String? uid,
    String? nombre,
    String? email,
    String? documento,
    String? objetivo,
    String? telefono,
    String? telefonoEmergencia,
    List<String>? rutinasAsignadas,
    String? rol,
    DateTime? fechaRegistro,
    int? diaPagoFijo,
  }) {
    return UsuarioModel(
      uid: uid ?? this.uid,
      nombre: nombre ?? this.nombre,
      email: email ?? this.email,
      documento: documento ?? this.documento,
      objetivo: objetivo ?? this.objetivo,
      telefono: telefono ?? this.telefono,
      telefonoEmergencia: telefonoEmergencia ?? this.telefonoEmergencia,
      rutinasAsignadas: rutinasAsignadas ?? this.rutinasAsignadas,
      rol: rol ?? this.rol,
      fechaRegistro: fechaRegistro ?? this.fechaRegistro,
      diaPagoFijo: diaPagoFijo ?? this.diaPagoFijo,
    );
  }

  factory UsuarioModel.fromFirestore(DocumentSnapshot doc) {
    final d = doc.data() as Map<String, dynamic>;
    return UsuarioModel(
      uid: doc.id,
      nombre: d['nombre'] ?? '',
      email: d['email'] ?? '',
      documento: d['documento'] ?? '',
      objetivo: d['objetivo'] ?? '',
      telefono: d['telefono'] ?? '',
      telefonoEmergencia: d['telefono_emergencia'] ?? '',
      rutinasAsignadas: List<String>.from(d['rutinas_asignadas'] ?? []),
      rol: d['rol'] ?? 'miembro',
      fechaRegistro:
          (d['fecha_registro'] as Timestamp?)?.toDate() ?? DateTime.now(),
      diaPagoFijo: d['dia_pago_fijo'] ?? 10,
    );
  }

  Map<String, dynamic> toFirestore() => {
    'nombre': nombre,
    'email': email,
    'documento': documento,
    'objetivo': objetivo,
    'telefono': telefono,
    'telefono_emergencia': telefonoEmergencia,
    'rutinas_asignadas': rutinasAsignadas,
    'rol': rol,
    'fecha_registro': Timestamp.fromDate(fechaRegistro),
    'dia_pago_fijo': diaPagoFijo,
  };
}
