import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/pago_pendiente_model.dart';

class PaymentService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Notificar que se realizó la transferencia
  Future<void> notifyTransfer({
    required String userId,
    required String nombre,
  }) async {
    await _db.collection('pagos_pendientes').add({
      'userId': userId,
      'nombre': nombre,
      'fecha': Timestamp.now(),
      'estado': 'pendiente',
    });
  }

  // Stream para verificar si el usuario tiene un pago pendiente
  Stream<bool> hasPendingPayment(String userId) {
    return _db
        .collection('pagos_pendientes')
        .where('userId', isEqualTo: userId)
        .where('estado', isEqualTo: 'pendiente')
        .snapshots()
        .map((snapshot) => snapshot.docs.isNotEmpty);
  }
}
