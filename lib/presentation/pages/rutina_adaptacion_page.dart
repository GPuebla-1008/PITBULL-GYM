import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/theme/app_theme.dart';
import '../../core/services/workout_provider.dart';
import '../../core/models/rutina_adaptacion_model.dart';

class RutinaAdaptacionPage extends StatefulWidget {
  const RutinaAdaptacionPage({super.key});

  @override
  State<RutinaAdaptacionPage> createState() => _RutinaAdaptacionPageState();
}

class _RutinaAdaptacionPageState extends State<RutinaAdaptacionPage> with TickerProviderStateMixin {
  String _varianteSeleccionada = '3 Días';
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 0, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<WorkoutProvider>().fetchRutinas();
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _actualizarTabs(int cantidadDias) {
    if (_tabController.length != cantidadDias) {
      _tabController.dispose();
      _tabController = TabController(length: cantidadDias, vsync: this);
    }
  }

  @override
  Widget build(BuildContext context) {
    final workout = context.watch<WorkoutProvider>();

    if (workout.loading) {
      return Scaffold(
        backgroundColor: AppTheme.charcoalBackground,
        body: Center(child: CircularProgressIndicator(color: AppTheme.goldAccent)),
      );
    }

    final rutinaData = workout.todasLasRutinas.firstWhere(
      (r) => r.variante == _varianteSeleccionada,
      orElse: () => RutinaAdaptacion(id: '', variante: _varianteSeleccionada, dias: []),
    );
    
    _actualizarTabs(rutinaData.dias.length);

    return Scaffold(
      backgroundColor: AppTheme.charcoalBackground,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              expandedHeight: 250.0,
              pinned: true,
              backgroundColor: AppTheme.deepBlack,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(
                  'Full Body Adaptación',
                  style: GoogleFonts.outfit(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    shadows: [Shadow(color: Colors.black54, blurRadius: 4)],
                  ),
                ),
                background: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset(
                      'assets/images/beginner.png',
                      fit: BoxFit.cover,
                      alignment: Alignment.topCenter,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.transparent, AppTheme.deepBlack],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios, color: AppTheme.goldAccent),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      'Configura tu frecuencia semanal',
                      style: TextStyle(color: Colors.white70, fontSize: 16),
                    ),
                    const SizedBox(height: 16),
                    SegmentedButton<String>(
                      segments: const [
                        ButtonSegment(value: '3 Días', label: Text('3 DÍAS / SEMANA')),
                        ButtonSegment(value: '5 Días', label: Text('5 DÍAS / SEMANA')),
                      ],
                      selected: {_varianteSeleccionada},
                      onSelectionChanged: (Set<String> newSelection) {
                        setState(() {
                          _varianteSeleccionada = newSelection.first;
                        });
                      },
                      style: SegmentedButton.styleFrom(
                        backgroundColor: AppTheme.warmGrey,
                        selectedBackgroundColor: AppTheme.goldAccent,
                        selectedForegroundColor: Colors.black,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (rutinaData.dias.isNotEmpty)
              SliverPersistentHeader(
                pinned: true,
                delegate: _SliverAppBarDelegate(
                  TabBar(
                    controller: _tabController,
                    isScrollable: true,
                    labelColor: AppTheme.goldAccent,
                    unselectedLabelColor: Colors.white54,
                    indicatorColor: AppTheme.goldAccent,
                    tabs: rutinaData.dias.map((d) => Tab(text: d.nombreDia)).toList(),
                  ),
                ),
              ),
          ];
        },
        body: rutinaData.dias.isEmpty
            ? Center(child: Text("Rutina no disponible. Ingresa como Admin y siembra la base de datos.", style: TextStyle(color: Colors.white54), textAlign: TextAlign.center))
            : TabBarView(
                controller: _tabController,
                children: rutinaData.dias.map((dia) {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: ElevatedButton.icon(
                          onPressed: () {
                            // Cargar la rutina e ir al Dash!
                            context.read<WorkoutProvider>().iniciarSesion(dia, _varianteSeleccionada);
                            Navigator.popUntil(context, (route) => route.isFirst);
                          },
                          icon: Icon(Icons.play_arrow_rounded, size: 28),
                          label: Text('COMENZAR ESTE DÍA'),
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(double.infinity, 50),
                            backgroundColor: AppTheme.goldAccent,
                            foregroundColor: Colors.black,
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          itemCount: dia.ejercicios.length,
                          itemBuilder: (ctx, i) {
                            final ej = dia.ejercicios[i];
                            return _buildExerciseCard(ej);
                          },
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),
      ),
    );
  }

  Widget _buildExerciseCard(Ejercicio ej) {
    return Card(
      color: AppTheme.warmGrey,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            child: Container(
              color: Colors.white, // Fondo blanco para GIFs transparentes
              height: 180,
              child: Image.asset(
                ej.urlGif,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) => 
                    const Icon(Icons.fitness_center, size: 50, color: Colors.black26),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  ej.nombre,
                  style: GoogleFonts.outfit(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Chip(
                      label: Text(ej.tipo, style: TextStyle(fontSize: 12)),
                      backgroundColor: Colors.black38,
                      side: BorderSide(color: AppTheme.electricOrange),
                    ),
                    const SizedBox(width: 8),
                    Chip(
                      label: Text(ej.seriesReps, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                      backgroundColor: AppTheme.goldAccent.withOpacity(0.2),
                      side: BorderSide(color: AppTheme.goldAccent),
                    ),
                    const SizedBox(width: 8),
                    Chip(
                      avatar: Icon(Icons.timer, size: 14, color: Colors.white),
                      label: Text(ej.descanso, style: TextStyle(fontSize: 12)),
                      backgroundColor: Colors.black38,
                      side: BorderSide.none,
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: AppTheme.charcoalBackground,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
