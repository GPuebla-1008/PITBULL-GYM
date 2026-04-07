import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/rutina_adaptacion_model.dart';

class SeedRutinasService {
  static Future<void> inyectarDatos(BuildContext context) async {
    final db = FirebaseFirestore.instance;
    final collection = db.collection('rutinas_adaptacion');

    try {
      // 1. Variante 3 Días
      final rutina3Dias = RutinaAdaptacion(
        id: 'fullbody_3_dias',
        variante: '3 Días',
        dias: [
          DiaRutina(nombreDia: 'Lunes', ejercicios: [
            Ejercicio(nombre: 'Prensa de Piernas', tipo: 'Máquina', seriesReps: '3x12', descanso: '90 seg', urlGif: 'https://cdn-icons-png.flaticon.com/512/3048/3048122.png'),
            Ejercicio(nombre: 'Flexiones de Brazo', tipo: 'Peso Corporal', seriesReps: '3x10', descanso: '60 seg', urlGif: 'https://cdn-icons-png.flaticon.com/512/2555/2555562.png'),
            Ejercicio(nombre: 'Jalón al Pecho', tipo: 'Máquina', seriesReps: '3x12', descanso: '90 seg', urlGif: 'https://cdn-icons-png.flaticon.com/512/2936/2936886.png'),
            Ejercicio(nombre: 'Sentadillas Libres', tipo: 'Peso Corporal', seriesReps: '3x15', descanso: '120 seg', urlGif: 'https://cdn-icons-png.flaticon.com/512/5146/5146059.png'),
            Ejercicio(nombre: 'Remo en Máquina', tipo: 'Máquina', seriesReps: '3x12', descanso: '90 seg', urlGif: 'https://cdn-icons-png.flaticon.com/512/3254/3254302.png'),
            Ejercicio(nombre: 'Plancha Abdominal', tipo: 'Peso Corporal', seriesReps: '3x45 seg', descanso: '60 seg', urlGif: 'https://cdn-icons-png.flaticon.com/512/4862/4862217.png'),
          ]),
          DiaRutina(nombreDia: 'Miércoles', ejercicios: [
            Ejercicio(nombre: 'Sentadilla Goblet', tipo: 'Peso Libre', seriesReps: '3x12', descanso: '90 seg', urlGif: 'https://cdn-icons-png.flaticon.com/512/5146/5146059.png'),
            Ejercicio(nombre: 'Press de Pecho Máquina', tipo: 'Máquina', seriesReps: '3x12', descanso: '90 seg', urlGif: 'https://cdn-icons-png.flaticon.com/512/2555/2555562.png'),
            Ejercicio(nombre: 'Remo con Mancuerna', tipo: 'Peso Libre', seriesReps: '3x12', descanso: '90 seg', urlGif: 'https://cdn-icons-png.flaticon.com/512/3254/3254302.png'),
            Ejercicio(nombre: 'Extensiones de Cuádriceps', tipo: 'Máquina', seriesReps: '3x15', descanso: '60 seg', urlGif: 'https://cdn-icons-png.flaticon.com/512/3048/3048122.png'),
            Ejercicio(nombre: 'Crunch Abdominal', tipo: 'Peso Corporal', seriesReps: '3x20', descanso: '60 seg', urlGif: 'https://cdn-icons-png.flaticon.com/512/4862/4862217.png'),
          ]),
          DiaRutina(nombreDia: 'Viernes', ejercicios: [
            Ejercicio(nombre: 'Prensa de Piernas', tipo: 'Máquina', seriesReps: '3x12', descanso: '90 seg', urlGif: 'https://cdn-icons-png.flaticon.com/512/3048/3048122.png'),
            Ejercicio(nombre: 'Flexiones de Brazo', tipo: 'Peso Corporal', seriesReps: '3x10', descanso: '60 seg', urlGif: 'https://cdn-icons-png.flaticon.com/512/2555/2555562.png'),
            Ejercicio(nombre: 'Jalón al Pecho', tipo: 'Máquina', seriesReps: '3x12', descanso: '90 seg', urlGif: 'https://cdn-icons-png.flaticon.com/512/2936/2936886.png'),
            Ejercicio(nombre: 'Sentadillas Libres', tipo: 'Peso Corporal', seriesReps: '3x15', descanso: '120 seg', urlGif: 'https://cdn-icons-png.flaticon.com/512/5146/5146059.png'),
            Ejercicio(nombre: 'Plancha Abdominal', tipo: 'Peso Corporal', seriesReps: '3x45 seg', descanso: '60 seg', urlGif: 'https://cdn-icons-png.flaticon.com/512/4862/4862217.png'),
          ]),
        ]
      );

      // 2. Variante 5 Días
      final rutina5Dias = RutinaAdaptacion(
        id: 'fullbody_5_dias',
        variante: '5 Días',
        dias: [
          DiaRutina(nombreDia: 'Día 1 - Piernas', ejercicios: [
            Ejercicio(nombre: 'Sentadilla en Máquina', tipo: 'Máquina', seriesReps: '4x12', descanso: '120 seg', urlGif: 'https://cdn-icons-png.flaticon.com/512/5146/5146059.png'),
            Ejercicio(nombre: 'Prensa', tipo: 'Máquina', seriesReps: '4x12', descanso: '120 seg', urlGif: 'https://cdn-icons-png.flaticon.com/512/3048/3048122.png'),
            Ejercicio(nombre: 'Extensión Cuádriceps', tipo: 'Máquina', seriesReps: '3x15', descanso: '90 seg', urlGif: 'https://cdn-icons-png.flaticon.com/512/3048/3048122.png'),
            Ejercicio(nombre: 'Estocadas', tipo: 'Peso Corporal', seriesReps: '3x12 por pierna', descanso: '90 seg', urlGif: 'https://cdn-icons-png.flaticon.com/512/5146/5146059.png'),
          ]),
          DiaRutina(nombreDia: 'Día 2 - Empuje', ejercicios: [
            Ejercicio(nombre: 'Press Pecho Máquina', tipo: 'Máquina', seriesReps: '4x10', descanso: '90 seg', urlGif: 'https://cdn-icons-png.flaticon.com/512/2555/2555562.png'),
            Ejercicio(nombre: 'Press Hombros Máquina', tipo: 'Máquina', seriesReps: '4x10', descanso: '90 seg', urlGif: 'https://cdn-icons-png.flaticon.com/512/2555/2555562.png'),
            Ejercicio(nombre: 'Extensiones Triceps', tipo: 'Polea', seriesReps: '3x15', descanso: '60 seg', urlGif: 'https://cdn-icons-png.flaticon.com/512/2555/2555562.png'),
            Ejercicio(nombre: 'Flexiones Apoyo Rodillas', tipo: 'Peso Corporal', seriesReps: '3xFallo', descanso: '60 seg', urlGif: 'https://cdn-icons-png.flaticon.com/512/2555/2555562.png'),
          ]),
          DiaRutina(nombreDia: 'Día 3 - Tracción', ejercicios: [
            Ejercicio(nombre: 'Jalón Polea Alta', tipo: 'Polea', seriesReps: '4x12', descanso: '90 seg', urlGif: 'https://cdn-icons-png.flaticon.com/512/2936/2936886.png'),
            Ejercicio(nombre: 'Remo Gironda', tipo: 'Polea', seriesReps: '4x12', descanso: '90 seg', urlGif: 'https://cdn-icons-png.flaticon.com/512/3254/3254302.png'),
            Ejercicio(nombre: 'Curl Biceps Polea', tipo: 'Polea', seriesReps: '3x15', descanso: '60 seg', urlGif: 'https://cdn-icons-png.flaticon.com/512/3254/3254302.png'),
            Ejercicio(nombre: 'Dominadas Asistidas', tipo: 'Máquina', seriesReps: '3x10', descanso: '120 seg', urlGif: 'https://cdn-icons-png.flaticon.com/512/2936/2936886.png'),
          ]),
          DiaRutina(nombreDia: 'Día 4 - Glúteo e Isquios', ejercicios: [
            Ejercicio(nombre: 'Peso Muerto Rumano', tipo: 'Peso Libre', seriesReps: '4x12', descanso: '120 seg', urlGif: 'https://cdn-icons-png.flaticon.com/512/5146/5146059.png'),
            Ejercicio(nombre: 'Curl Isquios Tumbado', tipo: 'Máquina', seriesReps: '4x12', descanso: '90 seg', urlGif: 'https://cdn-icons-png.flaticon.com/512/3048/3048122.png'),
            Ejercicio(nombre: 'Hip Thrust Asistido', tipo: 'Máquina', seriesReps: '3x12', descanso: '90 seg', urlGif: 'https://cdn-icons-png.flaticon.com/512/5146/5146059.png'),
            Ejercicio(nombre: 'Elevación de Piernas', tipo: 'Peso Corporal', seriesReps: '4x20', descanso: '60 seg', urlGif: 'https://cdn-icons-png.flaticon.com/512/4862/4862217.png'),
          ]),
          DiaRutina(nombreDia: 'Día 5 - Full Body', ejercicios: [
            Ejercicio(nombre: 'Sentadillas Globales', tipo: 'Peso Corporal', seriesReps: '3x20', descanso: '90 seg', urlGif: 'https://cdn-icons-png.flaticon.com/512/5146/5146059.png'),
            Ejercicio(nombre: 'Flexiones Abiertas', tipo: 'Peso Corporal', seriesReps: '3x15', descanso: '60 seg', urlGif: 'https://cdn-icons-png.flaticon.com/512/2555/2555562.png'),
            Ejercicio(nombre: 'Jalón en V', tipo: 'Polea', seriesReps: '3x12', descanso: '90 seg', urlGif: 'https://cdn-icons-png.flaticon.com/512/2936/2936886.png'),
            Ejercicio(nombre: 'Plancha Spiderman', tipo: 'Peso Corporal', seriesReps: '3x15/lado', descanso: '60 seg', urlGif: 'https://cdn-icons-png.flaticon.com/512/4862/4862217.png'),
          ]),
        ]
      );

      await collection.doc(rutina3Dias.id).set(rutina3Dias.toFirestore());
      await collection.doc(rutina5Dias.id).set(rutina5Dias.toFirestore());

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('¡Datos inyectados en Firestore con éxito!'), backgroundColor: Colors.green),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al inyectar: \$e'), backgroundColor: Colors.red),
      );
    }
  }
}
