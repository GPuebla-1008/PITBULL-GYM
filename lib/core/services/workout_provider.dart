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
      RutinaAdaptacion(
        id: 'fullbody_fallback',
        variante: '3 Días',
        dias: [
          DiaRutina(
            nombreDia: 'Día 1 (A)',
            ejercicios: [
              Ejercicio(
                nombre: 'Sentadillas',
                tipo: 'Máquina / Peso Libre',
                seriesReps: '3x12',
                descanso: '90 seg',
                urlGif: 'assets/images/exercises/squat.gif',
                instruccion: 'Mantén la espalda recta.',
              ),
              Ejercicio(
                nombre: 'Press de Banca',
                tipo: 'Máquina / Barra',
                seriesReps: '3x10',
                descanso: '90 seg',
                urlGif: 'assets/images/exercises/bench_press.gif',
                instruccion: 'Baja controlado hasta el pecho.',
              ),
            ],
          ),
        ],
      ),
      RutinaAdaptacion(
        id: 'principiante_fallback',
        variante: '3 Días',
        dias: [
          DiaRutina(
            nombreDia: 'Tren Superior',
            ejercicios: [
              Ejercicio(
                nombre: 'Jalón al Pecho',
                tipo: 'Máquina',
                seriesReps: '3x12',
                descanso: '60 seg',
                urlGif: 'assets/images/exercises/lat_pulldown.gif',
                instruccion: 'Lleva la barra hacia la parte superior del pecho.',
              ),
            ],
          ),
        ],
      ),
    ];
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
