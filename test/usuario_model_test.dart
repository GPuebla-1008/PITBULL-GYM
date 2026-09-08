import 'package:flutter_test/flutter_test.dart';
import 'package:pitbull_gym_pwa/core/models/usuario_model.dart';

void main() {
  group('UsuarioModel Tests', () {
    test('Creación por defecto tiene rol miembro y no es admin', () {
      final user = UsuarioModel(
        uid: 'test-uid-123',
        nombre: 'Socio Test',
        email: 'socio@pitbullgym.com',
        documento: '12345678',
        objetivo: 'Hipertrofia',
        fechaRegistro: DateTime(2026, 1, 1),
      );

      expect(user.uid, 'test-uid-123');
      expect(user.rol, 'miembro');
      expect(user.isAdmin, false);
      expect(user.subscriptionStatus, 'inactivo');
      expect(user.diaPagoFijo, 10);
    });

    test('copyWith actualiza rol y estado correctamente', () {
      final user = UsuarioModel(
        uid: 'admin-1',
        nombre: 'Admin',
        email: 'admin@pitbullgym.com',
        documento: '87654321',
        objetivo: 'Fuerza',
        fechaRegistro: DateTime(2026, 1, 1),
      );

      final adminUser = user.copyWith(
        isAdmin: true,
        rol: 'admin',
        subscriptionStatus: 'activo',
      );

      expect(adminUser.isAdmin, true);
      expect(adminUser.rol, 'admin');
      expect(adminUser.subscriptionStatus, 'activo');
      expect(adminUser.nombre, 'Admin'); // Conserva campos anteriores
    });
  });
}
