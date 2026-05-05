import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/theme/app_theme.dart';
import '../../core/models/dieta_model.dart';
import '../../core/services/metrics_provider.dart';

class DietaMujerDefinicionPage extends StatefulWidget {
  const DietaMujerDefinicionPage({super.key});

  @override
  State<DietaMujerDefinicionPage> createState() =>
      _DietaMujerDefinicionPageState();
}

class _DietaMujerDefinicionPageState extends State<DietaMujerDefinicionPage> {
  int _dietaSeleccionada = 0;
  final TextEditingController _weightController = TextEditingController();

  @override
  void dispose() {
    _weightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final metrics = context.watch<MetricsProvider>();
    final dieta = dietasDefinicionMujer[_dietaSeleccionada];

    return Scaffold(
      backgroundColor: AppTheme.charcoalBackground,
      appBar: AppBar(
        title: Text(
          'Dietas de Definición',
          style: GoogleFonts.outfit(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        backgroundColor: AppTheme.deepBlack,
        iconTheme: const IconThemeData(color: Colors.greenAccent),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // --- MODULO PESO ---
            _buildWeightModule(metrics),
            SizedBox(height: 32),

            // --- SELECTOR DE DIETAS ---
            Text(
              'Variante de Dieta (1500 kcal)',
              style: GoogleFonts.outfit(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(dietasDefinicionMujer.length, (index) {
                  final d = dietasDefinicionMujer[index];
                  final isSelected = _dietaSeleccionada == index;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: ChoiceChip(
                      label: Text(d.titulo),
                      selected: isSelected,
                      onSelected: (selected) {
                        if (selected) {
                          setState(() => _dietaSeleccionada = index);
                        }
                      },
                      selectedColor: Colors.greenAccent.shade700,
                      backgroundColor: AppTheme.warmGrey,
                      labelStyle: TextStyle(
                        color: isSelected ? Theme.of(context).colorScheme.onSurface : Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                }),
              ),
            ),
            SizedBox(height: 24),

            // --- MACROS ---
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: _buildMacroStat(
                    'Proteína',
                    dieta.proteinas,
                    Colors.redAccent,
                  ),
                ),
                Expanded(
                  child: _buildMacroStat(
                    'Carbs',
                    dieta.carbohidratos,
                    Colors.orangeAccent,
                  ),
                ),
                Expanded(
                  child: _buildMacroStat(
                    'Grasas',
                    dieta.grasas,
                    Colors.yellowAccent,
                  ),
                ),
              ],
            ),
            SizedBox(height: 32),

            // --- CRONOGRAMA ACORDEON CON CHECKBOX ---
            Text(
              'Cronograma del Día',
              style: GoogleFonts.outfit(
                color: Theme.of(context).colorScheme.onSurface,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Card(
              color: AppTheme.warmGrey,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Column(
                  children: dieta.cronograma.map((comida) {
                    final isChecked = metrics.isMealChecked(
                      dieta.id,
                      comida.horario,
                    );
                    return ExpansionTile(
                      leading: Checkbox(
                        value: isChecked,
                        activeColor: Colors.greenAccent.shade700,
                        checkColor: Theme.of(context).colorScheme.onSurface,
                        onChanged: (val) =>
                            metrics.toggleMealCheck(dieta.id, comida.horario),
                      ),
                      title: Text(
                        '${comida.horario} - ${comida.titulo}',
                        style: TextStyle(
                          color: isChecked
                              ? Theme.of(context).colorScheme.onSurface.withOpacity(0.54)
                              : Colors.greenAccent,
                          fontWeight: FontWeight.bold,
                          decoration: isChecked
                              ? TextDecoration.lineThrough
                              : null,
                        ),
                      ),
                      iconColor: Colors.greenAccent,
                      collapsedIconColor: Theme.of(context).colorScheme.onSurface.withOpacity(0.54),
                      childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                      expandedAlignment: Alignment.centerLeft,
                      children: [
                        Text(
                          'Menú:',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          comida.menu,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onSurface,
                            fontSize: 15,
                          ),
                        ),
                        SizedBox(height: 12),
                        Text(
                          'Porción exacta:',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          comida.porciones,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onSurface,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ),
            SizedBox(height: 32),

            // --- LISTA DE COMPRA ---
            Text(
              'Lista del Supermercado (Estándar de 30 Días)',
              style: GoogleFonts.outfit(
                color: Theme.of(context).colorScheme.onSurface,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Card(
              color: AppTheme.warmGrey,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: dieta.listaCompraMensual.map((prod) {
                  return CheckboxListTile(
                    value: metrics.isProductChecked(prod.id),
                    activeColor: Colors.greenAccent.shade700,
                    checkColor: Theme.of(context).colorScheme.onSurface,
                    title: Text(
                      prod.nombre,
                      style: TextStyle(
                        color: metrics.isProductChecked(prod.id)
                            ? Theme.of(context).colorScheme.onSurface.withOpacity(0.54)
                            : Theme.of(context).colorScheme.onSurface,
                        decoration: metrics.isProductChecked(prod.id)
                            ? TextDecoration.lineThrough
                            : null,
                      ),
                    ),
                    subtitle: Text(
                      '${prod.categoria} • ${prod.cantidadMensual}',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface.withOpacity(0.54),
                        fontSize: 12,
                      ),
                    ),
                    onChanged: (val) => metrics.toggleProductCheck(prod.id),
                  );
                }).toList(),
              ),
            ),
            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildMacroStat(String label, String value, Color clr) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Column(
        children: [
          Text(
            value,
            style: GoogleFonts.outfit(
              color: clr,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            label,
            style: TextStyle(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7), fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _buildWeightModule(MetricsProvider metrics) {
    final curWeight = metrics.currentWeight;
    final lstWeight = metrics.lastWeight;

    String deltaTxt = '';
    Color deltaClr = Theme.of(context).colorScheme.onSurface.withOpacity(0.54);
    IconData deltaIco = Icons.horizontal_rule;

    if (curWeight != null && lstWeight != null) {
      final diff = curWeight - lstWeight;
      if (diff > 0) {
        deltaTxt = '+${diff.toStringAsFixed(1)} kg';
        deltaClr = Colors.redAccent;
        deltaIco = Icons.trending_up;
      } else if (diff < 0) {
        deltaTxt = '${diff.toStringAsFixed(1)} kg';
        deltaClr = Colors.greenAccent;
        deltaIco = Icons.trending_down;
      } else {
        deltaTxt = 'Mantenido';
        deltaClr = Colors.blueGrey;
      }
    }

    return Card(
      color: AppTheme.warmGrey,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Control de Peso',
              style: GoogleFonts.outfit(
                color: Theme.of(context).colorScheme.onSurface,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 16),
            LayoutBuilder(
              builder: (context, constraints) {
                final isCompact = constraints.maxWidth < 280;
                return isCompact
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          _buildWeightInput(metrics),
                          SizedBox(height: 16),
                          if (curWeight != null)
                            _buildWeightStats(
                              curWeight,
                              lstWeight,
                              deltaIco,
                              deltaClr,
                              deltaTxt,
                            ),
                        ],
                      )
                    : Row(
                        children: [
                          Expanded(child: _buildWeightInput(metrics)),
                          if (curWeight != null) ...[
                            SizedBox(width: 24),
                            _buildWeightStats(
                              curWeight,
                              lstWeight,
                              deltaIco,
                              deltaClr,
                              deltaTxt,
                            ),
                          ],
                        ],
                      );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWeightInput(MetricsProvider metrics) {
    return TextField(
      controller: _weightController,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
      decoration: InputDecoration(
        labelText: 'Peso de hoy (kg)',
        labelStyle: TextStyle(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.54)),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.24)),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.greenAccent.shade400),
          borderRadius: BorderRadius.circular(8),
        ),
        suffixIcon: IconButton(
          icon: Icon(Icons.save, color: Colors.greenAccent.shade400),
          onPressed: () {
            final p = double.tryParse(
              _weightController.text.replaceAll(',', '.'),
            );
            if (p != null) {
              metrics.saveDailyWeight(p);
              _weightController.clear();
              FocusScope.of(context).unfocus();
            }
          },
        ),
      ),
    );
  }

  Widget _buildWeightStats(
    double curWeight,
    double? lstWeight,
    IconData deltaIco,
    Color deltaClr,
    String deltaTxt,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          '${curWeight.toStringAsFixed(1)} kg',
          style: GoogleFonts.outfit(
            color: Theme.of(context).colorScheme.onSurface,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        if (curWeight != lstWeight)
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(deltaIco, color: deltaClr, size: 16),
              SizedBox(width: 4),
              Text(
                deltaTxt,
                style: TextStyle(color: deltaClr, fontWeight: FontWeight.bold),
              ),
            ],
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
