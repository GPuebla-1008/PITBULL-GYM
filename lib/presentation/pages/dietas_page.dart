import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/theme/app_theme.dart';
import 'dieta_mujer_definicion_page.dart';
import 'dieta_hombre_definicion_page.dart';
import 'dieta_mujer_ganancia_page.dart';
import 'dieta_hombre_ganancia_page.dart';

class DietasRecomendadasPage extends StatelessWidget {
  const DietasRecomendadasPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.charcoalBackground,
      appBar: AppBar(
        title: Text(
          'Planes de Alimentación',
          style: GoogleFonts.outfit(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: AppTheme.deepBlack,
        iconTheme: const IconThemeData(color: AppTheme.goldAccent),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Center(
              child: Image.asset(
                'assets/images/dietas_logo.png',
                height: 180,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 32),
            _buildDietaShortcut(
              context,
              title: 'Definición para Mujeres',
              subtitle: 'Quema de grasa y tonificación',
              icon: Icons.local_fire_department,
              color: Colors.greenAccent.shade400,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const DietaMujerDefinicionPage(),
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
            _buildDietaShortcut(
              context,
              title: 'Definición para Hombres',
              subtitle: 'Reducción de porcentaje graso',
              icon: Icons.whatshot,
              color: Colors.greenAccent.shade700,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const DietaHombreDefinicionPage(),
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
            _buildDietaShortcut(
              context,
              title: 'Ganancia Muscular para Mujeres',
              subtitle: 'Construcción de masa magra',
              icon: Icons.fitness_center,
              color: Colors.lightGreen.shade400,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const DietaMujerGananciaPage(),
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
            _buildDietaShortcut(
              context,
              title: 'Ganancia Muscular para Hombres',
              subtitle: 'Hipertrofia y volumen',
              icon: Icons.sports_gymnastics,
              color: Colors.lightGreen.shade700,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const DietaHombreGananciaPage(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDietaShortcut(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Card(
      color: AppTheme.warmGrey,
      elevation: 4,
      shadowColor: Colors.black45,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  shape: BoxShape.circle,
                  border: Border.all(color: color.withOpacity(0.5), width: 1),
                ),
                child: Icon(icon, color: color, size: 32),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.outfit(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.arrow_forward_ios, color: color),
            ],
          ),
        ),
      ),
    );
  }
}
