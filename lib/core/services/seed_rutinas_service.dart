import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/rutina_adaptacion_model.dart';

class SeedRutinasService {
  static Future<void> inyectarDatos(BuildContext context) async {
    final db = FirebaseFirestore.instance;
    final collection = db.collection('rutinas_adaptacion');

    try {
      // 1. Variante 3 Días (Original Full Body)
      final rutina3Dias = RutinaAdaptacion(
        id: 'fullbody_3_dias',
        variante: '3 Días',
        dias: [
          DiaRutina(nombreDia: 'Lunes', ejercicios: [
            Ejercicio(nombre: 'Prensa de Piernas', tipo: 'Máquina', seriesReps: '3x12', descanso: '90 seg', urlGif: 'assets/images/exercises/leg_press.png'),
            Ejercicio(nombre: 'Flexiones de Brazo', tipo: 'Peso Corporal', seriesReps: '3x10', descanso: '60 seg', urlGif: 'assets/images/exercises/pushup.png'),
            Ejercicio(nombre: 'Jalón al Pecho', tipo: 'Máquina', seriesReps: '3x12', descanso: '90 seg', urlGif: 'assets/images/exercises/lat_pulldown.png'),
            Ejercicio(nombre: 'Sentadillas Libres', tipo: 'Peso Corporal', seriesReps: '3x15', descanso: '120 seg', urlGif: 'assets/images/exercises/squat.png'),
            Ejercicio(nombre: 'Remo en Máquina', tipo: 'Máquina', seriesReps: '3x12', descanso: '90 seg', urlGif: 'assets/images/exercises/dumbbell_row.png'),
            Ejercicio(nombre: 'Plancha Abdominal', tipo: 'Peso Corporal', seriesReps: '3x45 seg', descanso: '60 seg', urlGif: 'assets/images/exercises/plank.png'),
          ]),
          DiaRutina(nombreDia: 'Miércoles', ejercicios: [
            Ejercicio(nombre: 'Sentadilla Goblet', tipo: 'Peso Libre', seriesReps: '3x12', descanso: '90 seg', urlGif: 'assets/images/exercises/squat.png'),
            Ejercicio(nombre: 'Press de Pecho Máquina', tipo: 'Máquina', seriesReps: '3x12', descanso: '90 seg', urlGif: 'assets/images/exercises/machine_press.png'),
            Ejercicio(nombre: 'Remo con Mancuerna', tipo: 'Peso Libre', seriesReps: '3x12', descanso: '90 seg', urlGif: 'assets/images/exercises/dumbbell_row.png'),
            Ejercicio(nombre: 'Extensiones de Cuádriceps', tipo: 'Máquina', seriesReps: '3x15', descanso: '60 seg', urlGif: 'assets/images/exercises/leg_extension.png'),
            Ejercicio(nombre: 'Crunch Abdominal', tipo: 'Peso Corporal', seriesReps: '3x20', descanso: '60 seg', urlGif: 'assets/images/exercises/plank.png'),
          ]),
          DiaRutina(nombreDia: 'Viernes', ejercicios: [
            Ejercicio(nombre: 'Prensa de Piernas', tipo: 'Máquina', seriesReps: '3x12', descanso: '90 seg', urlGif: 'assets/images/exercises/leg_press.png'),
            Ejercicio(nombre: 'Flexiones de Brazo', tipo: 'Peso Corporal', seriesReps: '3x10', descanso: '60 seg', urlGif: 'assets/images/exercises/pushup.png'),
            Ejercicio(nombre: 'Jalón al Pecho', tipo: 'Máquina', seriesReps: '3x12', descanso: '90 seg', urlGif: 'assets/images/exercises/lat_pulldown.png'),
            Ejercicio(nombre: 'Sentadillas Libres', tipo: 'Peso Corporal', seriesReps: '3x15', descanso: '120 seg', urlGif: 'assets/images/exercises/squat.png'),
            Ejercicio(nombre: 'Plancha Abdominal', tipo: 'Peso Corporal', seriesReps: '3x45 seg', descanso: '60 seg', urlGif: 'assets/images/exercises/plank.png'),
          ]),
        ]
      );

      // 2. Variante 5 Días
      final rutina5Dias = RutinaAdaptacion(
        id: 'fullbody_5_dias',
        variante: '5 Días',
        dias: [
          DiaRutina(nombreDia: 'Día 1 - Piernas', ejercicios: [
            Ejercicio(nombre: 'Sentadilla en Máquina', tipo: 'Máquina', seriesReps: '4x12', descanso: '120 seg', urlGif: 'assets/images/exercises/squat.png'),
            Ejercicio(nombre: 'Prensa', tipo: 'Máquina', seriesReps: '4x12', descanso: '120 seg', urlGif: 'assets/images/exercises/leg_press.png'),
            Ejercicio(nombre: 'Extensión Cuádriceps', tipo: 'Máquina', seriesReps: '3x15', descanso: '90 seg', urlGif: 'assets/images/exercises/leg_extension.png'),
            Ejercicio(nombre: 'Estocadas', tipo: 'Peso Corporal', seriesReps: '3x12 por pierna', descanso: '90 seg', urlGif: 'assets/images/exercises/lunge.png'),
          ]),
          DiaRutina(nombreDia: 'Día 2 - Empuje', ejercicios: [
            Ejercicio(nombre: 'Press Pecho Máquina', tipo: 'Máquina', seriesReps: '4x10', descanso: '90 seg', urlGif: 'assets/images/exercises/machine_press.png'),
            Ejercicio(nombre: 'Press Hombros Máquina', tipo: 'Máquina', seriesReps: '4x10', descanso: '90 seg', urlGif: 'assets/images/exercises/machine_press.png'),
            Ejercicio(nombre: 'Extensiones Triceps', tipo: 'Polea', seriesReps: '3x15', descanso: '60 seg', urlGif: 'assets/images/exercises/triceps_extension.png'),
            Ejercicio(nombre: 'Flexiones Apoyo Rodillas', tipo: 'Peso Corporal', seriesReps: '3xFallo', descanso: '60 seg', urlGif: 'assets/images/exercises/pushup.png'),
          ]),
          DiaRutina(nombreDia: 'Día 3 - Tracción', ejercicios: [
            Ejercicio(nombre: 'Jalón Polea Alta', tipo: 'Polea', seriesReps: '4x12', descanso: '90 seg', urlGif: 'assets/images/exercises/lat_pulldown.png'),
            Ejercicio(nombre: 'Remo Gironda', tipo: 'Polea', seriesReps: '4x12', descanso: '90 seg', urlGif: 'assets/images/exercises/dumbbell_row.png'),
            Ejercicio(nombre: 'Curl Biceps Polea', tipo: 'Polea', seriesReps: '3x15', descanso: '60 seg', urlGif: 'assets/images/exercises/biceps_curl.png'),
            Ejercicio(nombre: 'Dominadas Asistidas', tipo: 'Máquina', seriesReps: '3x10', descanso: '120 seg', urlGif: 'assets/images/exercises/lat_pulldown.png'),
          ]),
          DiaRutina(nombreDia: 'Día 4 - Glúteo e Isquios', ejercicios: [
            Ejercicio(nombre: 'Peso Muerto Rumano', tipo: 'Peso Libre', seriesReps: '4x12', descanso: '120 seg', urlGif: 'assets/images/exercises/hamstring_curl.png'),
            Ejercicio(nombre: 'Curl Isquios Tumbado', tipo: 'Máquina', seriesReps: '4x12', descanso: '90 seg', urlGif: 'assets/images/exercises/hamstring_curl.png'),
            Ejercicio(nombre: 'Hip Thrust Asistido', tipo: 'Máquina', seriesReps: '3x12', descanso: '90 seg', urlGif: 'assets/images/exercises/hamstring_curl.png'),
            Ejercicio(nombre: 'Elevación de Piernas', tipo: 'Peso Corporal', seriesReps: '4x20', descanso: '60 seg', urlGif: 'assets/images/exercises/plank.png'),
          ]),
          DiaRutina(nombreDia: 'Día 5 - Full Body', ejercicios: [
            Ejercicio(nombre: 'Sentadillas Globales', tipo: 'Peso Corporal', seriesReps: '3x20', descanso: '90 seg', urlGif: 'assets/images/exercises/squat.png'),
            Ejercicio(nombre: 'Flexiones Abiertas', tipo: 'Peso Corporal', seriesReps: '3x15', descanso: '60 seg', urlGif: 'assets/images/exercises/pushup.png'),
            Ejercicio(nombre: 'Jalón en V', tipo: 'Polea', seriesReps: '3x12', descanso: '90 seg', urlGif: 'assets/images/exercises/lat_pulldown.png'),
            Ejercicio(nombre: 'Plancha Spiderman', tipo: 'Peso Corporal', seriesReps: '3x15/lado', descanso: '60 seg', urlGif: 'assets/images/exercises/plank.png'),
          ]),
        ]
      );

      // 3. Rutina Principiante 3 Días (Máquinas/Mancuernas)
      final rutinaPrincipiante3Dias = RutinaAdaptacion(
        id: 'principiante_3_dias',
        variante: 'Principiante 3 Días',
        dias: [
          DiaRutina(nombreDia: 'Día 1', ejercicios: [
            Ejercicio(nombre: 'Press de Pecho en Máquina', tipo: 'Máquina', seriesReps: '3x12', descanso: '90 seg', urlGif: 'assets/images/exercises/machine_press.png', instruccion: 'Mantené la espalda apoyada y empujá controlando el movimiento.'),
            Ejercicio(nombre: 'Aperturas Inclinadas', tipo: 'Mancuernas', seriesReps: '3x12', descanso: '90 seg', urlGif: 'assets/images/exercises/pushup.png', instruccion: 'Abrí los brazos sintiendo el estiramiento en el pecho y cerrá.'),
            Ejercicio(nombre: 'Jalón al Pecho', tipo: 'Máquina', seriesReps: '3x12', descanso: '90 seg', urlGif: 'assets/images/exercises/lat_pulldown.png', instruccion: 'Llevá la barra hacia el pecho superior, juntando las escápulas.'),
            Ejercicio(nombre: 'Remo con Mancuerna', tipo: 'Mancuernas', seriesReps: '3x12', descanso: '90 seg', urlGif: 'assets/images/exercises/dumbbell_row.png', instruccion: 'Apoyá una rodilla y mano en un banco. Tirá de la mancuerna hacia tu cadera.')
          ]),
          DiaRutina(nombreDia: 'Día 2', ejercicios: [
            Ejercicio(nombre: 'Prensa de Piernas', tipo: 'Máquina', seriesReps: '3x12', descanso: '90 seg', urlGif: 'assets/images/exercises/leg_press.png', instruccion: 'Pies separados ancho de hombros. Bajá hasta 90 grados y empujá con los talones.'),
            Ejercicio(nombre: 'Extensiones de Cuádriceps', tipo: 'Máquina', seriesReps: '3x12', descanso: '90 seg', urlGif: 'assets/images/exercises/leg_extension.png', instruccion: 'Extendé las piernas completamente sin dar tirones. Bajá lento.'),
            Ejercicio(nombre: 'Sentadilla Goblet', tipo: 'Mancuerna', seriesReps: '3x12', descanso: '90 seg', urlGif: 'assets/images/exercises/squat.png', instruccion: 'Sostené la mancuerna en el pecho. Mantené la espalda recta al bajar.'),
            Ejercicio(nombre: 'Estocadas con Mancuernas', tipo: 'Mancuernas', seriesReps: '3x12', descanso: '90 seg', urlGif: 'assets/images/exercises/lunge.png', instruccion: 'Dá un paso largo, bajando la cadera en vertical. Alterná piernas.'),
            Ejercicio(nombre: 'Press Militar Sentado', tipo: 'Mancuernas', seriesReps: '3x12', descanso: '90 seg', urlGif: 'assets/images/exercises/machine_press.png', instruccion: 'Empujá las mancuernas hacia arriba por encima de la cabeza sin arquear la espalda.'),
            Ejercicio(nombre: 'Vuelos Laterales', tipo: 'Mancuernas', seriesReps: '3x12', descanso: '90 seg', urlGif: 'assets/images/exercises/dumbbell_row.png', instruccion: 'Elevá los brazos semiflexionados hasta la altura de los hombros.')
          ]),
          DiaRutina(nombreDia: 'Día 3', ejercicios: [
            Ejercicio(nombre: 'Curl de Bíceps Alternado', tipo: 'Mancuernas', seriesReps: '3x12', descanso: '90 seg', urlGif: 'assets/images/exercises/biceps_curl.png', instruccion: 'Mantené los codos pegados al cuerpo y flexioná alternando los brazos.'),
            Ejercicio(nombre: 'Curl en Polea Baja', tipo: 'Polea', seriesReps: '3x12', descanso: '90 seg', urlGif: 'assets/images/exercises/biceps_curl.png', instruccion: 'Movimiento continuo y controlado, apretando el bíceps arriba.'),
            Ejercicio(nombre: 'Extensión de Tríceps', tipo: 'Polea', seriesReps: '3x12', descanso: '90 seg', urlGif: 'assets/images/exercises/triceps_extension.png', instruccion: 'Codos fijos a los lados, extendé los brazos empujando hacia abajo.'),
            Ejercicio(nombre: 'Press Francés Tumbado', tipo: 'Mancuernas', seriesReps: '3x12', descanso: '90 seg', urlGif: 'assets/images/exercises/triceps_extension.png', instruccion: 'Tumbado, bajá las mancuernas al lado de la cabeza y extendé.')
          ]),
        ]
      );

      await collection.doc(rutina3Dias.id).set(rutina3Dias.toFirestore());
      await collection.doc(rutina5Dias.id).set(rutina5Dias.toFirestore());
      await collection.doc(rutinaPrincipiante3Dias.id).set(rutinaPrincipiante3Dias.toFirestore());

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
