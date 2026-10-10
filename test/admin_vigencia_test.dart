import 'package:flutter_test/flutter_test.dart';
import 'package:pitbull_gym_pwa/core/services/admin_provider.dart';

void main() {
  group('Admin Vigencia & Membresía Tests', () {
    test('Cálculo de 1 Mes: mismo día mes siguiente caso estándar', () {
      final base = DateTime(2026, 10, 9, 14, 30);
      final resultado = AdminProvider.calcularMismoDiaMesSiguiente(base);

      expect(resultado.year, equals(2026));
      expect(resultado.month, equals(11));
      expect(resultado.day, equals(9));
      expect(resultado.hour, equals(23));
      expect(resultado.minute, equals(59));
      expect(resultado.second, equals(59));
    });

    test('Cálculo de 1 Mes: cruce de fin de año (Diciembre a Enero)', () {
      final base = DateTime(2026, 12, 15, 10, 0);
      final resultado = AdminProvider.calcularMismoDiaMesSiguiente(base);

      expect(resultado.year, equals(2027));
      expect(resultado.month, equals(1));
      expect(resultado.day, equals(15));
    });

    test('Cálculo de 1 Mes: ajuste de meses cortos (31 de Enero a Febrero)', () {
      final base = DateTime(2026, 1, 31, 10, 0);
      final resultado = AdminProvider.calcularMismoDiaMesSiguiente(base);

      expect(resultado.year, equals(2026));
      expect(resultado.month, equals(2));
      // Febrero 2026 tiene 28 días
      expect(resultado.day, equals(28));
    });

    test('Cálculo de 1 Mes: ajuste de 31 de Agosto a Septiembre (30 días)', () {
      final base = DateTime(2026, 8, 31, 12, 0);
      final resultado = AdminProvider.calcularMismoDiaMesSiguiente(base);

      expect(resultado.year, equals(2026));
      expect(resultado.month, equals(9));
      expect(resultado.day, equals(30));
    });

    test('Cálculo de 1 Día y 1 Semana', () {
      final base = DateTime(2026, 10, 9);
      final unDia = DateTime(base.year, base.month, base.day + 1, 23, 59, 59);
      final unaSemana = DateTime(base.year, base.month, base.day + 7, 23, 59, 59);

      expect(unDia.day, equals(10));
      expect(unDia.month, equals(10));
      expect(unaSemana.day, equals(16));
      expect(unaSemana.month, equals(10));
    });
  });
}
