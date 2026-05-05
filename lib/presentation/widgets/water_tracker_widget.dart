import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/services/metrics_provider.dart';
import '../../core/services/notification_service.dart';

class WaterTrackerWidget extends StatelessWidget {
  const WaterTrackerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final metrics = context.watch<MetricsProvider>();
    const meta = 15; // 15 vasos (~3.75L) - podemos dejar esto fijo o depender del perfil
    final objAlcanzado = metrics.waterGlasses >= meta;

    return Card(
      color: Colors.blue.shade900.withOpacity(0.3),
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.blueAccent.withOpacity(0.5)),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                // El Pitbull Asistente de Agua
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                'assets/images/pitbull_water_assistant.png',
                width: 80,
                height: 80,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(Icons.water_drop, color: Colors.blueAccent, size: 80);
                },
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hidratación Diaria',
                    style: GoogleFonts.outfit(
                      color: Colors.lightBlueAccent,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    '${metrics.waterGlasses} de $meta vasos (3.75L)',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurface,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      _roundedBtn(
                        Icons.remove,
                        () => metrics.removeWaterGlass(),
                        Colors.blueGrey,
                      ),
                      SizedBox(width: 16),
                      _roundedBtn(
                        Icons.add,
                        () {
                          metrics.addWaterGlass();
                          if (NotificationService.isGranted) {
                            NotificationService.scheduleWaterReminder(const Duration(hours: 2));
                          }
                        },
                        Colors.lightBlueAccent,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Circular progress indicador
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 50,
                  height: 50,
                  child: CircularProgressIndicator(
                    value: (metrics.waterGlasses / meta).clamp(0.0, 1.0),
                    strokeWidth: 5,
                    backgroundColor: Colors.blue.shade900,
                    color: Colors.lightBlueAccent,
                  ),
                ),
                Icon(
                  objAlcanzado ? Icons.verified : Icons.water_drop,
                  color: Colors.lightBlueAccent,
                  size: 20,
                ),
              ],
            ),
          ],
        ),
        _buildTimeLogs(context, metrics),
      ],
    ),
  ),
);
  }

  Widget _buildTimeLogs(BuildContext context, MetricsProvider metrics) {
    if (metrics.waterLogs.isEmpty) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Divider(color: Colors.blueAccent.withOpacity(0.5)),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: List.generate(metrics.waterLogs.length, (index) {
            final time = metrics.waterLogs[index];
            final timeStr = TimeOfDay.fromDateTime(time).format(context);
            return InkWell(
              onTap: () async {
                final newTime = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.fromDateTime(time),
                );
                if (newTime != null) {
                  final now = DateTime.now();
                  final dt = DateTime(now.year, now.month, now.day, newTime.hour, newTime.minute);
                  metrics.updateWaterGlassTime(index, dt);
                }
              },
              child: Chip(
                label: Text(timeStr, style: TextStyle(fontSize: 12, color: Colors.white)),
                avatar: const Icon(Icons.water_drop, size: 14, color: Colors.lightBlueAccent),
                backgroundColor: Colors.blue.shade900.withOpacity(0.6),
                deleteIcon: const Icon(Icons.close, size: 14, color: Colors.white70),
                onDeleted: () => metrics.removeWaterGlassAt(index),
                side: BorderSide.none,
                visualDensity: VisualDensity.compact,
              ),
            );
          }),
        ),
      ],
    );
  }

  Widget _roundedBtn(IconData ico, VoidCallback onTap, Color bg) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: bg.withOpacity(0.2),
          border: Border.all(color: bg),
        ),
        child: Icon(ico, color: bg, size: 24),
      ),
    );
  }
}
