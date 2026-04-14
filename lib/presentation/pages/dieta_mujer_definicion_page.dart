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
            color: Colors.white,
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
            // --- MODULO AGUA (AZULADO) ---
            _buildWaterModule(metrics),
            const SizedBox(height: 16),

            // --- MODULO PESO ---
            _buildWeightModule(metrics),
            const SizedBox(height: 32),

            // --- SELECTOR DE DIETAS ---
            Text(
              'Variante de Dieta (1500 kcal)',
              style: GoogleFonts.outfit(
                color: Colors.white70,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
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
                        if (selected)
                          setState(() => _dietaSeleccionada = index);
                      },
                      selectedColor: Colors.greenAccent.shade700,
                      backgroundColor: AppTheme.warmGrey,
                      labelStyle: TextStyle(
                        color: isSelected ? Colors.white : Colors.white70,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                }),
              ),
            ),
            const SizedBox(height: 24),

            // --- MACROS ---
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildMacroStat('Proteína', dieta.proteinas, Colors.redAccent),
                _buildMacroStat(
                  'Carbs',
                  dieta.carbohidratos,
                  Colors.orangeAccent,
                ),
                _buildMacroStat('Grasas', dieta.grasas, Colors.yellowAccent),
              ],
            ),
            const SizedBox(height: 32),

            // --- CRONOGRAMA ACORDEON CON CHECKBOX ---
            Text(
              'Cronograma del Día',
              style: GoogleFonts.outfit(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
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
                        checkColor: Colors.white,
                        onChanged: (val) =>
                            metrics.toggleMealCheck(dieta.id, comida.horario),
                      ),
                      title: Text(
                        '${comida.horario} - ${comida.titulo}',
                        style: TextStyle(
                          color: isChecked
                              ? Colors.white54
                              : Colors.greenAccent,
                          fontWeight: FontWeight.bold,
                          decoration: isChecked
                              ? TextDecoration.lineThrough
                              : null,
                        ),
                      ),
                      iconColor: Colors.greenAccent,
                      collapsedIconColor: Colors.white54,
                      childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                      expandedAlignment: Alignment.centerLeft,
                      children: [
                        Text(
                          'Menú:',
                          style: TextStyle(
                            color: Colors.white70,
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          comida.menu,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Porción exacta:',
                          style: TextStyle(
                            color: Colors.white70,
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          comida.porciones,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ),
            const SizedBox(height: 32),

            // --- LISTA DE COMPRA ---
            Text(
              'Lista del Supermercado (Estándar de 30 Días)',
              style: GoogleFonts.outfit(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
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
                    checkColor: Colors.white,
                    title: Text(
                      prod.nombre,
                      style: TextStyle(
                        color: metrics.isProductChecked(prod.id)
                            ? Colors.white54
                            : Colors.white,
                        decoration: metrics.isProductChecked(prod.id)
                            ? TextDecoration.lineThrough
                            : null,
                      ),
                    ),
                    subtitle: Text(
                      '${prod.categoria} • ${prod.cantidadMensual}',
                      style: const TextStyle(
                        color: Colors.white54,
                        fontSize: 12,
                      ),
                    ),
                    onChanged: (val) => metrics.toggleProductCheck(prod.id),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildMacroStat(String label, String value, Color clr) {
    return Column(
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
          style: const TextStyle(color: Colors.white70, fontSize: 12),
        ),
      ],
    );
  }

  Widget _buildWaterModule(MetricsProvider metrics) {
    const meta = 10; // 10 vasos
    final objAlcanzado = metrics.waterGlasses >= meta;

    return Card(
      color: Colors.blue.shade900.withOpacity(0.3),
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.blueAccent.withOpacity(0.5)),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 80,
                  height: 80,
                  child: CircularProgressIndicator(
                    value: metrics.waterGlasses / meta,
                    strokeWidth: 8,
                    backgroundColor: Colors.blue.shade900,
                    color: Colors.lightBlueAccent,
                  ),
                ),
                Icon(
                  objAlcanzado ? Icons.verified : Icons.water_drop,
                  color: Colors.lightBlueAccent,
                  size: 30,
                ),
              ],
            ),
            const SizedBox(width: 24),
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
                    '${metrics.waterGlasses} de $meta vasos',
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      _roundedBtn(
                        Icons.remove,
                        () => metrics.removeWaterGlass(),
                        Colors.blueGrey,
                      ),
                      const SizedBox(width: 16),
                      _roundedBtn(
                        Icons.add,
                        () => metrics.addWaterGlass(),
                        Colors.lightBlueAccent,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWeightModule(MetricsProvider metrics) {
    final curWeight = metrics.currentWeight;
    final lstWeight = metrics.lastWeight;

    String deltaTxt = '';
    Color deltaClr = Colors.white54;
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
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _weightController,
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: 'Peso de hoy (kg)',
                      labelStyle: const TextStyle(color: Colors.white54),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white24),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.greenAccent.shade400,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          Icons.save,
                          color: Colors.greenAccent.shade400,
                        ),
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
                  ),
                ),
                if (curWeight != null) ...[
                  const SizedBox(width: 24),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '${curWeight.toStringAsFixed(1)} kg',
                        style: GoogleFonts.outfit(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (curWeight != lstWeight)
                        Row(
                          children: [
                            Icon(deltaIco, color: deltaClr, size: 16),
                            const SizedBox(width: 4),
                            Text(
                              deltaTxt,
                              style: TextStyle(
                                color: deltaClr,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
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
