import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:pitbull_gym_pwa/core/services/seed_rutinas_service.dart';

void main() {
  group('Rutinas Intermedio Tests', () {
    test('Verificar Rutina Intermedio Hombres 3 Días', () {
      final rutina = SeedRutinasService.createIntermedioHombres3Dias();
      expect(rutina.id, 'intermedio_hombres_3_dias');
      expect(rutina.variante, '3 Días');
      expect(rutina.dias.length, 3);

      for (final dia in rutina.dias) {
        expect(dia.nombreDia.isNotEmpty, true);
        expect(dia.ejercicios.isNotEmpty, true);
        for (final ej in dia.ejercicios) {
          expect(ej.nombre.isNotEmpty, true);
          expect(ej.urlGif.endsWith('.mp4'), true, reason: '${ej.nombre} debe ser un video .mp4');
          expect(ej.urlGif.startsWith('assets/EJERCICIOS_PITBULLGYM/'), true);
          expect(File(ej.urlGif).existsSync(), true, reason: 'Archivo no existe: ${ej.urlGif}');
        }
      }
    });

    test('Verificar Rutina Intermedio Hombres 5 Días', () {
      final rutina = SeedRutinasService.createIntermedioHombres5Dias();
      expect(rutina.id, 'intermedio_hombres_5_dias');
      expect(rutina.variante, '5 Días');
      expect(rutina.dias.length, 5);

      for (final dia in rutina.dias) {
        expect(dia.nombreDia.isNotEmpty, true);
        expect(dia.ejercicios.isNotEmpty, true);
        for (final ej in dia.ejercicios) {
          expect(ej.nombre.isNotEmpty, true);
          expect(ej.urlGif.endsWith('.mp4'), true, reason: '${ej.nombre} debe ser un video .mp4');
          expect(ej.urlGif.startsWith('assets/EJERCICIOS_PITBULLGYM/'), true);
          expect(File(ej.urlGif).existsSync(), true, reason: 'Archivo no existe: ${ej.urlGif}');
        }
      }
    });

    test('Verificar Rutina Intermedio Mujeres 3 Días', () {
      final rutina = SeedRutinasService.createIntermedioMujeres3Dias();
      expect(rutina.id, 'intermedio_mujeres_3_dias');
      expect(rutina.variante, '3 Días');
      expect(rutina.dias.length, 3);

      for (final dia in rutina.dias) {
        expect(dia.nombreDia.isNotEmpty, true);
        expect(dia.ejercicios.isNotEmpty, true);
        for (final ej in dia.ejercicios) {
          expect(ej.nombre.isNotEmpty, true);
          expect(ej.urlGif.endsWith('.mp4'), true, reason: '${ej.nombre} debe ser un video .mp4');
          expect(ej.urlGif.startsWith('assets/EJERCICIOS_PITBULLGYM/'), true);
          expect(File(ej.urlGif).existsSync(), true, reason: 'Archivo no existe: ${ej.urlGif}');
        }
      }
    });

    test('Verificar Rutina Intermedio Mujeres 5 Días', () {
      final rutina = SeedRutinasService.createIntermedioMujeres5Dias();
      expect(rutina.id, 'intermedio_mujeres_5_dias');
      expect(rutina.variante, '5 Días');
      expect(rutina.dias.length, 5);

      for (final dia in rutina.dias) {
        expect(dia.nombreDia.isNotEmpty, true);
        expect(dia.ejercicios.isNotEmpty, true);
        for (final ej in dia.ejercicios) {
          expect(ej.nombre.isNotEmpty, true);
          expect(ej.urlGif.endsWith('.mp4'), true, reason: '${ej.nombre} debe ser un video .mp4');
          expect(ej.urlGif.startsWith('assets/EJERCICIOS_PITBULLGYM/'), true);
          expect(File(ej.urlGif).existsSync(), true, reason: 'Archivo no existe: ${ej.urlGif}');
        }
      }
    });
  });
}
