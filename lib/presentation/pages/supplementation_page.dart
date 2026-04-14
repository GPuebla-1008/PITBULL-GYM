import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/theme/app_theme.dart';
import '../../core/models/supplement_model.dart';
import '../../core/services/supplement_service.dart';

class SupplementationPage extends StatefulWidget {
  const SupplementationPage({super.key});

  @override
  State<SupplementationPage> createState() => _SupplementationPageState();
}

class _SupplementationPageState extends State<SupplementationPage> {
  final SupplementService _service = SupplementService();
  String _goal = 'bulk'; // 'bulk' o 'cut'
  String _gender = 'male'; // 'male' o 'female'
  TimeOfDay _trainingTime = const TimeOfDay(hour: 18, minute: 0);
  List<SupplementItem> _supplements = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadInitialData();
  }

  Future<void> _loadInitialData() async {
    setState(() => _isLoading = true);
    final savedPlan = await _service.getPlan();
    if (savedPlan != null) {
      _goal = savedPlan.goal;
      _gender = savedPlan.userGender;
    }
    _updateSupplements();
    setState(() => _isLoading = false);
  }

  void _updateSupplements() {
    _supplements = _service.getRecommendedSupplements(_goal, _gender);
  }

  Future<void> _saveCurrentPlan() async {
    final plan = SupplementPlan(
      id: '', // Service handles UID
      goal: _goal,
      userGender: _gender,
      supplements: _supplements,
      updatedAt: DateTime.now(),
    );
    await _service.savePlan(plan);
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Plan guardado exitosamente'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        backgroundColor: AppTheme.charcoalBackground,
        body: Center(
          child: CircularProgressIndicator(color: AppTheme.goldAccent),
        ),
      );
    }

    return Scaffold(
      backgroundColor: AppTheme.charcoalBackground,
      appBar: AppBar(
        title: Text(
          'Suplementación Inteligente',
          style: GoogleFonts.outfit(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: AppTheme.deepBlack,
        iconTheme: const IconThemeData(color: AppTheme.goldAccent),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _saveCurrentPlan,
            tooltip: 'Guardar cambios',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Disclaimer
            _buildDisclaimer(),
            const SizedBox(height: 16),

            Center(
              child: Hero(
                tag: 'hero-suplementos',
                child: Image.asset(
                  'assets/images/tenor.gif',
                  height: 120,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Selectores
            _buildSelectors(),
            const SizedBox(height: 24),

            // Time Picker
            _buildTimePicker(),
            const SizedBox(height: 32),

            // Timeline Header
            Text(
              'Cronograma Diario Recomendado',
              style: GoogleFonts.outfit(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            // Timeline List
            ..._supplements.map((supp) => _buildTimelineItem(supp)),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildDisclaimer() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.amber.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.amber.withOpacity(0.5)),
      ),
      child: Row(
        children: [
          const Icon(Icons.warning_amber_rounded, color: Colors.amber),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'DESCARGO DE RESPONSABILIDAD: Las siguientes pautas son informativas. Consulte con un médico o nutricionista antes de iniciar cualquier suplementación.',
              style: GoogleFonts.inter(
                color: Colors.amber,
                fontSize: 11,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSelectors() {
    return Column(
      children: [
        // Sex Selector
        Row(
          children: [
            Expanded(
              child: _selectorButton(
                label: 'Hombre',
                isSelected: _gender == 'male',
                icon: Icons.male,
                onTap: () => setState(() {
                  _gender = 'male';
                  _updateSupplements();
                }),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _selectorButton(
                label: 'Mujer',
                isSelected: _gender == 'female',
                icon: Icons.female,
                onTap: () => setState(() {
                  _gender = 'female';
                  _updateSupplements();
                }),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        // Goal Toggle
        Container(
          height: 50,
          decoration: BoxDecoration(
            color: AppTheme.warmGrey,
            borderRadius: BorderRadius.circular(25),
          ),
          child: Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => setState(() {
                    _goal = 'cut';
                    _updateSupplements();
                  }),
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: _goal == 'cut'
                          ? Colors.greenAccent.shade700
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Text(
                      'Definición',
                      style: TextStyle(
                        color: _goal == 'cut' ? Colors.white : Colors.white60,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () => setState(() {
                    _goal = 'bulk';
                    _updateSupplements();
                  }),
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: _goal == 'bulk'
                          ? Colors.deepOrangeAccent.shade700
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Text(
                      'Ganancia Muscular',
                      style: TextStyle(
                        color: _goal == 'bulk' ? Colors.white : Colors.white60,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _selectorButton({
    required String label,
    required bool isSelected,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected
              ? AppTheme.goldAccent.withOpacity(0.2)
              : AppTheme.warmGrey,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? AppTheme.goldAccent : Colors.transparent,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isSelected ? AppTheme.goldAccent : Colors.white60,
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.white60,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimePicker() {
    return Card(
      color: AppTheme.warmGrey,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        leading: const Icon(Icons.access_time, color: AppTheme.goldAccent),
        title: const Text(
          'Hora de Entrenamiento',
          style: TextStyle(color: Colors.white70, fontSize: 13),
        ),
        subtitle: Text(
          _trainingTime.format(context),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        trailing: TextButton(
          onPressed: () async {
            final picked = await showTimePicker(
              context: context,
              initialTime: _trainingTime,
            );
            if (picked != null) setState(() => _trainingTime = picked);
          },
          child: const Text(
            'CAMBIAR',
            style: TextStyle(color: AppTheme.goldAccent),
          ),
        ),
      ),
    );
  }

  Widget _buildTimelineItem(SupplementItem supp) {
    final absTime = _service.calculateAbsoluteTiming(
      _trainingTime,
      supp.relativeTiming,
    );

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Left - Time
        SizedBox(
          width: MediaQuery.of(context).size.width < 340 ? 65 : 80,
          child: Column(
            children: [
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  absTime,
                  style: GoogleFonts.outfit(
                    color: AppTheme.goldAccent,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 4),
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  supp.relativeTiming,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white24, fontSize: 10),
                ),
              ),
            ],
          ),
        ),
        // Middle - Connector
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: const BoxDecoration(
                  color: AppTheme.goldAccent,
                  shape: BoxShape.circle,
                ),
              ),
              Container(width: 2, height: 100, color: Colors.white10),
            ],
          ),
        ),
        // Right - Content
        Expanded(
          child: Card(
            color: AppTheme.warmGrey,
            margin: const EdgeInsets.only(bottom: 24),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        supp.name,
                        style: GoogleFonts.outfit(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white10,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          supp.dosage,
                          style: const TextStyle(
                            color: AppTheme.goldAccent,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    supp.description,
                    style: const TextStyle(color: Colors.white60, fontSize: 13),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
