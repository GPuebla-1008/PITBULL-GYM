import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/theme/app_theme.dart';
import '../../core/services/workout_provider.dart';
import '../../core/models/rutina_adaptacion_model.dart';

class RutinaPrincipiantePage extends StatefulWidget {
  const RutinaPrincipiantePage({super.key});

  @override
  State<RutinaPrincipiantePage> createState() => _RutinaPrincipiantePageState();
}

class _RutinaPrincipiantePageState extends State<RutinaPrincipiantePage> with TickerProviderStateMixin {
  final String _varianteSeleccionada = 'Principiante 3 Días';
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
    final screenW = MediaQuery.of(context).size.width;
    final screenH = MediaQuery.of(context).size.height;
    final isSmall = screenW < 380;

    if (workout.loading) {
      return Scaffold(
        backgroundColor: AppTheme.charcoalBackground,
        body: const Center(child: CircularProgressIndicator(color: AppTheme.goldAccent)),
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
              expandedHeight: (screenH * 0.28).clamp(160.0, 280.0),
              pinned: true,
              backgroundColor: AppTheme.deepBlack,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(
                  'Rutina Principiante',
                  style: GoogleFonts.outfit(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: isSmall ? 14 : 18,
                    shadows: [const Shadow(color: Colors.black54, blurRadius: 4)],
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
                padding: EdgeInsets.symmetric(
                  horizontal: isSmall ? 12 : 16,
                  vertical: isSmall ? 12 : 16,
                ),
                child: SizedBox(height: 16), // Space instead of SegmentedButton
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
                    labelStyle: TextStyle(fontSize: isSmall ? 12 : 14),
                    tabs: rutinaData.dias.map((d) => Tab(text: d.nombreDia)).toList(),
                  ),
                ),
              ),
          ];
        },
        body: rutinaData.dias.isEmpty
            ? Center(child: Text("Rutina no disponible. Ingresa como Admin y siembra la base de datos.", style: TextStyle(color: Colors.white54), textAlign: TextAlign.center))
            : TabBarView(
                key: ValueKey(rutinaData.dias.length),
                controller: _tabController,
                children: rutinaData.dias.map((dia) {
                  return Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(isSmall ? 10 : 16),
                        child: ElevatedButton.icon(
                          onPressed: () {
                            context.read<WorkoutProvider>().iniciarSesion(dia, _varianteSeleccionada);
                            Navigator.popUntil(context, (route) => route.isFirst);
                          },
                          icon: const Icon(Icons.play_arrow_rounded, size: 28),
                          label: Text('COMENZAR ESTE DÍA', style: TextStyle(fontSize: isSmall ? 13 : 15)),
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(double.infinity, 50),
                            backgroundColor: AppTheme.goldAccent,
                            foregroundColor: Colors.black,
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          padding: EdgeInsets.symmetric(horizontal: isSmall ? 10 : 16),
                          itemCount: dia.ejercicios.length,
                          itemBuilder: (ctx, i) {
                            final ej = dia.ejercicios[i];
                            return _buildExerciseCard(ej, screenW, screenH);
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

  Widget _buildExerciseCard(Ejercicio ej, double screenW, double screenH) {
    final isSmall = screenW < 380;
    final imgH = (screenH * 0.20).clamp(120.0, 200.0);

    return Card(
      color: AppTheme.warmGrey,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: EdgeInsets.only(bottom: isSmall ? 12 : 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: Container(
              color: Colors.white, // Fondo blanco para GIFs transparentes
              height: imgH,
              child: Image.asset(
                ej.urlGif,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) => 
                    const Icon(Icons.fitness_center, size: 50, color: Colors.black26),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(isSmall ? 12 : 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  ej.nombre,
                  style: GoogleFonts.outfit(fontSize: isSmall ? 16 : 20, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 6.0,
                  runSpacing: 6.0,
                  children: [
                    Chip(
                      label: Text(ej.tipo, style: const TextStyle(fontSize: 11)),
                      backgroundColor: Colors.black38,
                      side: BorderSide(color: AppTheme.electricOrange),
                      visualDensity: VisualDensity.compact,
                    ),
                    Chip(
                      label: Text(ej.seriesReps, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                      backgroundColor: AppTheme.goldAccent.withOpacity(0.2),
                      side: BorderSide(color: AppTheme.goldAccent),
                      visualDensity: VisualDensity.compact,
                    ),
                    Chip(
                      avatar: const Icon(Icons.timer, size: 14, color: Colors.white),
                      label: Text(ej.descanso, style: const TextStyle(fontSize: 11)),
                      backgroundColor: Colors.black38,
                      side: BorderSide.none,
                      visualDensity: VisualDensity.compact,
                    ),
                  ],
                ),
                if (ej.instruccion.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  Text(
                    ej.instruccion,
                    style: TextStyle(color: Colors.white70, fontSize: 13, fontStyle: FontStyle.italic),
                  ),
                ],
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
    return _tabBar != oldDelegate._tabBar || _tabBar.controller != oldDelegate._tabBar.controller;
  }
}
