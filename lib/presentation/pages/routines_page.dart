import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import 'rutina_adaptacion_page.dart';
import 'rutina_principiante_page.dart';
import 'rutina_intermedia_page.dart';
import 'rutina_avanzada_page.dart';

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
    Routine(title: 'Rutina Principiante (3 y 5 días)', description: 'Frecuencia flexible. Combina máquinas, poleas y mancuernas para una progresión constante.', imagePath: 'assets/images/beginner.png', duration: '50-60 min', level: 'Principiante'),
    Routine(title: 'Tren Inferior y Core', description: 'Fortalecimiento de piernas, glúteos y zona media para una base sólida.', imagePath: 'assets/images/beginner.png', duration: '40 min', level: 'Principiante'),
  ];

  final List<Routine> intermediateRoutines = [
    Routine(title: 'Rutina Intermedia (3 y 5 días)', description: 'Frecuencia de 3 días Full Body o 5 días combinando PPL y Torso/Pierna.', imagePath: 'assets/images/intermediate.png', duration: '60-75 min', level: 'Intermedio'),
  ];

  final List<Routine> advancedRoutines = [
    Routine(title: 'Arnold Split (6 Días)', description: 'Alta frecuencia y volumen. Antagonistas en superserie.', imagePath: 'assets/images/advanced.png', duration: '90 min', level: 'Avanzado'),
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
                        } else if (routine.title == 'Rutina Principiante (3 y 5 días)') {
                          Navigator.push(context, MaterialPageRoute(builder: (_) => const RutinaPrincipiantePage()));
                        } else if (routine.title == 'Rutina Intermedia (3 y 5 días)') {
                          Navigator.push(context, MaterialPageRoute(builder: (_) => const RutinaIntermediaPage()));
                        } else if (routine.title == 'Arnold Split (6 Días)') {
                          Navigator.push(context, MaterialPageRoute(builder: (_) => const RutinaAvanzadaPage()));
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
