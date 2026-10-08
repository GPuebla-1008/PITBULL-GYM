import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:pitbull_gym_pwa/core/services/seed_rutinas_service.dart';

void main() {
  group('Rutina Avanzado Mujer Tests', () {
    test('Verificar Rutina Pitbull Mujer Avanzado 5 Días', () {
      final rutina = SeedRutinasService.createPitbullMujerAvanzado5Dias();
      expect(rutina.id, 'pitbull_mujer_avanzado_5_dias');
      expect(rutina.variante, '5 Días/Semana');
      expect(rutina.dias.length, 5);

      final diasEsperados = ['Lunes', 'Martes', 'Miércoles', 'Jueves', 'Viernes'];
      for (int i = 0; i < rutina.dias.length; i++) {
        final dia = rutina.dias[i];
        expect(dia.nombreDia, diasEsperados[i]);
        expect(dia.ejercicios.isNotEmpty, true);
        for (final ej in dia.ejercicios) {
          expect(ej.nombre.isNotEmpty, true);
          expect(ej.urlGif.endsWith('.mp4'), true,
              reason: '${ej.nombre} debe ser un video .mp4');
          expect(
            ej.urlGif.startsWith(
                'assets/RUTINAS/RUTINA_AVANZADO/PITBULL_MUJER/DE_5_DIAS/'),
            true,
            reason: '${ej.nombre} debe apuntar al directorio de PITBULL_MUJER',
          );
          expect(
            File(ej.urlGif).existsSync(),
            true,
            reason: 'El archivo de video no existe en disco: ${ej.urlGif}',
          );
        }
      }
    });
  });
}
