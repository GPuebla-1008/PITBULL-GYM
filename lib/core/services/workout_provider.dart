import 'package:flutter/material.dart';
import '../models/rutina_adaptacion_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'seed_rutinas_service.dart';

class WorkoutProvider with ChangeNotifier {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  DiaRutina? _rutinaActiva;
  String _varianteActiva = '';

  List<RutinaAdaptacion> _todasLasRutinas = [];
  bool _loading = false;

  DiaRutina? get rutinaActiva => _rutinaActiva;
  String get varianteActiva => _varianteActiva;
  List<RutinaAdaptacion> get todasLasRutinas => _todasLasRutinas;
  bool get loading => _loading;

  // Cargar rutinas de Firestore
  Future<void> fetchRutinas() async {
    _loading = true;
    notifyListeners();
    try {
      final snap = await _db.collection('rutinas_adaptacion').get();
      if (snap.docs.isEmpty) {
        // Fallback para localhost o DB vacía
        _todasLasRutinas = _getFallbackRutinas();
      } else {
        _todasLasRutinas = snap.docs
            .map((d) => RutinaAdaptacion.fromFirestore(d))
            .toList();

        // Auto-migración si detectamos rutas con espacios de la versión antigua o si la rutina avanzada aún no tiene videos
        bool tieneRutasConEspacios = false;
        for (var r in _todasLasRutinas) {
          for (var d in r.dias) {
            for (var e in d.ejercicios) {
              if (e.urlGif.contains(' ')) {
                tieneRutasConEspacios = true;
                break;
              }
            }
            if (tieneRutasConEspacios) break;
          }
          if (tieneRutasConEspacios) break;
        }

        bool necesitaActualizarAvanzado = false;
        final rutinaAvanzada = _todasLasRutinas.firstWhere(
          (r) => r.id == 'arnold_split_advanced' || r.id == 'pitbull_avanzado_6_dias',
          orElse: () => RutinaAdaptacion(id: '', variante: '', dias: []),
        );
        if (rutinaAvanzada.id.isEmpty ||
            (rutinaAvanzada.dias.isNotEmpty &&
                rutinaAvanzada.dias.first.ejercicios.isNotEmpty &&
                !rutinaAvanzada.dias.first.ejercicios.first.urlGif.endsWith('.mp4'))) {
          necesitaActualizarAvanzado = true;
        }

        final rutinaAvanzada2 = _todasLasRutinas.firstWhere(
          (r) => r.id == 'pitbull_avanzado_2_5_dias',
          orElse: () => RutinaAdaptacion(id: '', variante: '', dias: []),
        );
        if (rutinaAvanzada2.id.isEmpty ||
            (rutinaAvanzada2.dias.isNotEmpty &&
                rutinaAvanzada2.dias.first.ejercicios.isNotEmpty &&
                !rutinaAvanzada2.dias.first.ejercicios.first.urlGif.endsWith('.mp4'))) {
          necesitaActualizarAvanzado = true;
        }

        bool necesitaActualizarPrincipiante = false;
        final hasPrincipianteHombres = _todasLasRutinas.any((r) => r.id == 'principiante_hombres_3_dias');
        final hasPrincipianteMujeres = _todasLasRutinas.any((r) => r.id == 'principiante_mujeres_3_dias');
        if (!hasPrincipianteHombres || !hasPrincipianteMujeres) {
          necesitaActualizarPrincipiante = true;
        }

        if (tieneRutasConEspacios || necesitaActualizarAvanzado || necesitaActualizarPrincipiante) {
          debugPrint("AUTO-MIGRACIÓN: Actualizando rutinas y videos en Firestore...");
          await SeedRutinasService.inyectarDatosSilent();
          final freshSnap = await _db.collection('rutinas_adaptacion').get();
          _todasLasRutinas = freshSnap.docs
              .map((d) => RutinaAdaptacion.fromFirestore(d))
              .toList();
          debugPrint("AUTO-MIGRACIÓN: Base de datos Firestore migrada y recargada con éxito.");
        }
      }
    } catch (e) {
      debugPrint("Error fetching rutinas: $e");
      _todasLasRutinas = _getFallbackRutinas();
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  List<RutinaAdaptacion> _getFallbackRutinas() {
    return [
      // --- FULL BODY ADAPTACION ---
      _createMockRutina('fullbody_1', '3 Días', 3),
      _createMockRutina('fullbody_2', '5 Días', 5),

      // --- PRINCIPIANTE (HOMBRES Y MUJERES) ---
      SeedRutinasService.createPrincipianteHombres3Dias(),
      SeedRutinasService.createPrincipianteHombres5Dias(),
      SeedRutinasService.createPrincipianteMujeres3Dias(),
      SeedRutinasService.createPrincipianteMujeres5Dias(),

      // --- INTERMEDIO ---
      _createMockRutina('intermedio_1', '3 Días', 3),
      _createMockRutina('intermedio_2', '5 Días', 5),

      // --- AVANZADO ---
      _createPitbullAvanzadoFallback('arnold_split_advanced'),
      _createPitbullAvanzadoFallback('pitbull_avanzado_6_dias'),
      SeedRutinasService.createPitbullAvanzado2('pitbull_avanzado_2_5_dias'),
    ];
  }

  RutinaAdaptacion _createPitbullAvanzadoFallback(String id) {
    return RutinaAdaptacion(
      id: id,
      variante: '6 Días/Semana',
      level: 'advanced',
      tags: ['pitbull_avanzado', 'advanced', '6-days'],
      dias: [
        DiaRutina(
          nombreDia: 'Lunes',
          ejercicios: [
            Ejercicio(
              nombre: 'PRESS BANCA PLANO',
              tipo: 'Peso Libre',
              seriesReps: '4x8-10',
              descanso: '90 seg',
              urlGif: 'assets/RUTINAS/RUTINA_AVANZADO/PITBULL_AVANZADO/DE_6_DIAS/DIA_LUNES/1_PRESS_BANCA_PLANO.mp4',
            ),
            Ejercicio(
              nombre: 'PRESS MAQUINA CONVERGENTE',
              tipo: 'Máquina',
              seriesReps: '4x10-12',
              descanso: '90 seg',
              urlGif: 'assets/RUTINAS/RUTINA_AVANZADO/PITBULL_AVANZADO/DE_6_DIAS/DIA_LUNES/2_PRESS_MAQUINA_CONVERGENTE.mp4',
            ),
            Ejercicio(
              nombre: 'PRESS INCLINADO CON MANCUERNA',
              tipo: 'Mancuernas',
              seriesReps: '4x10-12',
              descanso: '90 seg',
              urlGif: 'assets/RUTINAS/RUTINA_AVANZADO/PITBULL_AVANZADO/DE_6_DIAS/DIA_LUNES/3_PRESS_INCLINADO_CON_MANCUERNA.mp4',
            ),
            Ejercicio(
              nombre: 'APERTURA EN MAQUINA',
              tipo: 'Máquina',
              seriesReps: '3x12-15',
              descanso: '60 seg',
              urlGif: 'assets/RUTINAS/RUTINA_AVANZADO/PITBULL_AVANZADO/DE_6_DIAS/DIA_LUNES/4_APERTURA_EN_MAQUINA.mp4',
            ),
            Ejercicio(
              nombre: 'FLEXIONES DE BRAZOS',
              tipo: 'Peso Corporal',
              seriesReps: '3xFallo',
              descanso: '60 seg',
              urlGif: 'assets/RUTINAS/RUTINA_AVANZADO/PITBULL_AVANZADO/DE_6_DIAS/DIA_LUNES/5_FLEXIONES_DE_BRAZOS.mp4',
            ),
            Ejercicio(
              nombre: 'PRESS FRANCES',
              tipo: 'Peso Libre',
              seriesReps: '4x10-12',
              descanso: '90 seg',
              urlGif: 'assets/RUTINAS/RUTINA_AVANZADO/PITBULL_AVANZADO/DE_6_DIAS/DIA_LUNES/6_PRESS_FRANCES.mp4',
            ),
            Ejercicio(
              nombre: 'EXTENSION EN POLEA CON CUERDA',
              tipo: 'Polea',
              seriesReps: '4x12-15',
              descanso: '60 seg',
              urlGif: 'assets/RUTINAS/RUTINA_AVANZADO/PITBULL_AVANZADO/DE_6_DIAS/DIA_LUNES/7_EXTENSION_EN_POLEA_CON_CUERDA.mp4',
            ),
            Ejercicio(
              nombre: 'EXTENSION UNILATERAL',
              tipo: 'Polea',
              seriesReps: '3x12',
              descanso: '60 seg',
              urlGif: 'assets/RUTINAS/RUTINA_AVANZADO/PITBULL_AVANZADO/DE_6_DIAS/DIA_LUNES/8_EXTENSION_UNILATERAL.mp4',
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
              urlGif: 'assets/RUTINAS/RUTINA_AVANZADO/PITBULL_AVANZADO/DE_6_DIAS/DIA_MARTES/1_DOMINADAS.mp4',
            ),
            Ejercicio(
              nombre: 'REMO ABIERTO',
              tipo: 'Máquina / Barra',
              seriesReps: '4x10-12',
              descanso: '90 seg',
              urlGif: 'assets/RUTINAS/RUTINA_AVANZADO/PITBULL_AVANZADO/DE_6_DIAS/DIA_MARTES/2_REMO_ABIERTO.mp4',
            ),
            Ejercicio(
              nombre: 'JALON AL PECHO',
              tipo: 'Polea',
              seriesReps: '4x10-12',
              descanso: '90 seg',
              urlGif: 'assets/RUTINAS/RUTINA_AVANZADO/PITBULL_AVANZADO/DE_6_DIAS/DIA_MARTES/3_JALON_AL_PECHO.mp4',
            ),
            Ejercicio(
              nombre: 'REMO CERRADO',
              tipo: 'Polea',
              seriesReps: '4x10-12',
              descanso: '90 seg',
              urlGif: 'assets/RUTINAS/RUTINA_AVANZADO/PITBULL_AVANZADO/DE_6_DIAS/DIA_MARTES/4_REMO_CERRADO.mp4',
            ),
            Ejercicio(
              nombre: 'PULLOVER EN POLEA',
              tipo: 'Polea',
              seriesReps: '3x12-15',
              descanso: '60 seg',
              urlGif: 'assets/RUTINAS/RUTINA_AVANZADO/PITBULL_AVANZADO/DE_6_DIAS/DIA_MARTES/5_PULLOVER_EN_POLEA.mp4',
            ),
            Ejercicio(
              nombre: 'CURL BICEPS',
              tipo: 'Barra / Mancuerna',
              seriesReps: '4x10-12',
              descanso: '60-90 seg',
              urlGif: 'assets/RUTINAS/RUTINA_AVANZADO/PITBULL_AVANZADO/DE_6_DIAS/DIA_MARTES/6_CURL_BICEPS.mp4',
            ),
            Ejercicio(
              nombre: 'CURL CON MANCUERNA',
              tipo: 'Mancuernas',
              seriesReps: '4x10-12',
              descanso: '60 seg',
              urlGif: 'assets/RUTINAS/RUTINA_AVANZADO/PITBULL_AVANZADO/DE_6_DIAS/DIA_MARTES/7_CURL_CON_MANCUERNA.mp4',
            ),
            Ejercicio(
              nombre: 'CURL PREDICADOR',
              tipo: 'Máquina / Banco Scott',
              seriesReps: '3x12-15',
              descanso: '60 seg',
              urlGif: 'assets/RUTINAS/RUTINA_AVANZADO/PITBULL_AVANZADO/DE_6_DIAS/DIA_MARTES/8_CURL_PREDICADOR.mp4',
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
              urlGif: 'assets/RUTINAS/RUTINA_AVANZADO/PITBULL_AVANZADO/DE_6_DIAS/DIA_MIERCOLES/1_SENTADILLA.mp4',
            ),
            Ejercicio(
              nombre: 'PRENSA',
              tipo: 'Máquina',
              seriesReps: '4x10-12',
              descanso: '90-120 seg',
              urlGif: 'assets/RUTINAS/RUTINA_AVANZADO/PITBULL_AVANZADO/DE_6_DIAS/DIA_MIERCOLES/2_PRENSA.mp4',
            ),
            Ejercicio(
              nombre: 'SENTADILLA HACK',
              tipo: 'Máquina',
              seriesReps: '4x10-12',
              descanso: '90-120 seg',
              urlGif: 'assets/RUTINAS/RUTINA_AVANZADO/PITBULL_AVANZADO/DE_6_DIAS/DIA_MIERCOLES/3_SENTADILLA_HACK.mp4',
            ),
            Ejercicio(
              nombre: 'BANCO CUADRICEPS',
              tipo: 'Máquina',
              seriesReps: '4x12-15',
              descanso: '60-90 seg',
              urlGif: 'assets/RUTINAS/RUTINA_AVANZADO/PITBULL_AVANZADO/DE_6_DIAS/DIA_MIERCOLES/4_BANCO_CUADRICEPS.mp4',
            ),
            Ejercicio(
              nombre: 'ELEVACION GEMELOS SENTADO',
              tipo: 'Máquina',
              seriesReps: '4x15-20',
              descanso: '60 seg',
              urlGif: 'assets/RUTINAS/RUTINA_AVANZADO/PITBULL_AVANZADO/DE_6_DIAS/DIA_MIERCOLES/5_ELEVACION_GEMELOS_SENTADO.mp4',
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
              urlGif: 'assets/RUTINAS/RUTINA_AVANZADO/PITBULL_AVANZADO/DE_6_DIAS/DIA_JUEVES/1_PRESS_DE_HOMBRO.mp4',
            ),
            Ejercicio(
              nombre: 'VUELOS LATERALES',
              tipo: 'Mancuernas',
              seriesReps: '4x12-15',
              descanso: '60 seg',
              urlGif: 'assets/RUTINAS/RUTINA_AVANZADO/PITBULL_AVANZADO/DE_6_DIAS/DIA_JUEVES/2_VUELOS_LATERALES.mp4',
            ),
            Ejercicio(
              nombre: 'VUELOS FRONTALES',
              tipo: 'Mancuernas / Polea',
              seriesReps: '4x12-15',
              descanso: '60 seg',
              urlGif: 'assets/RUTINAS/RUTINA_AVANZADO/PITBULL_AVANZADO/DE_6_DIAS/DIA_JUEVES/3_VUELOS_FRONTALES.mp4',
            ),
            Ejercicio(
              nombre: 'VUELOS POSTERIORES',
              tipo: 'Mancuernas / Máquina',
              seriesReps: '4x12-15',
              descanso: '60 seg',
              urlGif: 'assets/RUTINAS/RUTINA_AVANZADO/PITBULL_AVANZADO/DE_6_DIAS/DIA_JUEVES/4_VUELOS_POSTERIORES.mp4',
            ),
            Ejercicio(
              nombre: 'ENCOGIMIENTOS DE HOMBROS',
              tipo: 'Mancuernas / Barra',
              seriesReps: '4x12-15',
              descanso: '60 seg',
              urlGif: 'assets/RUTINAS/RUTINA_AVANZADO/PITBULL_AVANZADO/DE_6_DIAS/DIA_JUEVES/5_ENCOGIMIENTOS_DE_HOMBROS.mp4',
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
              urlGif: 'assets/RUTINAS/RUTINA_AVANZADO/PITBULL_AVANZADO/DE_6_DIAS/DIA_VIERNES/1_PESO_MUERTO_CON_BARRA.mp4',
            ),
            Ejercicio(
              nombre: 'REMO EN BARRA',
              tipo: 'Peso Libre',
              seriesReps: '4x8-10',
              descanso: '90 seg',
              urlGif: 'assets/RUTINAS/RUTINA_AVANZADO/PITBULL_AVANZADO/DE_6_DIAS/DIA_VIERNES/2_REMO_EN_BARRA.mp4',
            ),
            Ejercicio(
              nombre: 'SERRUCHO',
              tipo: 'Mancuernas',
              seriesReps: '4x10-12',
              descanso: '60-90 seg',
              urlGif: 'assets/RUTINAS/RUTINA_AVANZADO/PITBULL_AVANZADO/DE_6_DIAS/DIA_VIERNES/3_SERRUCHO.mp4',
            ),
            Ejercicio(
              nombre: 'CURL BICEPS BARRA EZ',
              tipo: 'Barra EZ',
              seriesReps: '4x10-12',
              descanso: '60 seg',
              urlGif: 'assets/RUTINAS/RUTINA_AVANZADO/PITBULL_AVANZADO/DE_6_DIAS/DIA_VIERNES/4_CURL_BICEPS_BARRA_EZ.mp4',
            ),
            Ejercicio(
              nombre: 'CURL MARTILLO',
              tipo: 'Mancuernas',
              seriesReps: '4x10-12',
              descanso: '60 seg',
              urlGif: 'assets/RUTINAS/RUTINA_AVANZADO/PITBULL_AVANZADO/DE_6_DIAS/DIA_VIERNES/5_CURL_MARTILLO.mp4',
            ),
            Ejercicio(
              nombre: 'PRESS CERRADO',
              tipo: 'Peso Libre',
              seriesReps: '4x8-10',
              descanso: '90 seg',
              urlGif: 'assets/RUTINAS/RUTINA_AVANZADO/PITBULL_AVANZADO/DE_6_DIAS/DIA_VIERNES/6_PRESS_CERRADO.mp4',
            ),
            Ejercicio(
              nombre: 'TIRON EN POLEA',
              tipo: 'Polea',
              seriesReps: '4x12-15',
              descanso: '60 seg',
              urlGif: 'assets/RUTINAS/RUTINA_AVANZADO/PITBULL_AVANZADO/DE_6_DIAS/DIA_VIERNES/7_TIRON_EN_POLEA.mp4',
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
              urlGif: 'assets/RUTINAS/RUTINA_AVANZADO/PITBULL_AVANZADO/DE_6_DIAS/DIA_SABADO/1_PESO_MUERTO_CON_BARRA.mp4',
            ),
            Ejercicio(
              nombre: 'ESTOCADAS',
              tipo: 'Mancuernas',
              seriesReps: '4x10-12',
              descanso: '90 seg',
              urlGif: 'assets/RUTINAS/RUTINA_AVANZADO/PITBULL_AVANZADO/DE_6_DIAS/DIA_SABADO/2_ESTOCADAS.mp4',
            ),
            Ejercicio(
              nombre: 'HIP THRUST CON BARRA',
              tipo: 'Peso Libre',
              seriesReps: '4x10-12',
              descanso: '90-120 seg',
              urlGif: 'assets/RUTINAS/RUTINA_AVANZADO/PITBULL_AVANZADO/DE_6_DIAS/DIA_SABADO/3_HIP_THUST_CON_BARRA.mp4',
            ),
            Ejercicio(
              nombre: 'ISQUIOTIBIALES ACOSTADO',
              tipo: 'Máquina',
              seriesReps: '4x12-15',
              descanso: '60-90 seg',
              urlGif: 'assets/RUTINAS/RUTINA_AVANZADO/PITBULL_AVANZADO/DE_6_DIAS/DIA_SABADO/4_ISQUIOTIBIALES_ACOSTADO.mp4',
            ),
            Ejercicio(
              nombre: 'BANCO ISQUIOTIBIALES',
              tipo: 'Máquina',
              seriesReps: '4x12-15',
              descanso: '60-90 seg',
              urlGif: 'assets/RUTINAS/RUTINA_AVANZADO/PITBULL_AVANZADO/DE_6_DIAS/DIA_SABADO/5_BANCO_ISQUIOTIBIALES.mp4',
            ),
            Ejercicio(
              nombre: 'PRESS GEMELOS',
              tipo: 'Máquina / Prensa',
              seriesReps: '4x15-20',
              descanso: '60 seg',
              urlGif: 'assets/RUTINAS/RUTINA_AVANZADO/PITBULL_AVANZADO/DE_6_DIAS/DIA_SABADO/6_PRESS_GEMELOS.mp4',
            ),
          ],
        ),
      ],
    );
  }

  RutinaAdaptacion _createMockRutina(String id, String variante, int numDias) {
    return RutinaAdaptacion(
      id: id,
      variante: variante,
      dias: List.generate(numDias, (i) {
        return DiaRutina(
          nombreDia: 'Día ${i + 1}',
          ejercicios: [
            Ejercicio(
              nombre: 'Ejercicio de Ejemplo ${i + 1}.1',
              tipo: 'Máquina',
              seriesReps: '3x12',
              descanso: '60 seg',
              urlGif: 'assets/images/exercises/squat.gif',
              instruccion: 'Realiza el movimiento de forma controlada.',
            ),
            Ejercicio(
              nombre: 'Ejercicio de Ejemplo ${i + 1}.2',
              tipo: 'Peso Libre',
              seriesReps: '4x10',
              descanso: '90 seg',
              urlGif: 'assets/images/exercises/bench_press.gif',
              instruccion: 'Mantén una buena postura durante todo el ejercicio.',
            ),
          ],
        );
      }),
    );
  }

  // Comienza una sesión
  void iniciarSesion(DiaRutina dia, String variante) {
    // Clonamos el día para que cada vez empiece fresco
    _rutinaActiva = DiaRutina(
      nombreDia: dia.nombreDia,
      ejercicios: dia.ejercicios
          .map((e) => e.copyWith(isCompleted: false))
          .toList(),
    );
    _varianteActiva = variante;
    notifyListeners();
  }

  // Tacha/Destacha un ejercicio
  void toggleEjercicio(int index) {
    if (_rutinaActiva == null) return;

    final ej = _rutinaActiva!.ejercicios[index];
    _rutinaActiva!.ejercicios[index] = ej.copyWith(
      isCompleted: !ej.isCompleted,
    );
    notifyListeners();
  }

  // Finaliza y limpia el dashboard
  void finalizarSesion() {
    _rutinaActiva = null;
    _varianteActiva = '';
    notifyListeners();
  }
}
