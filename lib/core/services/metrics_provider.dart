import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class MetricsProvider with ChangeNotifier {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Agua
  List<DateTime> _waterLogs = [];
  String _lastWaterDate = '';

  // Peso
  double? _currentWeight;
  double? _lastWeight;

  // Mercado local
  final Map<String, bool> _supermarketChecks = {};

  int get waterGlasses => _waterLogs.length;
  List<DateTime> get waterLogs => List.unmodifiable(_waterLogs);
  double? get currentWeight => _currentWeight;
  double? get lastWeight => _lastWeight;

  MetricsProvider() {
    _loadLocalChecks();
    _initDailyWater();
    _fetchWeightHistory();
  }

  String _getTodayDateStr() {
    return DateFormat('yyyy-MM-dd').format(DateTime.now());
  }

  // --- HIDRATACION ---
  Future<void> _initDailyWater() async {
    final user = FirebaseAuth.instance.currentUser;
    final today = _getTodayDateStr();

    if (user == null) {
      _loadLocalWaterLogs(today);
      return;
    }

    try {
      final doc = await _db
          .collection('user_metrics')
          .doc(user.uid)
          .collection('water_log')
          .doc(today)
          .get();

      if (doc.exists) {
        final data = doc.data();
        if (data != null && data.containsKey('logs')) {
          final List<dynamic> rawLogs = data['logs'];
          _waterLogs = rawLogs.map((e) {
            if (e is Timestamp) return e.toDate();
            if (e is String) return DateTime.tryParse(e) ?? DateTime.now();
            return DateTime.now();
          }).toList();
        } else {
          _waterLogs = [];
        }
        _lastWaterDate = today;
      } else {
        _waterLogs = [];
        _lastWaterDate = today;
        await _updateWaterInFirestore();
      }
      notifyListeners();
    } catch (e) {
      debugPrint("Error al inicializar agua desde Firestore: $e");
      _loadLocalWaterLogs(today);
    }
  }

  void _loadLocalWaterLogs(String today) {
    // Si falla o no hay usuario, limpiar o usar caché simple
    if (_lastWaterDate != today) {
      _waterLogs = [];
      _lastWaterDate = today;
    }
    notifyListeners();
  }

  Future<void> addWaterGlass([DateTime? time]) async {
    await _checkAndResetForNewDay();
    _waterLogs.add(time ?? DateTime.now());
    notifyListeners(); // Optimistic update!
    
    await _updateWaterInFirestore();
  }

  Future<void> removeWaterGlass() async {
    if (_waterLogs.isNotEmpty) {
      await _checkAndResetForNewDay();
      _waterLogs.removeLast();
      notifyListeners(); // Optimistic update!
      
      await _updateWaterInFirestore();
    }
  }
  
  Future<void> removeWaterGlassAt(int index) async {
    if (index >= 0 && index < _waterLogs.length) {
      _waterLogs.removeAt(index);
      notifyListeners();
      await _updateWaterInFirestore();
    }
  }

  Future<void> updateWaterGlassTime(int index, DateTime newTime) async {
    if (index >= 0 && index < _waterLogs.length) {
      _waterLogs[index] = newTime;
      // Sort to keep chronological order
      _waterLogs.sort((a, b) => a.compareTo(b));
      notifyListeners();
      await _updateWaterInFirestore();
    }
  }

  Future<void> _checkAndResetForNewDay() async {
    final today = _getTodayDateStr();
    if (_lastWaterDate != today) {
      _waterLogs = [];
      _lastWaterDate = today;
    }
  }

  Future<void> _updateWaterInFirestore() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final today = _getTodayDateStr();
    try {
      await _db
          .collection('user_metrics')
          .doc(user.uid)
          .collection('water_log')
          .doc(today)
          .set({
            'logs': _waterLogs.map((e) => e.toIso8601String()).toList(),
            'count': _waterLogs.length,
            'timestamp': FieldValue.serverTimestamp(),
          }, SetOptions(merge: true));
    } catch (e) {
      debugPrint("Error guardando agua: $e");
    }
  }

  // --- PESO ---
  Future<void> _fetchWeightHistory() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    try {
      final snapshot = await _db
          .collection('user_metrics')
          .doc(user.uid)
          .collection('weight_history')
          .orderBy('timestamp', descending: true)
          .limit(2) // Traemos el último y el anterior
          .get();

      if (snapshot.docs.isNotEmpty) {
        _currentWeight = (snapshot.docs[0].data()['weight'] as num).toDouble();
        if (snapshot.docs.length > 1) {
          _lastWeight = (snapshot.docs[1].data()['weight'] as num).toDouble();
        } else {
          _lastWeight = _currentWeight; // Sin registro previo
        }
      }
      notifyListeners();
    } catch (e) {
      debugPrint("Error historial de peso: $e");
    }
  }

  Future<void> saveDailyWeight(double weight) async {
    if (weight < 40 || weight > 200) {
      return; // Validación límite para ambos géneros
    }

    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    try {
      await _db
          .collection('user_metrics')
          .doc(user.uid)
          .collection('weight_history')
          .add({'weight': weight, 'timestamp': FieldValue.serverTimestamp()});

      // Actualizar variables en memoria
      _lastWeight = _currentWeight ?? weight;
      _currentWeight = weight;
      notifyListeners();
    } catch (e) {
      debugPrint("Error guardando peso: $e");
    }
  }

  // --- COMPRAS SUPERMERCADO LOCAL ---
  Future<void> _loadLocalChecks() async {
    final prefs = await SharedPreferences.getInstance();
    final keys = prefs.getKeys();
    final today = _getTodayDateStr();

    for (String key in keys) {
      if (key.startsWith('producto_')) {
        _supermarketChecks[key] = prefs.getBool(key) ?? false;
      } else if (key.startsWith('meal_') && key.contains(today)) {
        // Clean old meals if necessary? Optional, but let's just load today's
        _supermarketChecks[key] = prefs.getBool(key) ?? false;
      }
    }
    notifyListeners();
  }

  // --- COMIDAS REALIZADAS ---
  bool isMealChecked(String dietaId, String horario) {
    final today = _getTodayDateStr();
    return _supermarketChecks['meal_${today}_${dietaId}_$horario'] ?? false;
  }

  Future<void> toggleMealCheck(String dietaId, String horario) async {
    final today = _getTodayDateStr();
    final key = 'meal_${today}_${dietaId}_$horario';
    final current = isMealChecked(dietaId, horario);

    _supermarketChecks[key] = !current;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, !current);

    notifyListeners();
  }

  bool isProductChecked(String productId) {
    return _supermarketChecks['producto_$productId'] ?? false;
  }

  Future<void> toggleProductCheck(String productId) async {
    final key = 'producto_$productId';
    final current = isProductChecked(productId);

    _supermarketChecks[key] = !current;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, !current);

    notifyListeners();
  }
}
