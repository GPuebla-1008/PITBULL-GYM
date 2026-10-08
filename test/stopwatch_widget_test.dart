import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pitbull_gym_pwa/presentation/widgets/stopwatch_widget.dart';

void main() {
  testWidgets('StopwatchWidget switches between Cronometro and Temporizador modes', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: StopwatchWidget(),
        ),
      ),
    );

    // Initial mode is Cronómetro
    expect(find.text('CRONÓMETRO'), findsOneWidget);
    expect(find.text('TEMPORIZADOR'), findsOneWidget);
    expect(find.text('TIEMPO TRANSCURRIDO'), findsOneWidget);

    // Switch to Temporizador
    await tester.tap(find.text('TEMPORIZADOR'));
    await tester.pumpAndSettle();

    expect(find.text('CUENTA REGRESIVA'), findsOneWidget);
    expect(find.text('30s'), findsWidgets);
    expect(find.text('45s'), findsWidgets);
    expect(find.text('+30s'), findsOneWidget);

    // Tap on 30s preset
    await tester.tap(find.text('30s').first);
    await tester.pumpAndSettle();

    expect(find.text('00:30'), findsOneWidget);

    // Switch back to Cronómetro
    await tester.tap(find.text('CRONÓMETRO'));
    await tester.pumpAndSettle();

    expect(find.text('TIEMPO TRANSCURRIDO'), findsOneWidget);
  });
}
