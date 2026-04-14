import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../models/supplement_model.dart';

class SupplementService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Colección: user_supplement_plans
  CollectionReference get _plansRef => _db.collection('user_supplement_plans');

  Future<void> savePlan(SupplementPlan plan) async {
    final user = _auth.currentUser;
    if (user == null) return;

    await _plansRef.doc(user.uid).set(plan.toMap(), SetOptions(merge: true));
  }

  Future<SupplementPlan?> getPlan() async {
    final user = _auth.currentUser;
    if (user == null) return null;

    final doc = await _plansRef.doc(user.uid).get();
    if (!doc.exists) return null;

    return SupplementPlan.fromMap(doc.id, doc.data() as Map<String, dynamic>);
  }

  // Lógica de cálculo de horarios
  String calculateAbsoluteTiming(
    TimeOfDay trainingTime,
    String relativeTiming,
  ) {
    switch (relativeTiming) {
      case 'Pre-Entreno':
        final pre = _subtractMinutes(trainingTime, 30);
        return _formatTimeOfDay(pre);
      case 'Post-Entreno':
        final post = _addMinutes(trainingTime, 45);
        return _formatTimeOfDay(post);
      case 'Ayunas':
        return '08:00 AM';
      case 'Con el Almuerzo':
        return '01:00 PM';
      case 'Antes de dormir':
        return '10:30 PM';
      default:
        return '09:00 AM';
    }
  }

  TimeOfDay _addMinutes(TimeOfDay time, int minutes) {
    int totalMinutes = time.hour * 60 + time.minute + minutes;
    return TimeOfDay(
      hour: (totalMinutes ~/ 60) % 24,
      minute: totalMinutes % 60,
    );
  }

  TimeOfDay _subtractMinutes(TimeOfDay time, int minutes) {
    int totalMinutes = time.hour * 60 + time.minute - minutes;
    if (totalMinutes < 0) totalMinutes += 24 * 60;
    return TimeOfDay(
      hour: (totalMinutes ~/ 60) % 24,
      minute: totalMinutes % 60,
    );
  }

  String _formatTimeOfDay(TimeOfDay time) {
    final hour = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
    final period = time.period == DayPeriod.am ? 'AM' : 'PM';
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute $period';
  }

  // Semillas de datos según objetivo y sexo
  List<SupplementItem> getRecommendedSupplements(String goal, String gender) {
    if (goal == 'bulk') {
      if (gender == 'male') {
        return [
          SupplementItem(
            name: 'Creatina Monohidrato',
            dosage: '5g',
            relativeTiming: 'Pre-Entreno',
            description: 'Mejora la fuerza explosiva y recuperación.',
          ),
          SupplementItem(
            name: 'Whey Protein',
            dosage: '40g',
            relativeTiming: 'Post-Entreno',
            description:
                'Proteína de suero + 50g de Carbs para volumen masivo.',
          ),
          SupplementItem(
            name: 'Multivitamínico',
            dosage: '1 cápsula',
            relativeTiming: 'Ayunas',
            description: 'Micronutrientes esenciales para el metabolismo.',
          ),
          SupplementItem(
            name: 'Caseína Micelar',
            dosage: '30g',
            relativeTiming: 'Antes de dormir',
            description:
                'Proteína de absorción lenta para evitar catabolismo nocturno.',
          ),
        ];
      } else {
        return [
          SupplementItem(
            name: 'Creatina Monohidrato',
            dosage: '3g',
            relativeTiming: 'Pre-Entreno',
            description: 'Aumenta rendimiento sin retención excesiva.',
          ),
          SupplementItem(
            name: 'Whey Protein',
            dosage: '25g',
            relativeTiming: 'Post-Entreno',
            description: 'Favorece síntesis proteica después del entreno.',
          ),
          SupplementItem(
            name: 'Magnesio (Citrato)',
            dosage: '400mg',
            relativeTiming: 'Antes de dormir',
            description: 'Mejora descanso muscular y sistema nervioso.',
          ),
          SupplementItem(
            name: 'BCAA 2:1:1',
            dosage: '5g',
            relativeTiming: 'Pre-Entreno',
            description: 'Aminoácidos para protección muscular.',
          ),
        ];
      }
    } else {
      // 'cut' (Definición)
      if (gender == 'male') {
        return [
          SupplementItem(
            name: 'Cafeína Anhidra',
            dosage: '200mg',
            relativeTiming: 'Pre-Entreno',
            description: 'Aumenta termogénesis y enfoque mental.',
          ),
          SupplementItem(
            name: 'Whey Isolate',
            dosage: '30g',
            relativeTiming: 'Post-Entreno',
            description: 'Proteína pura sin carbohidratos.',
          ),
          SupplementItem(
            name: 'Omega 3',
            dosage: '2g',
            relativeTiming: 'Con el Almuerzo',
            description: 'Ácidos grasos esenciales para salud cardiovascular.',
          ),
          SupplementItem(
            name: 'L-Glutamina',
            dosage: '5g',
            relativeTiming: 'Antes de dormir',
            description: 'Recuperación intestinal y muscular en déficit.',
          ),
        ];
      } else {
        return [
          SupplementItem(
            name: 'Cafeína o Té Verde',
            dosage: '100mg',
            relativeTiming: 'Pre-Entreno',
            description: 'Metabolizdor de grasas de impacto suave.',
          ),
          SupplementItem(
            name: 'Whey Isolate',
            dosage: '20g',
            relativeTiming: 'Post-Entreno',
            description: 'Bajo en calorías, alto en saciedad.',
          ),
          SupplementItem(
            name: 'Colágeno Hidrolizado',
            dosage: '10g',
            relativeTiming: 'Ayunas',
            description:
                'Salud de articulaciones y piel durante la definición.',
          ),
          SupplementItem(
            name: 'Omega 3',
            dosage: '1g',
            relativeTiming: 'Con el Almuerzo',
            description: 'Regulación hormonal y antiinflamatorio.',
          ),
        ];
      }
    }
  }
}
