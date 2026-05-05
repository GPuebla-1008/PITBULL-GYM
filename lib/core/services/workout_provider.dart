import 'package:flutter/material.dart';
import '../models/rutina_adaptacion_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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

      // --- PRINCIPIANTE ---
      _createMockRutina('principiante_1', '3 Días', 3),
      _createMockRutina('principiante_2', '5 Días', 5),

      // --- INTERMEDIO ---
      _createMockRutina('intermedio_1', '3 Días', 3),
      _createMockRutina('intermedio_2', '5 Días', 5),

      // --- AVANZADO ---
      _createMockRutina('arnold_split_advanced', '6 Días - Arnold', 6),
    ];
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
