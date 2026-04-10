import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import 'rutina_adaptacion_page.dart';

class Routine {
  final String title;
  final String description;
  final String imagePath;
  final String duration;
  final String level;

  Routine({required this.title, required this.description, required this.imagePath, required this.duration, required this.level});
}

class RoutinesPage extends StatefulWidget {
  @override
  _RoutinesPageState createState() => _RoutinesPageState();
}

class _RoutinesPageState extends State<RoutinesPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<Routine> beginnerRoutines = [
    Routine(title: 'Full Body Adaptación', description: 'Rutina de 3 días para adaptar el cuerpo. Ejercicios básicos con peso corporal y máquinas.', imagePath: 'assets/images/beginner.png', duration: '45 min', level: 'Principiante'),
    Routine(title: 'Tren Superior Básico', description: 'Enfoque en pecho, espalda y brazos para principiantes. Ideal para fuerza inicial.', imagePath: 'assets/images/beginner.png', duration: '50 min', level: 'Principiante'),
    Routine(title: 'Tren Inferior y Core', description: 'Fortalecimiento de piernas, glúteos y zona media para una base sólida.', imagePath: 'assets/images/beginner.png', duration: '40 min', level: 'Principiante'),
  ];

  final List<Routine> intermediateRoutines = [
    Routine(title: 'Push / Pull / Legs', description: 'División clásica de empuje, tirón y piernas. 3 a 6 días por semana.', imagePath: 'assets/images/intermediate.png', duration: '60 min', level: 'Intermedio'),
    Routine(title: 'Torso / Pierna', description: 'Rutina de 4 días enfocada en la hipertrofia general. Frecuencia 2.', imagePath: 'assets/images/intermediate.png', duration: '65 min', level: 'Intermedio'),
    Routine(title: 'Funcional Híbrida', description: 'Combina levantamientos de pesas básicos con intervalos de alta intensidad (HIIT).', imagePath: 'assets/images/intermediate.png', duration: '55 min', level: 'Intermedio'),
  ];

  final List<Routine> advancedRoutines = [
    Routine(title: 'Arnold Split', description: 'Pecho/Espalda, Hombros/Brazos, Piernas. Alta frecuencia y volumen extremo.', imagePath: 'assets/images/advanced.png', duration: '90 min', level: 'Avanzado'),
    Routine(title: '5x5 Fuerza Pura', description: 'Sentadilla, Press de Banca y Peso Muerto pesado. Enfoque exclusivo en fuerza máxima.', imagePath: 'assets/images/advanced.png', duration: '80 min', level: 'Avanzado'),
    Routine(title: 'Hipertrofia Intensiva', description: 'Uso avanzado de Dropsets, Superseries y Myo-reps para llevar el músculo al fallo absoluto.', imagePath: 'assets/images/advanced.png', duration: '75 min', level: 'Avanzado'),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenW = MediaQuery.of(context).size.width;
    final isSmall = screenW < 380;

    return Scaffold(
      appBar: AppBar(
        title: Text('RUTINAS DE ENTRENO', style: TextStyle(fontSize: isSmall ? 16 : 20)),
        bottom: TabBar(
          controller: _tabController,
          labelColor: AppTheme.goldAccent,
          unselectedLabelColor: Colors.white60,
          indicatorColor: AppTheme.goldAccent,
          labelStyle: TextStyle(fontSize: isSmall ? 11 : 14, fontWeight: FontWeight.bold),
          tabs: const [
            Tab(text: 'PRINCIPIANTE'),
            Tab(text: 'INTERMEDIO'),
            Tab(text: 'AVANZADO'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildRoutineList(beginnerRoutines),
          _buildRoutineList(intermediateRoutines),
          _buildRoutineList(advancedRoutines),
        ],
      ),
    );
  }

  Widget _buildRoutineList(List<Routine> routines) {
    final screenW = MediaQuery.of(context).size.width;
    final screenH = MediaQuery.of(context).size.height;
    final isSmall = screenW < 380;
    final imgH = (screenH * 0.22).clamp(120.0, 200.0);

    return ListView.builder(
      padding: EdgeInsets.all(isSmall ? 10 : 16),
      itemCount: routines.length,
      itemBuilder: (context, index) {
        final routine = routines[index];
        return Card(
          margin: EdgeInsets.only(bottom: isSmall ? 12 : 16),
          color: AppTheme.warmGrey,
          clipBehavior: Clip.antiAlias,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset(
                routine.imagePath,
                height: imgH,
                fit: BoxFit.cover,
                alignment: Alignment.center,
              ),
              Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            routine.title,
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppTheme.goldAccent),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppTheme.charcoalBackground,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: AppTheme.goldAccent, width: 1),
                          ),
                          child: Text(
                            routine.duration,
                            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppTheme.goldAccent),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Text(
                      routine.description,
                      style: TextStyle(color: Colors.white70, fontSize: 14),
                    ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        if (routine.title == 'Full Body Adaptación') {
                          Navigator.push(context, MaterialPageRoute(builder: (_) => const RutinaAdaptacionPage()));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Iniciando rutina: ${routine.title}')),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.charcoalBackground,
                        side: BorderSide(color: AppTheme.goldAccent),
                      ),
                      child: Text('VER EJERCICIOS', style: TextStyle(color: AppTheme.goldAccent)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
