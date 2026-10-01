import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/rutina_adaptacion_model.dart';

class SeedRutinasService {
  static Future<void> inyectarDatos(BuildContext context) async {
    try {
      await inyectarDatosSilent();
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('¡Datos inyectados en Firestore con éxito!'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error al inyectar: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  static Future<void> inyectarDatosSilent() async {
    final db = FirebaseFirestore.instance;
    final collection = db.collection('rutinas_adaptacion');

    try {
      // 1. Variante 3 Días (Original Full Body)
      final rutina3Dias = RutinaAdaptacion(
        id: 'fullbody_3_dias',
        variante: '3 Días',
        dias: [
          DiaRutina(
            nombreDia: 'Día 1',
            ejercicios: [
              Ejercicio(
                nombre: 'Press de Pecho en Máquina',
                tipo: 'Máquina',
                seriesReps: '3x12',
                descanso: '90 seg',
                urlGif: 'assets/images/exercises/machine_press.png',
                instruccion:
                    'Mantené la espalda apoyada y empujá controlando el movimiento.',
              ),
              Ejercicio(
                nombre: 'Aperturas Inclinadas',
                tipo: 'Mancuernas',
                seriesReps: '3x12',
                descanso: '90 seg',
                urlGif: 'assets/images/exercises/pushup.png',
                instruccion:
                    'Abrí los brazos sintiendo el estiramiento en el pecho y cerrá.',
              ),
              Ejercicio(
                nombre: 'Jalón al Pecho',
                tipo: 'Máquina',
                seriesReps: '3x12',
                descanso: '90 seg',
                urlGif: 'assets/images/exercises/lat_pulldown.png',
                instruccion:
                    'Llevá la barra hacia el pecho superior, juntando las escápulas.',
              ),
              Ejercicio(
                nombre: 'Remo con Mancuerna',
                tipo: 'Mancuernas',
                seriesReps: '3x12',
                descanso: '90 seg',
                urlGif: 'assets/images/exercises/dumbbell_row.png',
                instruccion:
                    'Apoyá una rodilla y mano en un banco. Tirá de la mancuerna hacia tu cadera.',
              ),
            ],
          ),
          DiaRutina(
            nombreDia: 'Día 2',
            ejercicios: [
              Ejercicio(
                nombre: 'Prensa de Piernas',
                tipo: 'Máquina',
                seriesReps: '3x12',
                descanso: '90 seg',
                urlGif: 'assets/images/exercises/leg_press.png',
                instruccion:
                    'Pies separados ancho de hombros. Bajá hasta 90 grados y empujá con los talones.',
              ),
              Ejercicio(
                nombre: 'Extensiones de Cuádriceps',
                tipo: 'Máquina',
                seriesReps: '3x12',
                descanso: '90 seg',
                urlGif: 'assets/images/exercises/leg_extension.png',
                instruccion:
                    'Extendé las piernas completamente sin dar tirones. Bajá lento.',
              ),
              Ejercicio(
                nombre: 'Sentadilla Goblet',
                tipo: 'Mancuerna',
                seriesReps: '3x12',
                descanso: '90 seg',
                urlGif: 'assets/images/exercises/squat.png',
                instruccion:
                    'Sostené la mancuerna en el pecho. Mantené la espalda recta al bajar.',
              ),
              Ejercicio(
                nombre: 'Estocadas con Mancuernas',
                tipo: 'Mancuernas',
                seriesReps: '3x12',
                descanso: '90 seg',
                urlGif: 'assets/images/exercises/lunge.png',
                instruccion:
                    'Dá un paso largo, bajando la cadera en vertical. Alterná piernas.',
              ),
              Ejercicio(
                nombre: 'Press Militar Sentado',
                tipo: 'Mancuernas',
                seriesReps: '3x12',
                descanso: '90 seg',
                urlGif: 'assets/images/exercises/machine_press.png',
                instruccion:
                    'Empujá las mancuernas hacia arriba por encima de la cabeza sin arquear la espalda.',
              ),
              Ejercicio(
                nombre: 'Vuelos Laterales',
                tipo: 'Mancuernas',
                seriesReps: '3x12',
                descanso: '90 seg',
                urlGif: 'assets/images/exercises/dumbbell_row.png',
                instruccion:
                    'Elevá los brazos semiflexionados hasta la altura de los hombros.',
              ),
            ],
          ),
          DiaRutina(
            nombreDia: 'Día 3',
            ejercicios: [
              Ejercicio(
                nombre: 'Curl de Bíceps Alternado',
                tipo: 'Mancuernas',
                seriesReps: '3x12',
                descanso: '90 seg',
                urlGif: 'assets/images/exercises/biceps_curl.png',
                instruccion:
                    'Mantené los codos pegados al cuerpo y flexioná alternando los brazos.',
              ),
              Ejercicio(
                nombre: 'Curl en Polea Baja',
                tipo: 'Polea',
                seriesReps: '3x12',
                descanso: '90 seg',
                urlGif: 'assets/images/exercises/biceps_curl.png',
                instruccion:
                    'Movimiento continuo y controlado, apretando el bíceps arriba.',
              ),
              Ejercicio(
                nombre: 'Extensión de Tríceps',
                tipo: 'Polea',
                seriesReps: '3x12',
                descanso: '90 seg',
                urlGif: 'assets/images/exercises/triceps_extension.png',
                instruccion:
                    'Codos fijos a los lados, extendé los brazos empujando hacia abajo.',
              ),
              Ejercicio(
                nombre: 'Press Francés Tumbado',
                tipo: 'Mancuernas',
                seriesReps: '3x12',
                descanso: '90 seg',
                urlGif: 'assets/images/exercises/triceps_extension.png',
                instruccion:
                    'Tumbado, bajá las mancuernas al lado de la cabeza y extendé.',
              ),
            ],
          ),
        ],
      );

      // 2. Variante 5 Días
      final rutina5Dias = RutinaAdaptacion(
        id: 'fullbody_5_dias',
        variante: '5 Días',
        dias: [
          DiaRutina(
            nombreDia: 'Día 1 - Piernas',
            ejercicios: [
              Ejercicio(
                nombre: 'Sentadilla en Máquina',
                tipo: 'Máquina',
                seriesReps: '4x12',
                descanso: '120 seg',
                urlGif: 'assets/images/exercises/squat.png',
              ),
              Ejercicio(
                nombre: 'Prensa',
                tipo: 'Máquina',
                seriesReps: '4x12',
                descanso: '120 seg',
                urlGif: 'assets/images/exercises/leg_press.png',
              ),
              Ejercicio(
                nombre: 'Extensión Cuádriceps',
                tipo: 'Máquina',
                seriesReps: '3x15',
                descanso: '90 seg',
                urlGif: 'assets/images/exercises/leg_extension.png',
              ),
              Ejercicio(
                nombre: 'Estocadas',
                tipo: 'Peso Corporal',
                seriesReps: '3x12 por pierna',
                descanso: '90 seg',
                urlGif: 'assets/images/exercises/lunge.png',
              ),
            ],
          ),
          DiaRutina(
            nombreDia: 'Día 2 - Empuje',
            ejercicios: [
              Ejercicio(
                nombre: 'Press Pecho Máquina',
                tipo: 'Máquina',
                seriesReps: '4x10',
                descanso: '90 seg',
                urlGif: 'assets/images/exercises/machine_press.png',
              ),
              Ejercicio(
                nombre: 'Press Hombros Máquina',
                tipo: 'Máquina',
                seriesReps: '4x10',
                descanso: '90 seg',
                urlGif: 'assets/images/exercises/machine_press.png',
              ),
              Ejercicio(
                nombre: 'Extensiones Triceps',
                tipo: 'Polea',
                seriesReps: '3x15',
                descanso: '60 seg',
                urlGif: 'assets/images/exercises/triceps_extension.png',
              ),
              Ejercicio(
                nombre: 'Flexiones Apoyo Rodillas',
                tipo: 'Peso Corporal',
                seriesReps: '3xFallo',
                descanso: '60 seg',
                urlGif: 'assets/images/exercises/pushup.png',
              ),
            ],
          ),
          DiaRutina(
            nombreDia: 'Día 3 - Tracción',
            ejercicios: [
              Ejercicio(
                nombre: 'Jalón Polea Alta',
                tipo: 'Polea',
                seriesReps: '4x12',
                descanso: '90 seg',
                urlGif: 'assets/images/exercises/lat_pulldown.png',
              ),
              Ejercicio(
                nombre: 'Remo Gironda',
                tipo: 'Polea',
                seriesReps: '4x12',
                descanso: '90 seg',
                urlGif: 'assets/images/exercises/dumbbell_row.png',
              ),
              Ejercicio(
                nombre: 'Curl Biceps Polea',
                tipo: 'Polea',
                seriesReps: '3x15',
                descanso: '60 seg',
                urlGif: 'assets/images/exercises/biceps_curl.png',
              ),
              Ejercicio(
                nombre: 'Dominadas Asistidas',
                tipo: 'Máquina',
                seriesReps: '3x10',
                descanso: '120 seg',
                urlGif: 'assets/images/exercises/lat_pulldown.png',
              ),
            ],
          ),
          DiaRutina(
            nombreDia: 'Día 4 - Glúteo e Isquios',
            ejercicios: [
              Ejercicio(
                nombre: 'Peso Muerto Rumano',
                tipo: 'Peso Libre',
                seriesReps: '4x12',
                descanso: '120 seg',
                urlGif: 'assets/images/exercises/hamstring_curl.png',
              ),
              Ejercicio(
                nombre: 'Curl Isquios Tumbado',
                tipo: 'Máquina',
                seriesReps: '4x12',
                descanso: '90 seg',
                urlGif: 'assets/images/exercises/hamstring_curl.png',
              ),
              Ejercicio(
                nombre: 'Hip Thrust Asistido',
                tipo: 'Máquina',
                seriesReps: '3x12',
                descanso: '90 seg',
                urlGif: 'assets/images/exercises/hamstring_curl.png',
              ),
              Ejercicio(
                nombre: 'Elevación de Piernas',
                tipo: 'Peso Corporal',
                seriesReps: '4x20',
                descanso: '60 seg',
                urlGif: 'assets/images/exercises/plank.png',
              ),
            ],
          ),
          DiaRutina(
            nombreDia: 'Día 5 - Full Body',
            ejercicios: [
              Ejercicio(
                nombre: 'Sentadillas Globales',
                tipo: 'Peso Corporal',
                seriesReps: '3x20',
                descanso: '90 seg',
                urlGif: 'assets/images/exercises/squat.png',
              ),
              Ejercicio(
                nombre: 'Flexiones Abiertas',
                tipo: 'Peso Corporal',
                seriesReps: '3x15',
                descanso: '60 seg',
                urlGif: 'assets/images/exercises/pushup.png',
              ),
              Ejercicio(
                nombre: 'Jalón en V',
                tipo: 'Polea',
                seriesReps: '3x12',
                descanso: '90 seg',
                urlGif: 'assets/images/exercises/lat_pulldown.png',
              ),
              Ejercicio(
                nombre: 'Plancha Spiderman',
                tipo: 'Peso Corporal',
                seriesReps: '3x15/lado',
                descanso: '60 seg',
                urlGif: 'assets/images/exercises/plank.png',
              ),
            ],
          ),
        ],
      );

      // 3. Rutina Principiante - Variante 3 Días
      final rutinaPrincipiante3Dias = RutinaAdaptacion(
        id: 'principiante_3_dias',
        variante: '3 Días',
        dias: [
          DiaRutina(
            nombreDia: 'Lunes',
            ejercicios: [
              Ejercicio(
                nombre: 'Banco Cuádriceps',
                tipo: 'Máquina',
                seriesReps: '3x12',
                descanso: '90 seg',
                urlGif: 'assets/RUTINAS/RUTINA_FULL_BODY/DE_3_DIAS/DIA_LUNES/BANCO_CUADRICEPS.mp4',
                instruccion: 'Realiza el movimiento de forma controlada extendiendo las piernas.',
              ),
              Ejercicio(
                nombre: 'Banco Isquiotibiales',
                tipo: 'Máquina',
                seriesReps: '3x12',
                descanso: '90 seg',
                urlGif: 'assets/RUTINAS/RUTINA_FULL_BODY/DE_3_DIAS/DIA_LUNES/BANCO_ISQUIOTIBIALES.mp4',
                instruccion: 'Flexiona las rodillas llevando el rodillo hacia tus glúteos de forma controlada.',
              ),
              Ejercicio(
                nombre: 'Jalón al Pecho',
                tipo: 'Máquina',
                seriesReps: '3x12',
                descanso: '90 seg',
                urlGif: 'assets/RUTINAS/RUTINA_FULL_BODY/DE_3_DIAS/DIA_LUNES/JALON_AL_PECHO.mp4',
                instruccion: 'Leva la barra hacia tu pecho sintiendo el trabajo en los dorsales.',
              ),
              Ejercicio(
                nombre: 'Press Banca Plano',
                tipo: 'Peso Libre',
                seriesReps: '3x10',
                descanso: '90 seg',
                urlGif: 'assets/RUTINAS/RUTINA_FULL_BODY/DE_3_DIAS/DIA_LUNES/PRESS_BANCA_PLANO.mp4',
                instruccion: 'Controla el descenso de la barra al pecho y empuja con fuerza.',
              ),
              Ejercicio(
                nombre: 'Press de Hombro',
                tipo: 'Máquina',
                seriesReps: '3x12',
                descanso: '90 seg',
                urlGif: 'assets/RUTINAS/RUTINA_FULL_BODY/DE_3_DIAS/DIA_LUNES/PRESS_DE_HOMBRO.mp4',
                instruccion: 'Empuja la carga verticalmente sobre tu cabeza de forma controlada.',
              ),
              Ejercicio(
                nombre: 'Press Inclinado con Mancuerna',
                tipo: 'Peso Libre',
                seriesReps: '3x12',
                descanso: '90 seg',
                urlGif: 'assets/RUTINAS/RUTINA_FULL_BODY/DE_3_DIAS/DIA_LUNES/PRESS_INCLINADO_CON_MANCUERNA.mp4',
                instruccion: 'Inclinación de 30-45 grados. Mueve las mancuernas de forma simétrica.',
              ),
              Ejercicio(
                nombre: 'Remo Cerrado',
                tipo: 'Polea',
                seriesReps: '3x12',
                descanso: '90 seg',
                urlGif: 'assets/RUTINAS/RUTINA_FULL_BODY/DE_3_DIAS/DIA_LUNES/REMO_CERRADO.mp4',
                instruccion: 'Tracciona el agarre cerrado hacia tu abdomen bajo con la espalda recta.',
              ),
            ],
          ),
          DiaRutina(
            nombreDia: 'Miércoles',
            ejercicios: [
              Ejercicio(
                nombre: 'Banco Scott',
                tipo: 'Peso Libre',
                seriesReps: '3x12',
                descanso: '90 seg',
                urlGif: 'assets/RUTINAS/RUTINA_FULL_BODY/DE_3_DIAS/DIA_MIERCOLES/BANCO_SCOTT.mp4',
                instruccion: 'Apoya bien los brazos en el banco y realiza la flexión de bíceps sin despegar los codos.',
              ),
              Ejercicio(
                nombre: 'Curl con Mancuerna',
                tipo: 'Peso Libre',
                seriesReps: '3x12',
                descanso: '90 seg',
                urlGif: 'assets/RUTINAS/RUTINA_FULL_BODY/DE_3_DIAS/DIA_MIERCOLES/CURL_CON_MANCUERNA.mp4',
                instruccion: 'Mantén los codos pegados al cuerpo y realiza el curl girando las muñecas.',
              ),
              Ejercicio(
                nombre: 'Curl Isquiotibiales',
                tipo: 'Máquina',
                seriesReps: '3x12',
                descanso: '90 seg',
                urlGif: 'assets/RUTINAS/RUTINA_FULL_BODY/DE_3_DIAS/DIA_MIERCOLES/CURL_ISQUIOTIBIALES.mp4',
                instruccion: 'Contrae los isquiotibiales de forma fluida y regresa lento.',
              ),
              Ejercicio(
                nombre: 'Elevación Gemelos Sentado',
                tipo: 'Máquina',
                seriesReps: '3x15',
                descanso: '60 seg',
                urlGif: 'assets/RUTINAS/RUTINA_FULL_BODY/DE_3_DIAS/DIA_MIERCOLES/ELEVACION_GEMELOS_SENTADO.mp4',
                instruccion: 'Eleva los talones al máximo, sostén un segundo y baja lentamente.',
              ),
              Ejercicio(
                nombre: 'Patada de Tríceps',
                tipo: 'Peso Libre',
                seriesReps: '3x12',
                descanso: '90 seg',
                urlGif: 'assets/RUTINAS/RUTINA_FULL_BODY/DE_3_DIAS/DIA_MIERCOLES/PATADA_DE_TRICEPS.mp4',
                instruccion: 'Mantén el brazo paralelo al suelo y extiende el codo hacia atrás.',
              ),
              Ejercicio(
                nombre: 'Prensa',
                tipo: 'Máquina',
                seriesReps: '3x12',
                descanso: '90 seg',
                urlGif: 'assets/RUTINAS/RUTINA_FULL_BODY/DE_3_DIAS/DIA_MIERCOLES/PRENSA.mp4',
                instruccion: 'Baja las rodillas controladamente y empuja sin bloquear las rodillas.',
              ),
              Ejercicio(
                nombre: 'Tirón en Polea',
                tipo: 'Polea',
                seriesReps: '3x12',
                descanso: '90 seg',
                urlGif: 'assets/RUTINAS/RUTINA_FULL_BODY/DE_3_DIAS/DIA_MIERCOLES/TIRON_EN_POLEA.mp4',
                instruccion: 'Empuja la polea hacia abajo extendiendo completamente los brazos.',
              ),
            ],
          ),
          DiaRutina(
            nombreDia: 'Viernes',
            ejercicios: [
              Ejercicio(
                nombre: 'Abductores',
                tipo: 'Máquina',
                seriesReps: '3x15',
                descanso: '60 seg',
                urlGif: 'assets/RUTINAS/RUTINA_FULL_BODY/DE_3_DIAS/DIA_VIERNES/ABDUCTORES.mp4',
                instruccion: 'Abre las piernas controlando la resistencia de la máquina.',
              ),
              Ejercicio(
                nombre: 'Adductores',
                tipo: 'Máquina',
                seriesReps: '3x15',
                descanso: '60 seg',
                urlGif: 'assets/RUTINAS/RUTINA_FULL_BODY/DE_3_DIAS/DIA_VIERNES/ADDUCTORES.mp4',
                instruccion: 'Cierra las piernas concentrando el esfuerzo en la cara interna del muslo.',
              ),
              Ejercicio(
                nombre: 'Apertura en Máquina',
                tipo: 'Máquina',
                seriesReps: '3x12',
                descanso: '90 seg',
                urlGif: 'assets/RUTINAS/RUTINA_FULL_BODY/DE_3_DIAS/DIA_VIERNES/APERTURA_EN_MAQUINA.mp4',
                instruccion: 'Mantén una ligera flexión de codos y aprieta el pecho al centro.',
              ),
              Ejercicio(
                nombre: 'Sentadilla',
                tipo: 'Peso Libre',
                seriesReps: '3x12',
                descanso: '120 seg',
                urlGif: 'assets/RUTINAS/RUTINA_FULL_BODY/DE_3_DIAS/DIA_VIERNES/SENTADILLA.mp4',
                instruccion: 'Mantén la espalda recta y baja controlando el movimiento hasta romper el paralelo.',
              ),
              Ejercicio(
                nombre: 'Serrucho',
                tipo: 'Peso Libre',
                seriesReps: '3x12',
                descanso: '90 seg',
                urlGif: 'assets/RUTINAS/RUTINA_FULL_BODY/DE_3_DIAS/DIA_VIERNES/SERRUCHO.mp4',
                instruccion: 'Apoya una rodilla y mano. Tracciona la mancuerna hacia tu cadera.',
              ),
              Ejercicio(
                nombre: 'Vuelos Frontales',
                tipo: 'Peso Libre',
                seriesReps: '3x12',
                descanso: '90 seg',
                urlGif: 'assets/RUTINAS/RUTINA_FULL_BODY/DE_3_DIAS/DIA_VIERNES/VUELOS_FRONTALES.mp4',
                instruccion: 'Eleva las mancuernas al frente hasta la altura de tus ojos.',
              ),
              Ejercicio(
                nombre: 'Vuelos Laterales',
                tipo: 'Peso Libre',
                seriesReps: '3x12',
                descanso: '90 seg',
                urlGif: 'assets/RUTINAS/RUTINA_FULL_BODY/DE_3_DIAS/DIA_VIERNES/VUELOS_LATERALES.mp4',
                instruccion: 'Eleva las mancuernas hacia los lados guiando con los codos.',
              ),
            ],
          ),
        ],
      );

      // 4. Rutina Principiante - Variante 5 Días
      final rutinaPrincipiante5Dias = RutinaAdaptacion(
        id: 'principiante_5_dias',
        variante: '5 Días',
        dias: [
          DiaRutina(
            nombreDia: 'Lunes (Pecho)',
            ejercicios: [
              Ejercicio(
                nombre: 'Press de Banca Plano',
                tipo: 'Barra',
                seriesReps: '3x10-12',
                descanso: '90 seg',
                urlGif: 'assets/images/exercises/machine_press.png',
                instruccion:
                    'Bajá la barra al medio del pecho controlando la fase excéntrica y empujá con potencia.',
              ),
              Ejercicio(
                nombre: 'Press Inclinado',
                tipo: 'Mancuernas',
                seriesReps: '3x10-12',
                descanso: '90 seg',
                urlGif: 'assets/images/exercises/machine_press.png',
                instruccion:
                    'Incliná el banco a 30-45 grados. Mantené el abdomen firme para proteger la espalda baja.',
              ),
              Ejercicio(
                nombre: 'Peck Deck',
                tipo: 'Máquina',
                seriesReps: '3x10-12',
                descanso: '60 seg',
                urlGif: 'assets/images/exercises/machine_press.png',
                instruccion:
                    'Mantené los codos ligeramente flexionados, apretando el pecho al frente como en un abrazo.',
              ),
              Ejercicio(
                nombre: 'Cruces',
                tipo: 'Polea',
                seriesReps: '3x10-12',
                descanso: '60 seg',
                urlGif: 'assets/images/exercises/pushup.png',
                instruccion:
                    'Paso firme adelante. Cruzá las manos frente al abdomen sintiendo la contracción torácica.',
              ),
            ],
          ),
          DiaRutina(
            nombreDia: 'Martes (Piernas)',
            ejercicios: [
              Ejercicio(
                nombre: 'Sentadilla',
                tipo: 'Barra',
                seriesReps: '3x10-12',
                descanso: '120 seg',
                urlGif: 'assets/images/exercises/squat.png',
                instruccion:
                    'Espalda recta, pecho arriba. Rompé el paralelo flexionando la cadera hacia atrás y abajo.',
              ),
              Ejercicio(
                nombre: 'Estocadas',
                tipo: 'Mancuerna',
                seriesReps: '3x10-12',
                descanso: '90 seg',
                urlGif: 'assets/images/exercises/lunge.png',
                instruccion:
                    'Paso largo, bajá controlando que la rodilla no pase en exceso la punta de los pies.',
              ),
              Ejercicio(
                nombre: 'Prensa',
                tipo: 'Máquina',
                seriesReps: '3x10-12',
                descanso: '90 seg',
                urlGif: 'assets/images/exercises/leg_press.png',
                instruccion:
                    'Pies bien afirmados. Bajá las rodillas hacia el pecho y empujá con los talones sin bloquear arriba.',
              ),
              Ejercicio(
                nombre: 'Curl Femoral',
                tipo: 'Máquina',
                seriesReps: '3x10-12',
                descanso: '60 seg',
                urlGif: 'assets/images/exercises/hamstring_curl.png',
                instruccion:
                    'Tumbado, contraé el isquiosural arrastrando el peso hacia tus glúteos de forma fluida.',
              ),
            ],
          ),
          DiaRutina(
            nombreDia: 'Miércoles (Espalda)',
            ejercicios: [
              Ejercicio(
                nombre: 'Remo con Barra',
                tipo: 'Barra',
                seriesReps: '3x10-12',
                descanso: '90 seg',
                urlGif: 'assets/images/exercises/dumbbell_row.png',
                instruccion:
                    'Incliná el torso a 45 grados. Tirá de la barra hacia el ombligo juntando las escápulas.',
              ),
              Ejercicio(
                nombre: 'Remo a una Mano',
                tipo: 'Mancuerna',
                seriesReps: '3x10-12',
                descanso: '90 seg',
                urlGif: 'assets/images/exercises/dumbbell_row.png',
                instruccion:
                    'Apoyá rodilla y mano en banco. Traccioná la mancuerna en un arco hacia la cadera.',
              ),
              Ejercicio(
                nombre: 'Jalón al Pecho',
                tipo: 'Polea',
                seriesReps: '3x10-12',
                descanso: '90 seg',
                urlGif: 'assets/images/exercises/lat_pulldown.png',
                instruccion:
                    'Sentado firme, bajá la barra hacia el pecho expandiendo la caja torácica.',
              ),
              Ejercicio(
                nombre: 'Remo Sentado',
                tipo: 'Máquina',
                seriesReps: '3x10-12',
                descanso: '90 seg',
                urlGif: 'assets/images/exercises/dumbbell_row.png',
                instruccion:
                    'Postura vertical estricta. Evitá balancearte con la espalda baja al traccionar el agarre.',
              ),
            ],
          ),
          DiaRutina(
            nombreDia: 'Jueves (Hombros)',
            ejercicios: [
              Ejercicio(
                nombre: 'Press Militar',
                tipo: 'Barra',
                seriesReps: '3x10-12',
                descanso: '120 seg',
                urlGif: 'assets/images/exercises/machine_press.png',
                instruccion:
                    'Sostené la barra sobre la clavícula. Empujá vertical hasta extender brazos cerca de las orejas.',
              ),
              Ejercicio(
                nombre: 'Vuelos Laterales',
                tipo: 'Mancuerna',
                seriesReps: '3x10-12',
                descanso: '60 seg',
                urlGif: 'assets/images/exercises/dumbbell_row.png',
                instruccion:
                    'Movimiento de las mancuernas desde la cadera hacia la altura de los hombros, guiando con los codos.',
              ),
              Ejercicio(
                nombre: 'Press de Hombros',
                tipo: 'Máquina',
                seriesReps: '3x10-12',
                descanso: '90 seg',
                urlGif: 'assets/images/exercises/machine_press.png',
                instruccion:
                    'Sentado correctamente, empujá los agarres hacia el techo con un recorrido completo sin botar.',
              ),
              Ejercicio(
                nombre: 'Facepull',
                tipo: 'Polea',
                seriesReps: '3x10-12',
                descanso: '60 seg',
                urlGif: 'assets/images/exercises/lat_pulldown.png',
                instruccion:
                    'Enganchá una soga y tirá directo hacia el puente de la nariz separando los codos.',
              ),
            ],
          ),
          DiaRutina(
            nombreDia: 'Viernes (Brazos)',
            ejercicios: [
              Ejercicio(
                nombre: 'Curl con Barra',
                tipo: 'Barra',
                seriesReps: '3x10-12',
                descanso: '60 seg',
                urlGif: 'assets/images/exercises/biceps_curl.png',
                instruccion:
                    'Posición firme de torso, flexioná ambos brazos elevando la carga sin impulsar con la cadera.',
              ),
              Ejercicio(
                nombre: 'Curl Alterno',
                tipo: 'Mancuerna',
                seriesReps: '3x10-12',
                descanso: '60 seg',
                urlGif: 'assets/images/exercises/biceps_curl.png',
                instruccion:
                    'Alternando un brazo a la vez. Exprimí el bíceps arriba supindanto la muñeca.',
              ),
              Ejercicio(
                nombre: 'Extensión Invertida',
                tipo: 'Polea',
                seriesReps: '3x10-12',
                descanso: '60 seg',
                urlGif: 'assets/images/exercises/triceps_extension.png',
                instruccion:
                    'Codos encajados en los flancos. Extendé llevando la soga hacia abajo y separando las puntas.',
              ),
              Ejercicio(
                nombre: 'Press Francés',
                tipo: 'Barra',
                seriesReps: '3x10-12',
                descanso: '90 seg',
                urlGif: 'assets/images/exercises/triceps_extension.png',
                instruccion:
                    'Tumbado, bajá la barra tipo Z hacia la frente o justo detrás y finalizá la extensión arriba.',
              ),
            ],
          ),
        ],
      );

      // --- NEW: RUTINAS INTERMEDIAS ---
      final rutinaIntermedia3Dias = RutinaAdaptacion(
        id: 'intermedio_3_dias',
        variante: '3 Días',
        dias: [
          DiaRutina(
            nombreDia: 'Día 1: Fuerza Básica',
            ejercicios: [
              Ejercicio(
                nombre: 'Sentadilla con Barra',
                tipo: 'Barra',
                seriesReps: '4x6-8',
                descanso: '120 seg',
                urlGif: 'assets/images/exercises/squat.png',
                series: '4',
                repeticiones: '6-8',
                tipoDeEquipo: 'Barbell',
                musculoObjetivo: 'Piernas',
              ),
              Ejercicio(
                nombre: 'Press de Banca Plano',
                tipo: 'Barra',
                seriesReps: '4x6-8',
                descanso: '120 seg',
                urlGif: 'assets/images/exercises/machine_press.png',
                series: '4',
                repeticiones: '6-8',
                tipoDeEquipo: 'Barbell',
                musculoObjetivo: 'Pecho',
              ),
              Ejercicio(
                nombre: 'Remo con Barra',
                tipo: 'Barra',
                seriesReps: '4x6-8',
                descanso: '120 seg',
                urlGif: 'assets/images/exercises/dumbbell_row.png',
                series: '4',
                repeticiones: '6-8',
                tipoDeEquipo: 'Barbell',
                musculoObjetivo: 'Espalda',
              ),
              Ejercicio(
                nombre: 'Press Militar',
                tipo: 'Barra',
                seriesReps: '3x8-10',
                descanso: '90 seg',
                urlGif: 'assets/images/exercises/machine_press.png',
                series: '3',
                repeticiones: '8-10',
                tipoDeEquipo: 'Barbell',
                musculoObjetivo: 'Hombros',
              ),
              Ejercicio(
                nombre: 'Plancha Abdominal Lastrada',
                tipo: 'Peso Corporal',
                seriesReps: '3x45-60 seg',
                descanso: '60 seg',
                urlGif: 'assets/images/exercises/plank.png',
                series: '3',
                repeticiones: '45-60 seg',
                tipoDeEquipo: 'Bodyweight',
                musculoObjetivo: 'Core',
              ),
            ],
          ),
          DiaRutina(
            nombreDia: 'Día 2: Máquinas/Aislamiento',
            ejercicios: [
              Ejercicio(
                nombre: 'Prensa de Piernas',
                tipo: 'Máquina',
                seriesReps: '4x10-12',
                descanso: '90 seg',
                urlGif: 'assets/images/exercises/leg_press.png',
                series: '4',
                repeticiones: '10-12',
                tipoDeEquipo: 'Machine',
                musculoObjetivo: 'Piernas',
              ),
              Ejercicio(
                nombre: 'Press Inclinado en Máquina',
                tipo: 'Máquina',
                seriesReps: '3x10-12',
                descanso: '90 seg',
                urlGif: 'assets/images/exercises/machine_press.png',
                series: '3',
                repeticiones: '10-12',
                tipoDeEquipo: 'Machine',
                musculoObjetivo: 'Pecho',
              ),
              Ejercicio(
                nombre: 'Jalón Dorsal',
                tipo: 'Máquina',
                seriesReps: '3x10-12',
                descanso: '90 seg',
                urlGif: 'assets/images/exercises/lat_pulldown.png',
                series: '3',
                repeticiones: '10-12',
                tipoDeEquipo: 'Machine',
                musculoObjetivo: 'Espalda',
              ),
              Ejercicio(
                nombre: 'Extensión de Cuádriceps',
                tipo: 'Máquina',
                seriesReps: '3x15',
                descanso: '60 seg',
                urlGif: 'assets/images/exercises/leg_extension.png',
                series: '3',
                repeticiones: '15',
                tipoDeEquipo: 'Machine',
                musculoObjetivo: 'Cuádriceps',
              ),
              Ejercicio(
                nombre: 'Curl Femoral',
                tipo: 'Máquina',
                seriesReps: '3x15',
                descanso: '60 seg',
                urlGif: 'assets/images/exercises/hamstring_curl.png',
                series: '3',
                repeticiones: '15',
                tipoDeEquipo: 'Machine',
                musculoObjetivo: 'Isquiosurales',
              ),
            ],
          ),
          DiaRutina(
            nombreDia: 'Día 3: Mixto',
            ejercicios: [
              Ejercicio(
                nombre: 'Peso Muerto Rumano',
                tipo: 'Mancuernas',
                seriesReps: '4x8-10',
                descanso: '90 seg',
                urlGif: 'assets/images/exercises/hamstring_curl.png',
                series: '4',
                repeticiones: '8-10',
                tipoDeEquipo: 'Dumbbell',
                musculoObjetivo: 'Isquiosurales, Glúteos',
              ),
              Ejercicio(
                nombre: 'Estocadas Búlgaras',
                tipo: 'Mancuernas',
                seriesReps: '3x10/pierna',
                descanso: '90 seg',
                urlGif: 'assets/images/exercises/lunge.png',
                series: '3',
                repeticiones: '10 / pierna',
                tipoDeEquipo: 'Dumbbell',
                musculoObjetivo: 'Piernas',
              ),
              Ejercicio(
                nombre: 'Press Inclinado con Mancuernas',
                tipo: 'Mancuernas',
                seriesReps: '3x8-10',
                descanso: '90 seg',
                urlGif: 'assets/images/exercises/machine_press.png',
                series: '3',
                repeticiones: '8-10',
                tipoDeEquipo: 'Dumbbell',
                musculoObjetivo: 'Pecho Superior',
              ),
              Ejercicio(
                nombre: 'Dominadas Asistidas o Libres',
                tipo: 'Peso Corporal',
                seriesReps: '3xAl Fallo',
                descanso: '90 seg',
                urlGif: 'assets/images/exercises/lat_pulldown.png',
                series: '3',
                repeticiones: 'Al Fallo',
                tipoDeEquipo: 'Bodyweight',
                musculoObjetivo: 'Espalda',
              ),
              Ejercicio(
                nombre: 'Elevaciones Laterales',
                tipo: 'Mancuernas',
                seriesReps: '4x12-15',
                descanso: '60 seg',
                urlGif: 'assets/images/exercises/dumbbell_row.png',
                series: '4',
                repeticiones: '12-15',
                tipoDeEquipo: 'Dumbbell',
                musculoObjetivo: 'Hombros Laterales',
              ),
            ],
          ),
        ],
      );

      final rutinaIntermedia5Dias = RutinaAdaptacion(
        id: 'intermedio_5_dias',
        variante: '5 Días',
        dias: [
          DiaRutina(
            nombreDia: 'Lunes: Empuje',
            ejercicios: [
              Ejercicio(
                nombre: 'Press de Banca Plano',
                tipo: 'Barra',
                seriesReps: '4x6-8',
                descanso: '120 seg',
                urlGif: 'assets/images/exercises/machine_press.png',
                series: '4',
                repeticiones: '6-8',
                tipoDeEquipo: 'Barbell',
                musculoObjetivo: 'Pecho',
              ),
              Ejercicio(
                nombre: 'Press Militar con Mancuernas',
                tipo: 'Mancuernas',
                seriesReps: '4x8-10',
                descanso: '90 seg',
                urlGif: 'assets/images/exercises/machine_press.png',
                series: '4',
                repeticiones: '8-10',
                tipoDeEquipo: 'Dumbbell',
                musculoObjetivo: 'Hombros',
              ),
              Ejercicio(
                nombre: 'Aperturas Inclinadas',
                tipo: 'Mancuernas',
                seriesReps: '3x12',
                descanso: '60 seg',
                urlGif: 'assets/images/exercises/pushup.png',
                series: '3',
                repeticiones: '12',
                tipoDeEquipo: 'Dumbbell',
                musculoObjetivo: 'Pecho Superior',
              ),
              Ejercicio(
                nombre: 'Elevaciones Laterales en Polea',
                tipo: 'Máquina',
                seriesReps: '4x15',
                descanso: '60 seg',
                urlGif: 'assets/images/exercises/dumbbell_row.png',
                series: '4',
                repeticiones: '15',
                tipoDeEquipo: 'Machine',
                musculoObjetivo: 'Hombros Laterales',
              ),
              Ejercicio(
                nombre: 'Extensión Invertida Tríceps',
                tipo: 'Máquina',
                seriesReps: '3x12',
                descanso: '60 seg',
                urlGif: 'assets/images/exercises/triceps_extension.png',
                series: '3',
                repeticiones: '12',
                tipoDeEquipo: 'Machine',
                musculoObjetivo: 'Tríceps',
              ),
            ],
          ),
          DiaRutina(
            nombreDia: 'Martes: Tirón',
            ejercicios: [
              Ejercicio(
                nombre: 'Dominadas / Jalón al Pecho',
                tipo: 'Máquina',
                seriesReps: '4x8-10',
                descanso: '120 seg',
                urlGif: 'assets/images/exercises/lat_pulldown.png',
                series: '4',
                repeticiones: '8-10',
                tipoDeEquipo: 'Bodyweight o Machine',
                musculoObjetivo: 'Espalda',
              ),
              Ejercicio(
                nombre: 'Remo con Barra',
                tipo: 'Barra',
                seriesReps: '4x8-10',
                descanso: '90 seg',
                urlGif: 'assets/images/exercises/dumbbell_row.png',
                series: '4',
                repeticiones: '8-10',
                tipoDeEquipo: 'Barbell',
                musculoObjetivo: 'Espalda Baja',
              ),
              Ejercicio(
                nombre: 'Remo a una mano',
                tipo: 'Mancuerna',
                seriesReps: '3x10-12',
                descanso: '90 seg',
                urlGif: 'assets/images/exercises/dumbbell_row.png',
                series: '3',
                repeticiones: '10-12',
                tipoDeEquipo: 'Dumbbell',
                musculoObjetivo: 'Dorsales',
              ),
              Ejercicio(
                nombre: 'Facepull',
                tipo: 'Máquina',
                seriesReps: '3x15',
                descanso: '60 seg',
                urlGif: 'assets/images/exercises/lat_pulldown.png',
                series: '3',
                repeticiones: '15',
                tipoDeEquipo: 'Machine',
                musculoObjetivo: 'Deltoides posterior',
              ),
              Ejercicio(
                nombre: 'Curl de Bíceps Alternado',
                tipo: 'Mancueras',
                seriesReps: '3x12',
                descanso: '60 seg',
                urlGif: 'assets/images/exercises/biceps_curl.png',
                series: '3',
                repeticiones: '12',
                tipoDeEquipo: 'Dumbbell',
                musculoObjetivo: 'Bíceps',
              ),
            ],
          ),
          DiaRutina(
            nombreDia: 'Miércoles: Pierna',
            ejercicios: [
              Ejercicio(
                nombre: 'Sentadilla Libre',
                tipo: 'Barra',
                seriesReps: '4x6-8',
                descanso: '120 seg',
                urlGif: 'assets/images/exercises/squat.png',
                series: '4',
                repeticiones: '6-8',
                tipoDeEquipo: 'Barbell',
                musculoObjetivo: 'Cuádriceps, Glúteos',
              ),
              Ejercicio(
                nombre: 'Prensa',
                tipo: 'Máquina',
                seriesReps: '4x10-12',
                descanso: '90 seg',
                urlGif: 'assets/images/exercises/leg_press.png',
                series: '4',
                repeticiones: '10-12',
                tipoDeEquipo: 'Machine',
                musculoObjetivo: 'Piernas',
              ),
              Ejercicio(
                nombre: 'Peso Muerto Rumano',
                tipo: 'Barra',
                seriesReps: '3x8-10',
                descanso: '90 seg',
                urlGif: 'assets/images/exercises/hamstring_curl.png',
                series: '3',
                repeticiones: '8-10',
                tipoDeEquipo: 'Barbell',
                musculoObjetivo: 'Isquiosurales',
              ),
              Ejercicio(
                nombre: 'Elevación de Talones a un Pie',
                tipo: 'Mancuerna',
                seriesReps: '4x15',
                descanso: '60 seg',
                urlGif: 'assets/images/exercises/squat.png',
                series: '4',
                repeticiones: '15',
                tipoDeEquipo: 'Dumbbell',
                musculoObjetivo: 'Pantorrillas',
              ),
            ],
          ),
          DiaRutina(
            nombreDia: 'Jueves: Torso Hipertrofia',
            ejercicios: [
              Ejercicio(
                nombre: 'Press Inclinado con Mancuernas',
                tipo: 'Mancuernas',
                seriesReps: '4x8-10',
                descanso: '90 seg',
                urlGif: 'assets/images/exercises/machine_press.png',
                series: '4',
                repeticiones: '8-10',
                tipoDeEquipo: 'Dumbbell',
                musculoObjetivo: 'Pecho Superior',
              ),
              Ejercicio(
                nombre: 'Remo en Máquina',
                tipo: 'Máquina',
                seriesReps: '4x10-12',
                descanso: '90 seg',
                urlGif: 'assets/images/exercises/dumbbell_row.png',
                series: '4',
                repeticiones: '10-12',
                tipoDeEquipo: 'Machine',
                musculoObjetivo: 'Espalda Central',
              ),
              Ejercicio(
                nombre: 'Press Militar Máquina',
                tipo: 'Máquina',
                seriesReps: '3x10-12',
                descanso: '90 seg',
                urlGif: 'assets/images/exercises/machine_press.png',
                series: '3',
                repeticiones: '10-12',
                tipoDeEquipo: 'Machine',
                musculoObjetivo: 'Hombros',
              ),
              Ejercicio(
                nombre: 'Curl de Bíceps en Polea',
                tipo: 'Máquina',
                seriesReps: '3x12-15',
                descanso: '60 seg',
                urlGif: 'assets/images/exercises/biceps_curl.png',
                series: '3',
                repeticiones: '12-15',
                tipoDeEquipo: 'Machine',
                musculoObjetivo: 'Bíceps',
              ),
              Ejercicio(
                nombre: 'Press Francés con Mancuerna',
                tipo: 'Mancuerna',
                seriesReps: '3x12-15',
                descanso: '60 seg',
                urlGif: 'assets/images/exercises/triceps_extension.png',
                series: '3',
                repeticiones: '12-15',
                tipoDeEquipo: 'Dumbbell',
                musculoObjetivo: 'Tríceps',
              ),
            ],
          ),
          DiaRutina(
            nombreDia: 'Viernes: Pierna/Glúteo',
            ejercicios: [
              Ejercicio(
                nombre: 'Hip Thrust',
                tipo: 'Barra',
                seriesReps: '4x8-10',
                descanso: '120 seg',
                urlGif: 'assets/images/exercises/lunge.png',
                series: '4',
                repeticiones: '8-10',
                tipoDeEquipo: 'Barbell',
                musculoObjetivo: 'Glúteos',
              ),
              Ejercicio(
                nombre: 'Sentadilla Búlgara',
                tipo: 'Mancuerna',
                seriesReps: '3x10/pierna',
                descanso: '90 seg',
                urlGif: 'assets/images/exercises/lunge.png',
                series: '3',
                repeticiones: '10 / pierna',
                tipoDeEquipo: 'Dumbbell',
                musculoObjetivo: 'Piernas',
              ),
              Ejercicio(
                nombre: 'Extensión de Cuádriceps',
                tipo: 'Máquina',
                seriesReps: '4x15',
                descanso: '60 seg',
                urlGif: 'assets/images/exercises/leg_extension.png',
                series: '4',
                repeticiones: '15',
                tipoDeEquipo: 'Machine',
                musculoObjetivo: 'Cuádriceps',
              ),
              Ejercicio(
                nombre: 'Curl Femoral Sentado',
                tipo: 'Máquina',
                seriesReps: '4x15',
                descanso: '60 seg',
                urlGif: 'assets/images/exercises/hamstring_curl.png',
                series: '4',
                repeticiones: '15',
                tipoDeEquipo: 'Machine',
                musculoObjetivo: 'Isquiosurales',
              ),
            ],
          ),
        ],
      );

      // --- RUTINA AVANZADA (PITBULL AVANZADO - 6 DÍAS) ---
      final rutinaArnoldSplit = RutinaAdaptacion(
        id: 'arnold_split_advanced',
        variante: '6 Días/Semana',
        level: 'advanced',
        tags: ['pitbull_avanzado', 'advanced', '6-days', 'arnold'],
        dias: [
          DiaRutina(
            nombreDia: 'Lunes',
            ejercicios: [
              Ejercicio(
                nombre: 'PRESS BANCA PLANO',
                tipo: 'Peso Libre',
                seriesReps: '4x8-10',
                descanso: '90 seg',
                urlGif:
                    'assets/RUTINAS/RUTINA_AVANZADO/PITBULL_AVANZADO/DE_6_DIAS/DIA_LUNES/1_PRESS_BANCA_PLANO.mp4',
                instruccion:
                    'Mantené la espalda apoyada, bajá la barra controlando el movimiento al pecho y empujá con fuerza.',
                series: '4',
                repeticiones: '8-10',
                tipoDeEquipo: 'Barbell',
                musculoObjetivo: 'Pecho',
              ),
              Ejercicio(
                nombre: 'PRESS MAQUINA CONVERGENTE',
                tipo: 'Máquina',
                seriesReps: '4x10-12',
                descanso: '90 seg',
                urlGif:
                    'assets/RUTINAS/RUTINA_AVANZADO/PITBULL_AVANZADO/DE_6_DIAS/DIA_LUNES/2_PRESS_MAQUINA_CONVERGENTE.mp4',
                instruccion:
                    'Ajustá la altura del asiento y empujá convergentemente contrayendo el pectoral en el punto máximo.',
                series: '4',
                repeticiones: '10-12',
                tipoDeEquipo: 'Machine',
                musculoObjetivo: 'Pecho',
              ),
              Ejercicio(
                nombre: 'PRESS INCLINADO CON MANCUERNA',
                tipo: 'Mancuernas',
                seriesReps: '4x10-12',
                descanso: '90 seg',
                urlGif:
                    'assets/RUTINAS/RUTINA_AVANZADO/PITBULL_AVANZADO/DE_6_DIAS/DIA_LUNES/3_PRESS_INCLINADO_CON_MANCUERNA.mp4',
                instruccion:
                    'Banco inclinado a 30-45 grados. Bajá controlando las mancuernas y empujá de forma simétrica.',
                series: '4',
                repeticiones: '10-12',
                tipoDeEquipo: 'Dumbbell',
                musculoObjetivo: 'Pecho Superior',
              ),
              Ejercicio(
                nombre: 'APERTURA EN MAQUINA',
                tipo: 'Máquina',
                seriesReps: '3x12-15',
                descanso: '60 seg',
                urlGif:
                    'assets/RUTINAS/RUTINA_AVANZADO/PITBULL_AVANZADO/DE_6_DIAS/DIA_LUNES/4_APERTURA_EN_MAQUINA.mp4',
                instruccion:
                    'Mantené los codos ligeramente flexionados, abrí sintiendo el estiramiento y cerrá apretando el pecho.',
                series: '3',
                repeticiones: '12-15',
                tipoDeEquipo: 'Machine',
                musculoObjetivo: 'Pecho',
              ),
              Ejercicio(
                nombre: 'FLEXIONES DE BRAZOS',
                tipo: 'Peso Corporal',
                seriesReps: '3xFallo',
                descanso: '60 seg',
                urlGif:
                    'assets/RUTINAS/RUTINA_AVANZADO/PITBULL_AVANZADO/DE_6_DIAS/DIA_LUNES/5_FLEXIONES_DE_BRAZOS.mp4',
                instruccion:
                    'Cuerpo completamente alineado. Descendé hasta rozar el suelo y empujá explosivamente.',
                series: '3',
                repeticiones: 'Fallo',
                tipoDeEquipo: 'Bodyweight',
                musculoObjetivo: 'Pecho / Tríceps',
              ),
              Ejercicio(
                nombre: 'PRESS FRANCES',
                tipo: 'Peso Libre',
                seriesReps: '4x10-12',
                descanso: '90 seg',
                urlGif:
                    'assets/RUTINAS/RUTINA_AVANZADO/PITBULL_AVANZADO/DE_6_DIAS/DIA_LUNES/6_PRESS_FRANCES.mp4',
                instruccion:
                    'Acostado en banco, codos apuntando al techo fijos. Flexioná antebrazos hacia la frente y extendé.',
                series: '4',
                repeticiones: '10-12',
                tipoDeEquipo: 'Barbell',
                musculoObjetivo: 'Tríceps',
              ),
              Ejercicio(
                nombre: 'EXTENSION EN POLEA CON CUERDA',
                tipo: 'Polea',
                seriesReps: '4x12-15',
                descanso: '60 seg',
                urlGif:
                    'assets/RUTINAS/RUTINA_AVANZADO/PITBULL_AVANZADO/DE_6_DIAS/DIA_LUNES/7_EXTENSION_EN_POLEA_CON_CUERDA.mp4',
                instruccion:
                    'Codos pegados a los costados. Empujá hacia abajo y abrí la cuerda al final del recorrido.',
                series: '4',
                repeticiones: '12-15',
                tipoDeEquipo: 'Cable',
                musculoObjetivo: 'Tríceps',
              ),
              Ejercicio(
                nombre: 'EXTENSION UNILATERAL',
                tipo: 'Polea',
                seriesReps: '3x12',
                descanso: '60 seg',
                urlGif:
                    'assets/RUTINAS/RUTINA_AVANZADO/PITBULL_AVANZADO/DE_6_DIAS/DIA_LUNES/8_EXTENSION_UNILATERAL.mp4',
                instruccion:
                    'Trabajá un brazo a la vez focalizando en la contracción individual de cada tríceps.',
                series: '3',
                repeticiones: '12',
                tipoDeEquipo: 'Cable',
                musculoObjetivo: 'Tríceps',
              ),
            ],
          ),
          DiaRutina(
            nombreDia: 'Martes',
            ejercicios: [
              Ejercicio(
                nombre: 'DOMINADAS',
                tipo: 'Peso Corporal',
                seriesReps: '4x6-10',
                descanso: '90-120 seg',
                urlGif:
                    'assets/RUTINAS/RUTINA_AVANZADO/PITBULL_AVANZADO/DE_6_DIAS/DIA_MARTES/1_DOMINADAS.mp4',
                instruccion:
                    'Colgate de la barra con agarre amplio. Traccioná con los dorsales hasta superar la barra con el mentón.',
                series: '4',
                repeticiones: '6-10',
                tipoDeEquipo: 'Bodyweight',
                musculoObjetivo: 'Espalda / Dorsales',
              ),
              Ejercicio(
                nombre: 'REMO ABIERTO',
                tipo: 'Máquina / Barra',
                seriesReps: '4x10-12',
                descanso: '90 seg',
                urlGif:
                    'assets/RUTINAS/RUTINA_AVANZADO/PITBULL_AVANZADO/DE_6_DIAS/DIA_MARTES/2_REMO_ABIERTO.mp4',
                instruccion:
                    'Agarre ancho pronado. Llevá los codos hacia atrás enfatizando la parte alta y media de la espalda.',
                series: '4',
                repeticiones: '10-12',
                tipoDeEquipo: 'Machine',
                musculoObjetivo: 'Espalda Alta',
              ),
              Ejercicio(
                nombre: 'JALON AL PECHO',
                tipo: 'Polea',
                seriesReps: '4x10-12',
                descanso: '90 seg',
                urlGif:
                    'assets/RUTINAS/RUTINA_AVANZADO/PITBULL_AVANZADO/DE_6_DIAS/DIA_MARTES/3_JALON_AL_PECHO.mp4',
                instruccion:
                    'Tirá de la barra hacia la parte alta del pecho retrayendo activamente las escápulas.',
                series: '4',
                repeticiones: '10-12',
                tipoDeEquipo: 'Cable',
                musculoObjetivo: 'Dorsales',
              ),
              Ejercicio(
                nombre: 'REMO CERRADO',
                tipo: 'Polea',
                seriesReps: '4x10-12',
                descanso: '90 seg',
                urlGif:
                    'assets/RUTINAS/RUTINA_AVANZADO/PITBULL_AVANZADO/DE_6_DIAS/DIA_MARTES/4_REMO_CERRADO.mp4',
                instruccion:
                    'Espalda neutra, traccioná el agarre hacia el abdomen manteniendo los codos pegados al cuerpo.',
                series: '4',
                repeticiones: '10-12',
                tipoDeEquipo: 'Cable',
                musculoObjetivo: 'Espalda Media',
              ),
              Ejercicio(
                nombre: 'PULLOVER EN POLEA',
                tipo: 'Polea',
                seriesReps: '3x12-15',
                descanso: '60 seg',
                urlGif:
                    'assets/RUTINAS/RUTINA_AVANZADO/PITBULL_AVANZADO/DE_6_DIAS/DIA_MARTES/5_PULLOVER_EN_POLEA.mp4',
                instruccion:
                    'Brazos casi rectos, descendé la barra hacia los muslos sintiendo la contracción dorsal.',
                series: '3',
                repeticiones: '12-15',
                tipoDeEquipo: 'Cable',
                musculoObjetivo: 'Dorsales',
              ),
              Ejercicio(
                nombre: 'CURL BICEPS',
                tipo: 'Barra / Mancuerna',
                seriesReps: '4x10-12',
                descanso: '60-90 seg',
                urlGif:
                    'assets/RUTINAS/RUTINA_AVANZADO/PITBULL_AVANZADO/DE_6_DIAS/DIA_MARTES/6_CURL_BICEPS.mp4',
                instruccion:
                    'Codos inmóviles junto al torso. Flexioná contrayendo el bíceps sin impulsos.',
                series: '4',
                repeticiones: '10-12',
                tipoDeEquipo: 'Barbell',
                musculoObjetivo: 'Bíceps',
              ),
              Ejercicio(
                nombre: 'CURL CON MANCUERNA',
                tipo: 'Mancuernas',
                seriesReps: '4x10-12',
                descanso: '60 seg',
                urlGif:
                    'assets/RUTINAS/RUTINA_AVANZADO/PITBULL_AVANZADO/DE_6_DIAS/DIA_MARTES/7_CURL_CON_MANCUERNA.mp4',
                instruccion:
                    'Subí de forma alterna o simultánea supinando la muñeca en la fase concéntrica.',
                series: '4',
                repeticiones: '10-12',
                tipoDeEquipo: 'Dumbbell',
                musculoObjetivo: 'Bíceps',
              ),
              Ejercicio(
                nombre: 'CURL PREDICADOR',
                tipo: 'Máquina / Banco Scott',
                seriesReps: '3x12-15',
                descanso: '60 seg',
                urlGif:
                    'assets/RUTINAS/RUTINA_AVANZADO/PITBULL_AVANZADO/DE_6_DIAS/DIA_MARTES/8_CURL_PREDICADOR.mp4',
                instruccion:
                    'Brazos completamente apoyados sobre el cojín para aislar y evitar compensaciones.',
                series: '3',
                repeticiones: '12-15',
                tipoDeEquipo: 'Machine',
                musculoObjetivo: 'Bíceps Aislado',
              ),
            ],
          ),
          DiaRutina(
            nombreDia: 'Miércoles',
            ejercicios: [
              Ejercicio(
                nombre: 'SENTADILLA',
                tipo: 'Peso Libre',
                seriesReps: '4x8-10',
                descanso: '120 seg',
                urlGif:
                    'assets/RUTINAS/RUTINA_AVANZADO/PITBULL_AVANZADO/DE_6_DIAS/DIA_MIERCOLES/1_SENTADILLA.mp4',
                instruccion:
                    'Barra sobre trapecios, descendé controladamente rompiendo el paralelo y subí empujando con fuerza.',
                series: '4',
                repeticiones: '8-10',
                tipoDeEquipo: 'Barbell',
                musculoObjetivo: 'Cuádriceps / Glúteos',
              ),
              Ejercicio(
                nombre: 'PRENSA',
                tipo: 'Máquina',
                seriesReps: '4x10-12',
                descanso: '90-120 seg',
                urlGif:
                    'assets/RUTINAS/RUTINA_AVANZADO/PITBULL_AVANZADO/DE_6_DIAS/DIA_MIERCOLES/2_PRENSA.mp4',
                instruccion:
                    'Pies al ancho de hombros, bajá hasta 90 grados y empujá con los talones sin bloquear rodillas.',
                series: '4',
                repeticiones: '10-12',
                tipoDeEquipo: 'Machine',
                musculoObjetivo: 'Piernas Completo',
              ),
              Ejercicio(
                nombre: 'SENTADILLA HACK',
                tipo: 'Máquina',
                seriesReps: '4x10-12',
                descanso: '90-120 seg',
                urlGif:
                    'assets/RUTINAS/RUTINA_AVANZADO/PITBULL_AVANZADO/DE_6_DIAS/DIA_MIERCOLES/3_SENTADILLA_HACK.mp4',
                instruccion:
                    'Espalda bien apoyada en el respaldo, bajá profundo focalizando el trabajo en los cuádriceps.',
                series: '4',
                repeticiones: '10-12',
                tipoDeEquipo: 'Machine',
                musculoObjetivo: 'Cuádriceps',
              ),
              Ejercicio(
                nombre: 'BANCO CUADRICEPS',
                tipo: 'Máquina',
                seriesReps: '4x12-15',
                descanso: '60-90 seg',
                urlGif:
                    'assets/RUTINAS/RUTINA_AVANZADO/PITBULL_AVANZADO/DE_6_DIAS/DIA_MIERCOLES/4_BANCO_CUADRICEPS.mp4',
                instruccion:
                    'Extendé las rodillas completamente aguantando un segundo arriba para máxima congestión.',
                series: '4',
                repeticiones: '12-15',
                tipoDeEquipo: 'Machine',
                musculoObjetivo: 'Cuádriceps Aislado',
              ),
              Ejercicio(
                nombre: 'ELEVACION GEMELOS SENTADO',
                tipo: 'Máquina',
                seriesReps: '4x15-20',
                descanso: '60 seg',
                urlGif:
                    'assets/RUTINAS/RUTINA_AVANZADO/PITBULL_AVANZADO/DE_6_DIAS/DIA_MIERCOLES/5_ELEVACION_GEMELOS_SENTADO.mp4',
                instruccion:
                    'Rango de recorrido completo, estirá bien abajo y contraé con fuerza los gemelos arriba.',
                series: '4',
                repeticiones: '15-20',
                tipoDeEquipo: 'Machine',
                musculoObjetivo: 'Sóleo / Gemelos',
              ),
            ],
          ),
          DiaRutina(
            nombreDia: 'Jueves',
            ejercicios: [
              Ejercicio(
                nombre: 'PRESS DE HOMBRO',
                tipo: 'Mancuernas / Máquina',
                seriesReps: '4x8-10',
                descanso: '90-120 seg',
                urlGif:
                    'assets/RUTINAS/RUTINA_AVANZADO/PITBULL_AVANZADO/DE_6_DIAS/DIA_JUEVES/1_PRESS_DE_HOMBRO.mp4',
                instruccion:
                    'Espalda recta, empujá sobre la cabeza de manera controlada y bajá a la altura de las orejas.',
                series: '4',
                repeticiones: '8-10',
                tipoDeEquipo: 'Dumbbell',
                musculoObjetivo: 'Deltoides Anterior',
              ),
              Ejercicio(
                nombre: 'VUELOS LATERALES',
                tipo: 'Mancuernas',
                seriesReps: '4x12-15',
                descanso: '60 seg',
                urlGif:
                    'assets/RUTINAS/RUTINA_AVANZADO/PITBULL_AVANZADO/DE_6_DIAS/DIA_JUEVES/2_VUELOS_LATERALES.mp4',
                instruccion:
                    'Elevá los brazos lateralmente con codos ligeramente flexionados hasta la línea del hombro.',
                series: '4',
                repeticiones: '12-15',
                tipoDeEquipo: 'Dumbbell',
                musculoObjetivo: 'Deltoides Lateral',
              ),
              Ejercicio(
                nombre: 'VUELOS FRONTALES',
                tipo: 'Mancuernas / Polea',
                seriesReps: '4x12-15',
                descanso: '60 seg',
                urlGif:
                    'assets/RUTINAS/RUTINA_AVANZADO/PITBULL_AVANZADO/DE_6_DIAS/DIA_JUEVES/3_VUELOS_FRONTALES.mp4',
                instruccion:
                    'Elevá hacia adelante hasta la altura de los ojos manteniendo el torso quieto.',
                series: '4',
                repeticiones: '12-15',
                tipoDeEquipo: 'Dumbbell',
                musculoObjetivo: 'Deltoides Anterior',
              ),
              Ejercicio(
                nombre: 'VUELOS POSTERIORES',
                tipo: 'Mancuernas / Máquina',
                seriesReps: '4x12-15',
                descanso: '60 seg',
                urlGif:
                    'assets/RUTINAS/RUTINA_AVANZADO/PITBULL_AVANZADO/DE_6_DIAS/DIA_JUEVES/4_VUELOS_POSTERIORES.mp4',
                instruccion:
                    'Con el torso inclinado hacia adelante, abrí los brazos focalizando en la parte posterior del hombro.',
                series: '4',
                repeticiones: '12-15',
                tipoDeEquipo: 'Dumbbell',
                musculoObjetivo: 'Deltoides Posterior',
              ),
              Ejercicio(
                nombre: 'ENCOGIMIENTOS DE HOMBROS',
                tipo: 'Mancuernas / Barra',
                seriesReps: '4x12-15',
                descanso: '60 seg',
                urlGif:
                    'assets/RUTINAS/RUTINA_AVANZADO/PITBULL_AVANZADO/DE_6_DIAS/DIA_JUEVES/5_ENCOGIMIENTOS_DE_HOMBROS.mp4',
                instruccion:
                    'Elevá los hombros en dirección vertical hacia las orejas apretando los trapecios por un segundo.',
                series: '4',
                repeticiones: '12-15',
                tipoDeEquipo: 'Dumbbell',
                musculoObjetivo: 'Trapecios',
              ),
            ],
          ),
          DiaRutina(
            nombreDia: 'Viernes',
            ejercicios: [
              Ejercicio(
                nombre: 'PESO MUERTO CON BARRA',
                tipo: 'Peso Libre',
                seriesReps: '4x6-8',
                descanso: '120 seg',
                urlGif:
                    'assets/RUTINAS/RUTINA_AVANZADO/PITBULL_AVANZADO/DE_6_DIAS/DIA_VIERNES/1_PESO_MUERTO_CON_BARRA.mp4',
                instruccion:
                    'Espalda firme y neutra. Levantá la barra desde el suelo empujando con piernas y glúteos.',
                series: '4',
                repeticiones: '6-8',
                tipoDeEquipo: 'Barbell',
                musculoObjetivo: 'Cadena Posterior / Espalda',
              ),
              Ejercicio(
                nombre: 'REMO EN BARRA',
                tipo: 'Peso Libre',
                seriesReps: '4x8-10',
                descanso: '90 seg',
                urlGif:
                    'assets/RUTINAS/RUTINA_AVANZADO/PITBULL_AVANZADO/DE_6_DIAS/DIA_VIERNES/2_REMO_EN_BARRA.mp4',
                instruccion:
                    'Torso inclinado a 45 grados, tirá de la barra hacia la cintura apretando los dorsales.',
                series: '4',
                repeticiones: '8-10',
                tipoDeEquipo: 'Barbell',
                musculoObjetivo: 'Dorsales / Espalda Media',
              ),
              Ejercicio(
                nombre: 'SERRUCHO',
                tipo: 'Mancuernas',
                seriesReps: '4x10-12',
                descanso: '60-90 seg',
                urlGif:
                    'assets/RUTINAS/RUTINA_AVANZADO/PITBULL_AVANZADO/DE_6_DIAS/DIA_VIERNES/3_SERRUCHO.mp4',
                instruccion:
                    'Mano y rodilla apoyadas en el banco. Traccioná la mancuerna hacia tu cadera.',
                series: '4',
                repeticiones: '10-12',
                tipoDeEquipo: 'Dumbbell',
                musculoObjetivo: 'Dorsal Unilateral',
              ),
              Ejercicio(
                nombre: 'CURL BICEPS BARRA EZ',
                tipo: 'Barra EZ',
                seriesReps: '4x10-12',
                descanso: '60 seg',
                urlGif:
                    'assets/RUTINAS/RUTINA_AVANZADO/PITBULL_AVANZADO/DE_6_DIAS/DIA_VIERNES/4_CURL_BICEPS_BARRA_EZ.mp4',
                instruccion:
                    'Agarre cómodo angulado, flexioná los antebrazos focalizando en el bíceps braquial.',
                series: '4',
                repeticiones: '10-12',
                tipoDeEquipo: 'Barbell',
                musculoObjetivo: 'Bíceps',
              ),
              Ejercicio(
                nombre: 'CURL MARTILLO',
                tipo: 'Mancuernas',
                seriesReps: '4x10-12',
                descanso: '60 seg',
                urlGif:
                    'assets/RUTINAS/RUTINA_AVANZADO/PITBULL_AVANZADO/DE_6_DIAS/DIA_VIERNES/5_CURL_MARTILLO.mp4',
                instruccion:
                    'Palmas enfrentadas (agarre neutro). Elevá controladamente trabajando braquiorradial y bíceps.',
                series: '4',
                repeticiones: '10-12',
                tipoDeEquipo: 'Dumbbell',
                musculoObjetivo: 'Braquial / Antebrazo',
              ),
              Ejercicio(
                nombre: 'PRESS CERRADO',
                tipo: 'Peso Libre',
                seriesReps: '4x8-10',
                descanso: '90 seg',
                urlGif:
                    'assets/RUTINAS/RUTINA_AVANZADO/PITBULL_AVANZADO/DE_6_DIAS/DIA_VIERNES/6_PRESS_CERRADO.mp4',
                instruccion:
                    'Agarre cerrado al ancho de hombros en banca plana, bajá los codos pegados al cuerpo y empujá con tríceps.',
                series: '4',
                repeticiones: '8-10',
                tipoDeEquipo: 'Barbell',
                musculoObjetivo: 'Tríceps / Pecho',
              ),
              Ejercicio(
                nombre: 'TIRON EN POLEA',
                tipo: 'Polea',
                seriesReps: '4x12-15',
                descanso: '60 seg',
                urlGif:
                    'assets/RUTINAS/RUTINA_AVANZADO/PITBULL_AVANZADO/DE_6_DIAS/DIA_VIERNES/7_TIRON_EN_POLEA.mp4',
                instruccion:
                    'Codos firmes a los lados, extendé los brazos empujando la barra o cuerda hacia abajo.',
                series: '4',
                repeticiones: '12-15',
                tipoDeEquipo: 'Cable',
                musculoObjetivo: 'Tríceps',
              ),
            ],
          ),
          DiaRutina(
            nombreDia: 'Sábado',
            ejercicios: [
              Ejercicio(
                nombre: 'PESO MUERTO CON BARRA',
                tipo: 'Peso Libre',
                seriesReps: '4x8-10',
                descanso: '120 seg',
                urlGif:
                    'assets/RUTINAS/RUTINA_AVANZADO/PITBULL_AVANZADO/DE_6_DIAS/DIA_SABADO/1_PESO_MUERTO_CON_BARRA.mp4',
                instruccion:
                    'Enfoque en la bisagra de cadera y tensión en femorales y glúteos.',
                series: '4',
                repeticiones: '8-10',
                tipoDeEquipo: 'Barbell',
                musculoObjetivo: 'Isquiotibiales / Glúteos',
              ),
              Ejercicio(
                nombre: 'ESTOCADAS',
                tipo: 'Mancuernas',
                seriesReps: '4x10-12',
                descanso: '90 seg',
                urlGif:
                    'assets/RUTINAS/RUTINA_AVANZADO/PITBULL_AVANZADO/DE_6_DIAS/DIA_SABADO/2_ESTOCADAS.mp4',
                instruccion:
                    'Paso firme al frente, bajá verticalmente hasta que la rodilla trasera casi toque el piso.',
                series: '4',
                repeticiones: '10-12 por pierna',
                tipoDeEquipo: 'Dumbbell',
                musculoObjetivo: 'Cuádriceps / Glúteos',
              ),
              Ejercicio(
                nombre: 'HIP THRUST CON BARRA',
                tipo: 'Peso Libre',
                seriesReps: '4x10-12',
                descanso: '90-120 seg',
                urlGif:
                    'assets/RUTINAS/RUTINA_AVANZADO/PITBULL_AVANZADO/DE_6_DIAS/DIA_SABADO/3_HIP_THUST_CON_BARRA.mp4',
                instruccion:
                    'Apoyá la espalda alta en el banco, elevá la cadera y apretá los glúteos al máximo arriba.',
                series: '4',
                repeticiones: '10-12',
                tipoDeEquipo: 'Barbell',
                musculoObjetivo: 'Glúteos',
              ),
              Ejercicio(
                nombre: 'ISQUIOTIBIALES ACOSTADO',
                tipo: 'Máquina',
                seriesReps: '4x12-15',
                descanso: '60-90 seg',
                urlGif:
                    'assets/RUTINAS/RUTINA_AVANZADO/PITBULL_AVANZADO/DE_6_DIAS/DIA_SABADO/4_ISQUIOTIBIALES_ACOSTADO.mp4',
                instruccion:
                    'Boca abajo en la máquina, flexioná las rodillas llevando el rodillo a los glúteos de forma controlada.',
                series: '4',
                repeticiones: '12-15',
                tipoDeEquipo: 'Machine',
                musculoObjetivo: 'Isquiosurales',
              ),
              Ejercicio(
                nombre: 'BANCO ISQUIOTIBIALES',
                tipo: 'Máquina',
                seriesReps: '4x12-15',
                descanso: '60-90 seg',
                urlGif:
                    'assets/RUTINAS/RUTINA_AVANZADO/PITBULL_AVANZADO/DE_6_DIAS/DIA_SABADO/5_BANCO_ISQUIOTIBIALES.mp4',
                instruccion:
                    'Ajustá el banco y flexioná concentrando el esfuerzo en los femorales sin levantar la cadera.',
                series: '4',
                repeticiones: '12-15',
                tipoDeEquipo: 'Machine',
                musculoObjetivo: 'Isquiosurales',
              ),
              Ejercicio(
                nombre: 'PRESS GEMELOS',
                tipo: 'Máquina / Prensa',
                seriesReps: '4x15-20',
                descanso: '60 seg',
                urlGif:
                    'assets/RUTINAS/RUTINA_AVANZADO/PITBULL_AVANZADO/DE_6_DIAS/DIA_SABADO/6_PRESS_GEMELOS.mp4',
                instruccion:
                    'Puntas de los pies en el borde de la plataforma, empujá con los tobillos y mantené un segundo la contracción.',
                series: '4',
                repeticiones: '15-20',
                tipoDeEquipo: 'Machine',
                musculoObjetivo: 'Gemelos',
              ),
            ],
          ),
        ],
      );

      // Borrar todas las rutinas existentes para evitar duplicados o IDs viejos
      final snapshot = await collection.get();
      final batchDelete = db.batch();
      for (var doc in snapshot.docs) {
        batchDelete.delete(doc.reference);
      }
      await batchDelete.commit();

      // Usamos SetOptions(merge: true) sugeridamente de acá en adelante si se quisiera no pisar estado local.
      // Por simplicidad para el seed general y asegurar que se refresque la última versión, usamos el clásico set.
      await collection.doc(rutina3Dias.id).set(rutina3Dias.toFirestore());
      await collection.doc(rutina5Dias.id).set(rutina5Dias.toFirestore());
      await collection
          .doc(rutinaPrincipiante3Dias.id)
          .set(rutinaPrincipiante3Dias.toFirestore());
      await collection
          .doc(rutinaPrincipiante5Dias.id)
          .set(rutinaPrincipiante5Dias.toFirestore());

      await collection
          .doc(rutinaIntermedia3Dias.id)
          .set(rutinaIntermedia3Dias.toFirestore());
      await collection
          .doc(rutinaIntermedia5Dias.id)
          .set(rutinaIntermedia5Dias.toFirestore());

      await collection
          .doc(rutinaArnoldSplit.id)
          .set(rutinaArnoldSplit.toFirestore());
      await collection
          .doc('pitbull_avanzado_6_dias')
          .set(rutinaArnoldSplit.toFirestore()..['id'] = 'pitbull_avanzado_6_dias');

      final rutinaPitbullAvanzado2 = createPitbullAvanzado2();
      await collection
          .doc(rutinaPitbullAvanzado2.id)
          .set(rutinaPitbullAvanzado2.toFirestore());

      debugPrint('¡Datos inyectados en Firestore con éxito!');
    } catch (e) {
      debugPrint('Error al inyectar: $e');
      rethrow;
    }
  }

  /// Retorna la estructura completa de Pitbull Avanzado 2 (5 Días/Semana) con sus 37 videos
  static RutinaAdaptacion createPitbullAvanzado2([String id = 'pitbull_avanzado_2_5_dias']) {
    return RutinaAdaptacion(
      id: id,
      variante: '5 Días/Semana',
      level: 'advanced',
      tags: ['pitbull_avanzado_2', 'advanced', '5-days'],
      dias: [
        DiaRutina(
          nombreDia: 'Lunes',
          ejercicios: [
            Ejercicio(
              nombre: 'SENTADILLA HACK',
              tipo: 'Máquina',
              seriesReps: '4x8-10',
              descanso: '90 seg',
              urlGif: 'assets/RUTINAS/RUTINA_AVANZADO/PITBULL_AVANZADO_2/DE_5_DIAS/DIA_LUNES/1_SENTADILLA_HACK.mp4',
              instruccion: 'Espalda bien apoyada en el respaldo, pies al ancho de hombros en la plataforma. Bajá controladamente y empujá con los talones.',
              series: '4',
              repeticiones: '8-10',
              tipoDeEquipo: 'Machine',
              musculoObjetivo: 'Cuádriceps / Glúteos',
            ),
            Ejercicio(
              nombre: 'PRENSA',
              tipo: 'Máquina',
              seriesReps: '4x10-12',
              descanso: '90 seg',
              urlGif: 'assets/RUTINAS/RUTINA_AVANZADO/PITBULL_AVANZADO_2/DE_5_DIAS/DIA_LUNES/2_PRENSA.mp4',
              instruccion: 'Pies a media altura en la plataforma. Flexioná las rodillas hasta 90 grados y empujá sin bloquear totalmente las rodillas.',
              series: '4',
              repeticiones: '10-12',
              tipoDeEquipo: 'Machine',
              musculoObjetivo: 'Cuádriceps / Piernas',
            ),
            Ejercicio(
              nombre: 'BANCO CUADRICEPS',
              tipo: 'Máquina',
              seriesReps: '4x12-15',
              descanso: '60 seg',
              urlGif: 'assets/RUTINAS/RUTINA_AVANZADO/PITBULL_AVANZADO_2/DE_5_DIAS/DIA_LUNES/3_BANCO_CUADRICEPS.mp4',
              instruccion: 'Ajustá el rodillo sobre los tobillos, extendé completamente las piernas contrayendo el cuádriceps 1 segundo en la cima.',
              series: '4',
              repeticiones: '12-15',
              tipoDeEquipo: 'Machine',
              musculoObjetivo: 'Cuádriceps',
            ),
            Ejercicio(
              nombre: 'ISQUIOTIBIALES ACOSTADO',
              tipo: 'Máquina',
              seriesReps: '4x10-12',
              descanso: '60-90 seg',
              urlGif: 'assets/RUTINAS/RUTINA_AVANZADO/PITBULL_AVANZADO_2/DE_5_DIAS/DIA_LUNES/4_ISQUIOTIBIALES_ACOSTADO.mp4',
              instruccion: 'Boca abajo, flexioná las rodillas llevando los talones hacia los glúteos de forma controlada.',
              series: '4',
              repeticiones: '10-12',
              tipoDeEquipo: 'Machine',
              musculoObjetivo: 'Isquiosurales',
            ),
            Ejercicio(
              nombre: 'CURL ISQUIOTIBIALES',
              tipo: 'Máquina',
              seriesReps: '4x12-15',
              descanso: '60 seg',
              urlGif: 'assets/RUTINAS/RUTINA_AVANZADO/PITBULL_AVANZADO_2/DE_5_DIAS/DIA_LUNES/5_CURL_ISQUIOTIBIALES.mp4',
              instruccion: 'Mantené el torso firme y flexioná las piernas aislando los femorales.',
              series: '4',
              repeticiones: '12-15',
              tipoDeEquipo: 'Machine',
              musculoObjetivo: 'Isquiosurales',
            ),
            Ejercicio(
              nombre: 'ELEVACION GEMELOS SENTADO',
              tipo: 'Máquina',
              seriesReps: '4x15-20',
              descanso: '60 seg',
              urlGif: 'assets/RUTINAS/RUTINA_AVANZADO/PITBULL_AVANZADO_2/DE_5_DIAS/DIA_LUNES/6_ELEVACION_GEMELOS_SENTADO.mp4',
              instruccion: 'Apoyá la almohadilla sobre los muslos, bajá los talones al máximo para estirar y elevá contrayendo el sóleo.',
              series: '4',
              repeticiones: '15-20',
              tipoDeEquipo: 'Machine',
              musculoObjetivo: 'Gemelos / Sóleo',
            ),
            Ejercicio(
              nombre: 'ESTOCADAS',
              tipo: 'Mancuernas',
              seriesReps: '4x10-12',
              descanso: '60-90 seg',
              urlGif: 'assets/RUTINAS/RUTINA_AVANZADO/PITBULL_AVANZADO_2/DE_5_DIAS/DIA_LUNES/7_ESTOCADAS.mp4',
              instruccion: 'Paso al frente amplio, descendé la rodilla trasera casi al suelo manteniendo el torso erguido y empujá.',
              series: '4',
              repeticiones: '10-12',
              tipoDeEquipo: 'Dumbbell',
              musculoObjetivo: 'Glúteos / Cuádriceps',
            ),
          ],
        ),
        DiaRutina(
          nombreDia: 'Martes',
          ejercicios: [
            Ejercicio(
              nombre: 'PRESS INCLINADO CON MANCUERNA',
              tipo: 'Mancuernas',
              seriesReps: '4x8-10',
              descanso: '90 seg',
              urlGif: 'assets/RUTINAS/RUTINA_AVANZADO/PITBULL_AVANZADO_2/DE_5_DIAS/DIA_MARTES/1_PRESS_INCLINADO_CON_MANCUERNA.mp4',
              instruccion: 'Banco a 30-45 grados. Bajá controlando hasta que las mancuernas rocen el pecho y empujá hacia arriba.',
              series: '4',
              repeticiones: '8-10',
              tipoDeEquipo: 'Dumbbell',
              musculoObjetivo: 'Pecho Superior',
            ),
            Ejercicio(
              nombre: 'PRESS BANCA PLANO',
              tipo: 'Barra',
              seriesReps: '4x8-10',
              descanso: '90 seg',
              urlGif: 'assets/RUTINAS/RUTINA_AVANZADO/PITBULL_AVANZADO_2/DE_5_DIAS/DIA_MARTES/2_PRESS_BANCA_PLANO.mp4',
              instruccion: 'Retraé escápulas, bajá la barra al esternón con control y empujá con potencia.',
              series: '4',
              repeticiones: '8-10',
              tipoDeEquipo: 'Barbell',
              musculoObjetivo: 'Pecho Medio',
            ),
            Ejercicio(
              nombre: 'APERTURA INCLINADA',
              tipo: 'Mancuernas',
              seriesReps: '4x10-12',
              descanso: '60 seg',
              urlGif: 'assets/RUTINAS/RUTINA_AVANZADO/PITBULL_AVANZADO_2/DE_5_DIAS/DIA_MARTES/3_APERTURA_INCLINADA.mp4',
              instruccion: 'Codos ligeramente flexionados, abrí los brazos sintiendo el estiramiento en el pectoral y cerrá abrazando.',
              series: '4',
              repeticiones: '10-12',
              tipoDeEquipo: 'Dumbbell',
              musculoObjetivo: 'Pecho Superior',
            ),
            Ejercicio(
              nombre: 'APERTURA EN MAQUINA',
              tipo: 'Máquina',
              seriesReps: '4x12-15',
              descanso: '60 seg',
              urlGif: 'assets/RUTINAS/RUTINA_AVANZADO/PITBULL_AVANZADO_2/DE_5_DIAS/DIA_MARTES/4_APERTURA_EN_MAQUINA.mp4',
              instruccion: 'Pecho erguido, juntá los brazos al frente apretando el pectoral 1 segundo.',
              series: '4',
              repeticiones: '12-15',
              tipoDeEquipo: 'Machine',
              musculoObjetivo: 'Pecho',
            ),
            Ejercicio(
              nombre: 'PRESS DE HOMBRO',
              tipo: 'Mancuernas',
              seriesReps: '4x8-10',
              descanso: '90 seg',
              urlGif: 'assets/RUTINAS/RUTINA_AVANZADO/PITBULL_AVANZADO_2/DE_5_DIAS/DIA_MARTES/5_PRESS_DE_HOMBRO.mp4',
              instruccion: 'Empujá verticalmente desde la altura de las orejas hasta extender los brazos sin chocar las mancuernas.',
              series: '4',
              repeticiones: '8-10',
              tipoDeEquipo: 'Dumbbell',
              musculoObjetivo: 'Deltoides',
            ),
            Ejercicio(
              nombre: 'VUELOS LATERALES',
              tipo: 'Mancuernas',
              seriesReps: '4x12-15',
              descanso: '60 seg',
              urlGif: 'assets/RUTINAS/RUTINA_AVANZADO/PITBULL_AVANZADO_2/DE_5_DIAS/DIA_MARTES/6_VUELOS_LATERALES.mp4',
              instruccion: 'Elevá los codos hacia los laterales hasta la altura de los hombros, bajada lenta y controlada.',
              series: '4',
              repeticiones: '12-15',
              tipoDeEquipo: 'Dumbbell',
              musculoObjetivo: 'Deltoides Lateral',
            ),
            Ejercicio(
              nombre: 'VUELOS FRONTALES',
              tipo: 'Mancuernas',
              seriesReps: '4x12',
              descanso: '60 seg',
              urlGif: 'assets/RUTINAS/RUTINA_AVANZADO/PITBULL_AVANZADO_2/DE_5_DIAS/DIA_MARTES/7_VUELOS_FRONTALES.mp4',
              instruccion: 'Elevá hacia el frente con brazos casi rectos hasta la altura de la vista.',
              series: '4',
              repeticiones: '12',
              tipoDeEquipo: 'Dumbbell',
              musculoObjetivo: 'Deltoides Anterior',
            ),
            Ejercicio(
              nombre: 'VUELOS POSTERIORES',
              tipo: 'Mancuernas',
              seriesReps: '4x12-15',
              descanso: '60 seg',
              urlGif: 'assets/RUTINAS/RUTINA_AVANZADO/PITBULL_AVANZADO_2/DE_5_DIAS/DIA_MARTES/8_VUELOS_POSTERIORES.mp4',
              instruccion: 'Torso inclinado a 45 grados, abrí los brazos hacia los laterales apretando la parte posterior del hombro.',
              series: '4',
              repeticiones: '12-15',
              tipoDeEquipo: 'Dumbbell',
              musculoObjetivo: 'Deltoides Posterior',
            ),
          ],
        ),
        DiaRutina(
          nombreDia: 'Miércoles',
          ejercicios: [
            Ejercicio(
              nombre: 'JALON AL PECHO',
              tipo: 'Polea',
              seriesReps: '4x10-12',
              descanso: '90 seg',
              urlGif: 'assets/RUTINAS/RUTINA_AVANZADO/PITBULL_AVANZADO_2/DE_5_DIAS/DIA_MIERCOLES/1_JALON_AL_PECHO.mp4',
              instruccion: 'Agarre prono amplio, tirá de la barra hacia la parte superior del pecho sacando pecho y retrayendo escápulas.',
              series: '4',
              repeticiones: '10-12',
              tipoDeEquipo: 'Cable',
              musculoObjetivo: 'Dorsal Ancho',
            ),
            Ejercicio(
              nombre: 'JALON CERRADO AL PECHO',
              tipo: 'Polea',
              seriesReps: '4x10-12',
              descanso: '90 seg',
              urlGif: 'assets/RUTINAS/RUTINA_AVANZADO/PITBULL_AVANZADO_2/DE_5_DIAS/DIA_MIERCOLES/2_JALON_CERRADO_AL_PECHO.mp4',
              instruccion: 'Con agarre estrecho neutro, tirá hacia el esternón manteniendo el torso estable.',
              series: '4',
              repeticiones: '10-12',
              tipoDeEquipo: 'Cable',
              musculoObjetivo: 'Dorsal / Espalda Media',
            ),
            Ejercicio(
              nombre: 'REMO CERRADO',
              tipo: 'Polea',
              seriesReps: '4x10-12',
              descanso: '90 seg',
              urlGif: 'assets/RUTINAS/RUTINA_AVANZADO/PITBULL_AVANZADO_2/DE_5_DIAS/DIA_MIERCOLES/3_REMO_CERRADO.mp4',
              instruccion: 'Espalda recta, tirá hacia el abdomen llevando los codos bien atrás y apretando omóplatos.',
              series: '4',
              repeticiones: '10-12',
              tipoDeEquipo: 'Cable',
              musculoObjetivo: 'Espalda Media / Dorsal',
            ),
            Ejercicio(
              nombre: 'REMO EN BARRA',
              tipo: 'Barra',
              seriesReps: '4x8-10',
              descanso: '90 seg',
              urlGif: 'assets/RUTINAS/RUTINA_AVANZADO/PITBULL_AVANZADO_2/DE_5_DIAS/DIA_MIERCOLES/4_REMO_EN_BARRA.mp4',
              instruccion: 'Torso inclinado a 45 grados, barra pegada a los muslos, tirá con los codos hacia la cadera.',
              series: '4',
              repeticiones: '8-10',
              tipoDeEquipo: 'Barbell',
              musculoObjetivo: 'Espalda Completa',
            ),
            Ejercicio(
              nombre: 'REMO HAMMER',
              tipo: 'Máquina',
              seriesReps: '4x10-12',
              descanso: '90 seg',
              urlGif: 'assets/RUTINAS/RUTINA_AVANZADO/PITBULL_AVANZADO_2/DE_5_DIAS/DIA_MIERCOLES/5_REMO_HAMMER.mp4',
              instruccion: 'Pecho firme contra el soporte acolchado, traccioná con fuerza contrayendo la espalda en cada repetición.',
              series: '4',
              repeticiones: '10-12',
              tipoDeEquipo: 'Machine',
              musculoObjetivo: 'Dorsal / Espalda Media',
            ),
          ],
        ),
        DiaRutina(
          nombreDia: 'Jueves',
          ejercicios: [
            Ejercicio(
              nombre: 'SENTADILLA',
              tipo: 'Barra',
              seriesReps: '4x8-10',
              descanso: '120 seg',
              urlGif: 'assets/RUTINAS/RUTINA_AVANZADO/PITBULL_AVANZADO_2/DE_5_DIAS/DIA_JUEVES/1_SENTADILLA.mp4',
              instruccion: 'Barra en trapecios, descendé quebrando caderas y rodillas hasta paralelo, empujá firme con toda la planta.',
              series: '4',
              repeticiones: '8-10',
              tipoDeEquipo: 'Barbell',
              musculoObjetivo: 'Piernas / Glúteos',
            ),
            Ejercicio(
              nombre: 'SENTADILLA SUMO CON PESA RUSA',
              tipo: 'Pesa Rusa',
              seriesReps: '4x10-12',
              descanso: '90 seg',
              urlGif: 'assets/RUTINAS/RUTINA_AVANZADO/PITBULL_AVANZADO_2/DE_5_DIAS/DIA_JUEVES/2_SENTADILLA_SUMO_CON_PESA_RUSA.mp4',
              instruccion: 'Pies más abiertos que los hombros a 45°. Bajá la pesa verticalmente y subí apretando glúteos y aductores.',
              series: '4',
              repeticiones: '10-12',
              tipoDeEquipo: 'Kettlebell',
              musculoObjetivo: 'Aductores / Glúteos',
            ),
            Ejercicio(
              nombre: 'SENTADILLA HACK',
              tipo: 'Máquina',
              seriesReps: '4x10-12',
              descanso: '90 seg',
              urlGif: 'assets/RUTINAS/RUTINA_AVANZADO/PITBULL_AVANZADO_2/DE_5_DIAS/DIA_JUEVES/3_SENTADILLA_HACK.mp4',
              instruccion: 'Bajada profunda y controlada en la máquina Hack, empuje explosivo sin bloquear rodillas.',
              series: '4',
              repeticiones: '10-12',
              tipoDeEquipo: 'Machine',
              musculoObjetivo: 'Cuádriceps',
            ),
            Ejercicio(
              nombre: 'BANCO CUADRICEPS',
              tipo: 'Máquina',
              seriesReps: '4x12-15',
              descanso: '60 seg',
              urlGif: 'assets/RUTINAS/RUTINA_AVANZADO/PITBULL_AVANZADO_2/DE_5_DIAS/DIA_JUEVES/4_BANCO_CUADRICEPS.mp4',
              instruccion: 'Aisla el cuádriceps en todo el rango articular con pausa de 1 segundo arriba.',
              series: '4',
              repeticiones: '12-15',
              tipoDeEquipo: 'Machine',
              musculoObjetivo: 'Cuádriceps',
            ),
            Ejercicio(
              nombre: 'BANCO ISQUIOTIBIALES',
              tipo: 'Máquina',
              seriesReps: '4x12-15',
              descanso: '60-90 seg',
              urlGif: 'assets/RUTINAS/RUTINA_AVANZADO/PITBULL_AVANZADO_2/DE_5_DIAS/DIA_JUEVES/5_BANCO_ISQUIOTIBIALES.mp4',
              instruccion: 'Flexioná concentrando la tensión en la parte posterior del muslo.',
              series: '4',
              repeticiones: '12-15',
              tipoDeEquipo: 'Machine',
              musculoObjetivo: 'Isquiosurales',
            ),
            Ejercicio(
              nombre: 'CURL ISQUIOTIBIALES',
              tipo: 'Máquina',
              seriesReps: '4x12-15',
              descanso: '60 seg',
              urlGif: 'assets/RUTINAS/RUTINA_AVANZADO/PITBULL_AVANZADO_2/DE_5_DIAS/DIA_JUEVES/6_CURL_ISQUIOTIBIALES.mp4',
              instruccion: 'Controlá la fase excéntrica (bajada lenta de 2 a 3 segundos).',
              series: '4',
              repeticiones: '12-15',
              tipoDeEquipo: 'Machine',
              musculoObjetivo: 'Isquiosurales',
            ),
            Ejercicio(
              nombre: 'ABDUCTORES',
              tipo: 'Máquina',
              seriesReps: '4x15-20',
              descanso: '60 seg',
              urlGif: 'assets/RUTINAS/RUTINA_AVANZADO/PITBULL_AVANZADO_2/DE_5_DIAS/DIA_JUEVES/7_ABDUCTORES.mp4',
              instruccion: 'Sentado con la espalda apoyada, abrí las piernas venciendo la resistencia y apretá el lateral de los glúteos.',
              series: '4',
              repeticiones: '15-20',
              tipoDeEquipo: 'Machine',
              musculoObjetivo: 'Glúteo Medio / Abductores',
            ),
            Ejercicio(
              nombre: 'ADUCTORES',
              tipo: 'Máquina',
              seriesReps: '4x15-20',
              descanso: '60 seg',
              urlGif: 'assets/RUTINAS/RUTINA_AVANZADO/PITBULL_AVANZADO_2/DE_5_DIAS/DIA_JUEVES/8_ADUCTORES.mp4',
              instruccion: 'Cerrá las piernas juntando las almohadillas con control y pausa isométrica.',
              series: '4',
              repeticiones: '15-20',
              tipoDeEquipo: 'Machine',
              musculoObjetivo: 'Aductores',
            ),
            Ejercicio(
              nombre: 'ELEVACION GEMELOS SENTADO',
              tipo: 'Máquina',
              seriesReps: '4x15-20',
              descanso: '60 seg',
              urlGif: 'assets/RUTINAS/RUTINA_AVANZADO/PITBULL_AVANZADO_2/DE_5_DIAS/DIA_JUEVES/9_ELEVACION_GEMELOS_SENTADO.mp4',
              instruccion: 'Máximo rango de estiramiento y contracción en cada repetición.',
              series: '4',
              repeticiones: '15-20',
              tipoDeEquipo: 'Machine',
              musculoObjetivo: 'Gemelos',
            ),
          ],
        ),
        DiaRutina(
          nombreDia: 'Viernes',
          ejercicios: [
            Ejercicio(
              nombre: 'CURL BICEPS BARRA EZ',
              tipo: 'Barra EZ',
              seriesReps: '4x10-12',
              descanso: '60 seg',
              urlGif: 'assets/RUTINAS/RUTINA_AVANZADO/PITBULL_AVANZADO_2/DE_5_DIAS/DIA_VIERNES/1_CURL_BICEPS_BARRA_EZ.mp4',
              instruccion: 'Codos pegados a los costados, subí la barra flexionando bíceps sin balancear la espalda.',
              series: '4',
              repeticiones: '10-12',
              tipoDeEquipo: 'Barbell',
              musculoObjetivo: 'Bíceps',
            ),
            Ejercicio(
              nombre: 'CURL CON MANCUERNA',
              tipo: 'Mancuernas',
              seriesReps: '4x10-12',
              descanso: '60 seg',
              urlGif: 'assets/RUTINAS/RUTINA_AVANZADO/PITBULL_AVANZADO_2/DE_5_DIAS/DIA_VIERNES/2_CURL_CON_MANCUERNA.mp4',
              instruccion: 'Subida con supinación girando la muñeca hacia afuera en la parte alta.',
              series: '4',
              repeticiones: '10-12',
              tipoDeEquipo: 'Dumbbell',
              musculoObjetivo: 'Bíceps',
            ),
            Ejercicio(
              nombre: 'CURL CONCENTRADO',
              tipo: 'Mancuerna',
              seriesReps: '4x12',
              descanso: '60 seg',
              urlGif: 'assets/RUTINAS/RUTINA_AVANZADO/PITBULL_AVANZADO_2/DE_5_DIAS/DIA_VIERNES/3_CURL_CONCENTRADO.mp4',
              instruccion: 'Codo apoyado en la cara interna del muslo, aislá el bíceps por completo sin balanceo.',
              series: '4',
              repeticiones: '12',
              tipoDeEquipo: 'Dumbbell',
              musculoObjetivo: 'Bíceps',
            ),
            Ejercicio(
              nombre: 'CURL BICEPS EN POLEA',
              tipo: 'Polea',
              seriesReps: '4x12-15',
              descanso: '60 seg',
              urlGif: 'assets/RUTINAS/RUTINA_AVANZADO/PITBULL_AVANZADO_2/DE_5_DIAS/DIA_VIERNES/4_CURL_BICEPS_EN_POLEA.mp4',
              instruccion: 'Tensión continua en todo el rango de movimiento con barra o soga en polea baja.',
              series: '4',
              repeticiones: '12-15',
              tipoDeEquipo: 'Cable',
              musculoObjetivo: 'Bíceps',
            ),
            Ejercicio(
              nombre: 'PRESS FRANCES',
              tipo: 'Barra EZ',
              seriesReps: '4x10-12',
              descanso: '60-90 seg',
              urlGif: 'assets/RUTINAS/RUTINA_AVANZADO/PITBULL_AVANZADO_2/DE_5_DIAS/DIA_VIERNES/5_PRESS_FRANCES.mp4',
              instruccion: 'Acostado en banco plano, codos apuntando al techo, bajá la barra hacia la frente y extendé con tríceps.',
              series: '4',
              repeticiones: '10-12',
              tipoDeEquipo: 'Barbell',
              musculoObjetivo: 'Tríceps',
            ),
            Ejercicio(
              nombre: 'FONDO DE TRICEPS',
              tipo: 'Paralelas / Banco',
              seriesReps: '4x10-12',
              descanso: '90 seg',
              urlGif: 'assets/RUTINAS/RUTINA_AVANZADO/PITBULL_AVANZADO_2/DE_5_DIAS/DIA_VIERNES/6_FONDO_DE_TRICEPS.mp4',
              instruccion: 'Cuerpo vertical, codos pegados hacia atrás, bajá hasta 90 grados y empujá.',
              series: '4',
              repeticiones: '10-12',
              tipoDeEquipo: 'Bodyweight',
              musculoObjetivo: 'Tríceps',
            ),
            Ejercicio(
              nombre: 'EXTENSION UNILATERAL',
              tipo: 'Polea',
              seriesReps: '4x12-15',
              descanso: '45 seg',
              urlGif: 'assets/RUTINAS/RUTINA_AVANZADO/PITBULL_AVANZADO_2/DE_5_DIAS/DIA_VIERNES/7_EXTENSION_UNILATERAL.mp4',
              instruccion: 'Extensión con un solo brazo en polea alta para equilibrar fuerza y volumen en ambos brazos.',
              series: '4',
              repeticiones: '12-15',
              tipoDeEquipo: 'Cable',
              musculoObjetivo: 'Tríceps',
            ),
            Ejercicio(
              nombre: 'PATADA DE TRICEPS',
              tipo: 'Mancuerna',
              seriesReps: '4x12-15',
              descanso: '60 seg',
              urlGif: 'assets/RUTINAS/RUTINA_AVANZADO/PITBULL_AVANZADO_2/DE_5_DIAS/DIA_VIERNES/8_PATADA_DE_TRICEPS.mp4',
              instruccion: 'Torso inclinado hacia adelante, codo alto fijo, extendé el brazo hacia atrás bloqueando 1 segundo.',
              series: '4',
              repeticiones: '12-15',
              tipoDeEquipo: 'Dumbbell',
              musculoObjetivo: 'Tríceps',
            ),
          ],
        ),
      ],
    );
  }
}
