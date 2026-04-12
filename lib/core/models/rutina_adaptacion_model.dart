import 'package:cloud_firestore/cloud_firestore.dart';

class Ejercicio {
  final String nombre;
  final String tipo; // Máquina o Peso Corporal
  final String seriesReps; // ej: 3x12
  final String descanso; // ej: 90 seg
  final String urlGif;
  final String instruccion; // Instrucción técnica breve
  final String? series;
  final String? repeticiones;
  final String? tipoDeEquipo; // Enum/String: barbell, dumbbell, machine, bodyweight
  final String? musculoObjetivo;
  final bool isSuperset;
  final int? supersetGroupId;
  final String? intensityTechnique;
  bool isCompleted; // Para el estado local (no se guarda base general)

  Ejercicio({
    required this.nombre,
    required this.tipo,
    required this.seriesReps,
    required this.descanso,
    required this.urlGif,
    this.instruccion = '',
    this.series,
    this.repeticiones,
    this.tipoDeEquipo,
    this.musculoObjetivo,
    this.isSuperset = false,
    this.supersetGroupId,
    this.intensityTechnique,
    this.isCompleted = false,
  });

  factory Ejercicio.fromMap(Map<String, dynamic> map) {
    return Ejercicio(
      nombre: map['nombre'] ?? '',
      tipo: map['tipo'] ?? '',
      seriesReps: map['series_reps'] ?? '',
      descanso: map['descanso'] ?? '',
      urlGif: map['url_gif'] ?? '',
      instruccion: map['instruccion'] ?? '',
      series: map['series'],
      repeticiones: map['repeticiones'],
      tipoDeEquipo: map['tipo_equipo'],
      musculoObjetivo: map['musculo_objetivo'],
      isSuperset: map['is_superset'] ?? false,
      supersetGroupId: map['superset_group_id'],
      intensityTechnique: map['intensity_technique'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'nombre': nombre,
      'tipo': tipo,
      'series_reps': seriesReps,
      'descanso': descanso,
      'url_gif': urlGif,
      'instruccion': instruccion,
      if (series != null) 'series': series,
      if (repeticiones != null) 'repeticiones': repeticiones,
      if (tipoDeEquipo != null) 'tipo_equipo': tipoDeEquipo,
      if (musculoObjetivo != null) 'musculo_objetivo': musculoObjetivo,
      'is_superset': isSuperset,
      if (supersetGroupId != null) 'superset_group_id': supersetGroupId,
      if (intensityTechnique != null) 'intensity_technique': intensityTechnique,
    };
  }

  // Copia modificable para la sesión en vivo
  Ejercicio copyWith({bool? isCompleted}) {
    return Ejercicio(
      nombre: nombre,
      tipo: tipo,
      seriesReps: seriesReps,
      descanso: descanso,
      urlGif: urlGif,
      instruccion: instruccion,
      series: series,
      repeticiones: repeticiones,
      tipoDeEquipo: tipoDeEquipo,
      musculoObjetivo: musculoObjetivo,
      isSuperset: isSuperset,
      supersetGroupId: supersetGroupId,
      intensityTechnique: intensityTechnique,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}

class DiaRutina {
  final String nombreDia; // Lunes, Miercoles...
  final List<Ejercicio> ejercicios;

  DiaRutina({required this.nombreDia, required this.ejercicios});

  factory DiaRutina.fromMap(Map<String, dynamic> map) {
    return DiaRutina(
      nombreDia: map['nombre_dia'] ?? '',
      ejercicios: (map['ejercicios'] as List<dynamic>?)
              ?.map((e) => Ejercicio.fromMap(e))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'nombre_dia': nombreDia,
      'ejercicios': ejercicios.map((e) => e.toMap()).toList(),
    };
  }
}

class RutinaAdaptacion {
  final String id;
  final String variante; // Ej: 3 Dias, 5 Dias
  final List<DiaRutina> dias;
  final String? level;
  final List<String>? tags;

  RutinaAdaptacion({
    required this.id, 
    required this.variante, 
    required this.dias,
    this.level,
    this.tags,
  });

  factory RutinaAdaptacion.fromFirestore(DocumentSnapshot doc) {
    final d = doc.data() as Map<String, dynamic>? ?? {};
    return RutinaAdaptacion(
      id: doc.id,
      variante: d['variante'] ?? '',
      level: d['level'],
      tags: (d['tags'] as List<dynamic>?)?.map((e) => e.toString()).toList(),
      dias: (d['dias'] as List<dynamic>?)
              ?.map((e) => DiaRutina.fromMap(e))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'variante': variante,
      if (level != null) 'level': level,
      if (tags != null) 'tags': tags,
      'dias': dias.map((d) => d.toMap()).toList(),
    };
  }
}
