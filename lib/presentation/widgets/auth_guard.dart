import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import '../../core/services/auth_provider.dart';
import '../../core/models/usuario_model.dart';
import '../../core/theme/app_theme.dart';
import '../pages/blocked_screen.dart';
import '../pages/login_page.dart';

class AuthGuard extends StatelessWidget {
  final Widget child;

  const AuthGuard({super.key, required this.child});

  bool _isBlocked(UsuarioModel perfil) {
    // 1. Los administradores nunca se bloquean
    if (perfil.isAdmin || perfil.rol == 'admin') return false;

    // 2. Si tiene fecha de vencimiento y ya pasó la fecha/hora actual -> BLOQUEADO
    if (perfil.expiryDate != null && DateTime.now().isAfter(perfil.expiryDate!)) {
      return true;
    }

    // 3. Si el estado de suscripción está marcado como inactivo -> BLOQUEADO
    if (perfil.subscriptionStatus == 'inactivo') {
      return true;
    }

    // 4. Si no tiene fecha de vencimiento y no está marcado como activo -> BLOQUEADO
    if (perfil.expiryDate == null && perfil.subscriptionStatus != 'activo') {
      return true;
    }

    return false; // Membresía vigente
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();
    final user = authProvider.firebaseUser;

    // Si no hay usuario autenticado en Firebase, mandarlo al login
    if (user == null) {
      return const LoginPage();
    }

    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance.collection('usuarios').doc(user.uid).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Scaffold(
            body: Center(child: Text('Error al cargar datos de sesión.')),
          );
        }

        if (snapshot.connectionState == ConnectionState.waiting && !snapshot.hasData) {
          return const Scaffold(
            backgroundColor: AppTheme.charcoalBackground,
            body: Center(
              child: CircularProgressIndicator(color: AppTheme.goldAccent),
            ),
          );
        }

        if (!snapshot.hasData || !snapshot.data!.exists) {
          // Si el documento no existe aún, mostramos carga
          return const Scaffold(
            backgroundColor: AppTheme.charcoalBackground,
            body: Center(
              child: CircularProgressIndicator(color: AppTheme.goldAccent),
            ),
          );
        }

        final perfil = UsuarioModel.fromFirestore(snapshot.data!);

        // Evaluar si debe ser bloqueado
        if (_isBlocked(perfil)) {
          // Si hay subpantallas abiertas en el navegador, cerrarlas para volver a la raíz
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (context.mounted && Navigator.of(context).canPop()) {
              Navigator.of(context).popUntil((route) => route.isFirst);
            }
          });
          return BlockedScreen(perfil: perfil);
        }

        // Si todo está bien, mostrar el contenido protegido
        return child;
      },
    );
  }
}
