import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/theme/app_theme.dart';
import '../../core/services/workout_provider.dart';
import '../../core/models/rutina_adaptacion_model.dart';

class RutinaAvanzadaPage extends StatefulWidget {
  const RutinaAvanzadaPage({super.key});

  @override
  State<RutinaAvanzadaPage> createState() => _RutinaAvanzadaPageState();
}

class _RutinaAvanzadaPageState extends State<RutinaAvanzadaPage> with TickerProviderStateMixin {
  final String _varianteSeleccionada = '6 Días - Arnold'; // Only one variant for now
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

    // Filter to find the Arnold Split ID
    final rutinasAvanzadas = workout.todasLasRutinas.where((r) => r.id == 'arnold_split_advanced').toList();

    final rutinaData = rutinasAvanzadas.isNotEmpty 
      ? rutinasAvanzadas.first 
      : RutinaAdaptacion(id: '', variante: _varianteSeleccionada, dias: []);
    
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
                  'Arnold Split (6 Días)',
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
                      'assets/images/advanced.png',
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
            ? const Center(child: Text("Rutina Arnold no disponible. Ingresa como Admin e inyecta la base de datos.", style: TextStyle(color: Colors.white54), textAlign: TextAlign.center))
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
                          icon: const Icon(Icons.flash_on, size: 28),
                          label: Text('INICIAR SESIÓN HIPERTROFIA', style: TextStyle(fontSize: isSmall ? 13 : 15, fontWeight: FontWeight.bold)),
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(double.infinity, 50),
                            backgroundColor: AppTheme.electricOrange,
                            foregroundColor: Colors.white,
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

    String seriesRepsText = ej.seriesReps;
    if ((ej.series != null) && (ej.repeticiones != null)) {
      seriesRepsText = '${ej.series} x ${ej.repeticiones}';
    }

    return Card(
      color: AppTheme.warmGrey,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: ej.isSuperset ? const BorderSide(color: Colors.redAccent, width: 2) : BorderSide.none,
      ),
      margin: EdgeInsets.only(bottom: isSmall ? 12 : 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(14)),
                child: Container(
                  color: Colors.white,
                  height: imgH,
                  width: double.infinity,
                  child: Image.asset(
                    ej.urlGif,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) => 
                        const Icon(Icons.fitness_center, size: 50, color: Colors.black26),
                  ),
                ),
              ),
              if (ej.isSuperset)
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      '🔄 SUPERSERIE G${ej.supersetGroupId ?? 1}',
                      style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
            ],
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
                    if (ej.intensityTechnique != null)
                      Chip(
                        avatar: const Icon(Icons.local_fire_department, color: Colors.yellowAccent, size: 16),
                        label: Text('${ej.intensityTechnique}', style: const TextStyle(fontSize: 11, color: Colors.white, fontWeight: FontWeight.bold)),
                        backgroundColor: Colors.red.shade900,
                        side: const BorderSide(color: Colors.redAccent),
                        visualDensity: VisualDensity.compact,
                      ),
                    if (ej.musculoObjetivo != null)
                      Chip(
                        label: Text(ej.musculoObjetivo!, style: const TextStyle(fontSize: 11, color: Colors.white)),
                        backgroundColor: AppTheme.deepBlack,
                        side: const BorderSide(color: Colors.white24),
                        visualDensity: VisualDensity.compact,
                      ),
                    Chip(
                      label: Text(ej.tipoDeEquipo ?? ej.tipo, style: const TextStyle(fontSize: 11)),
                      backgroundColor: Colors.black38,
                      side: BorderSide(color: AppTheme.electricOrange),
                      visualDensity: VisualDensity.compact,
                    ),
                    Chip(
                      label: Text(seriesRepsText, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                      backgroundColor: AppTheme.goldAccent.withOpacity(0.2),
                      side: BorderSide(color: AppTheme.goldAccent),
                      visualDensity: VisualDensity.compact,
                    ),
                    if (!ej.isSuperset || ej.descanso != '0 seg')
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
