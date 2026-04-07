import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/usuario_model.dart';

enum AuthStatus { loading, authenticated, unauthenticated }

class AuthProvider with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  User? _firebaseUser;
  UsuarioModel? _perfil;
  AuthStatus _status = AuthStatus.loading;
  String? _errorMessage;

  User? get firebaseUser => _firebaseUser;
  UsuarioModel? get perfil => _perfil;
  AuthStatus get status => _status;
  String? get errorMessage => _errorMessage;
  String? get uid => _firebaseUser?.uid;

  AuthProvider() {
    // Escuchar cambios de sesión en tiempo real
    _auth.authStateChanges().listen(_onAuthStateChanged);
  }

  Future<void> _onAuthStateChanged(User? user) async {
    _firebaseUser = user;
    if (user == null) {
      _perfil = null;
      _status = AuthStatus.unauthenticated;
    } else {
      await _cargarPerfil(user.uid);
      _status = AuthStatus.authenticated;
    }
    notifyListeners();
  }

  Future<void> _cargarPerfil(String uid) async {
    try {
      final doc = await _db.collection('usuarios').doc(uid).get();
      if (doc.exists) {
        _perfil = UsuarioModel.fromFirestore(doc);
      }
    } catch (e) {
      debugPrint('Error cargando perfil: $e');
    }
  }

  // ── Login ──────────────────────────────────────────────────────────────────
  Future<bool> login(String email, String password) async {
    _errorMessage = null;
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      if (credential.user != null && !credential.user!.emailVerified) {
        _errorMessage = 'Debes verificar tu email antes de entrar. Revisa tu bandeja de entrada o correo no deseado.';
        await _auth.signOut();
        notifyListeners();
        return false;
      }
      return true;
    } on FirebaseAuthException catch (e) {
      _errorMessage = _traducirError(e.code);
      notifyListeners();
      return false;
    }
  }

  // ── Registro ───────────────────────────────────────────────────────────────
  Future<bool> register({
    required String nombre,
    required String email,
    required String password,
    required String documento,
    required String objetivo,
    required int diaPagoFijo,
  }) async {
    _errorMessage = null;
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      final user = credential.user!;

      // Actualizar displayName en Firebase Auth
      await user.updateDisplayName(nombre);

      final perfil = UsuarioModel(
        uid: user.uid,
        nombre: nombre,
        email: email.trim(),
        documento: documento,
        objetivo: objetivo,
        diaPagoFijo: diaPagoFijo,
        rutinasAsignadas: [],
        rol: 'miembro',
        fechaRegistro: DateTime.now(),
      );
      await _db.collection('usuarios').doc(user.uid).set(perfil.toFirestore());
      
      // Enviar email de verificación y cerrar sesión temporalmente
      await user.sendEmailVerification();
      await _auth.signOut();

      return true;
    } on FirebaseAuthException catch (e) {
      _errorMessage = _traducirError(e.code);
      notifyListeners();
      return false;
    }
  }

  // ── Logout ─────────────────────────────────────────────────────────────────
  Future<void> logout() async {
    await _auth.signOut();
  }

  // ── Traducción de errores de Firebase ─────────────────────────────────────
  String _traducirError(String code) {
    switch (code) {
      case 'user-not-found':
        return 'No existe una cuenta con ese email.';
      case 'wrong-password':
        return 'Contraseña incorrecta. Intentá de nuevo.';
      case 'invalid-email':
        return 'El formato del email no es válido.';
      case 'email-already-in-use':
        return 'Ya existe una cuenta con ese email.';
      case 'weak-password':
        return 'La contraseña debe tener al menos 6 caracteres.';
      case 'too-many-requests':
        return 'Demasiados intentos. Esperá unos minutos.';
      case 'network-request-failed':
        return 'Sin conexión a internet.';
      case 'invalid-credential':
        return 'Email o contraseña incorrectos.';
      default:
        return 'Error: $code';
    }
  }
}
