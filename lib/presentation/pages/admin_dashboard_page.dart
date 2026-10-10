import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/services/admin_provider.dart';
import '../../core/theme/app_theme.dart';
import '../../core/models/usuario_model.dart';
import '../../core/services/seed_rutinas_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminDashboardPage extends StatefulWidget {
  const AdminDashboardPage({super.key});

  @override
  State<AdminDashboardPage> createState() => _AdminDashboardPageState();
}

class _AdminDashboardPageState extends State<AdminDashboardPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AdminProvider>().fetchData();
    });
  }

  void _mostrarSelectorVigenciaDialog({
    required BuildContext context,
    UsuarioModel? socio,
    required String userId,
    required String nombre,
    String? paymentId,
  }) {
    final montoCtrl = TextEditingController();
    String selectedOption = '1mes'; // '1dia', '1semana', '1mes', 'calendario'
    DateTime? customCalendarDate;

    final now = DateTime.now();
    final socioExpiry = socio?.expiryDate;
    final bool tieneVigenciaFutura = socioExpiry != null && socioExpiry.isAfter(now);
    final DateTime baseDate = tieneVigenciaFutura ? socioExpiry : now;

    DateTime getFechaFinal(String option, DateTime? customDate) {
      switch (option) {
        case '1dia':
          return DateTime(baseDate.year, baseDate.month, baseDate.day + 1, 23, 59, 59);
        case '1semana':
          return DateTime(baseDate.year, baseDate.month, baseDate.day + 7, 23, 59, 59);
        case '1mes':
          return AdminProvider.calcularMismoDiaMesSiguiente(baseDate);
        case 'calendario':
          if (customDate != null) {
            return DateTime(customDate.year, customDate.month, customDate.day, 23, 59, 59);
          }
          return AdminProvider.calcularMismoDiaMesSiguiente(baseDate);
        default:
          return AdminProvider.calcularMismoDiaMesSiguiente(baseDate);
      }
    }

    String getPlanLabel(String option, DateTime fechaFinal) {
      switch (option) {
        case '1dia':
          return '1 Día (Pase diario)';
        case '1semana':
          return '1 Semana (Pase semanal)';
        case '1mes':
          return '1 Mes (Membresía mensual)';
        case 'calendario':
          final diff = fechaFinal.difference(now).inDays.clamp(1, 9999);
          return 'Personalizado ($diff días)';
        default:
          return '1 Mes';
      }
    }

    String formatFecha(DateTime d) {
      return '${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')}/${d.year}';
    }

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setDialogState) {
          final fechaFinal = getFechaFinal(selectedOption, customCalendarDate);

          Future<void> pickFecha() async {
            final initial = customCalendarDate ??
                (tieneVigenciaFutura
                    ? baseDate.add(const Duration(days: 30))
                    : now.add(const Duration(days: 30)));
            final picked = await showDatePicker(
              context: ctx,
              initialDate: initial.isBefore(now) ? now : initial,
              firstDate: now,
              lastDate: now.add(const Duration(days: 365 * 10)),
              helpText: 'SELECCIONÁ HASTA QUÉ DÍA TIENE PAGADO',
              cancelText: 'CANCELAR',
              confirmText: 'SELECCIONAR',
              builder: (pickerCtx, child) {
                return Theme(
                  data: Theme.of(pickerCtx).copyWith(
                    colorScheme: const ColorScheme.dark(
                      primary: AppTheme.goldAccent,
                      onPrimary: Colors.black,
                      surface: AppTheme.charcoalBackground,
                      onSurface: Colors.white,
                    ),
                    dialogBackgroundColor: AppTheme.warmGrey,
                  ),
                  child: child!,
                );
              },
            );

            if (picked != null) {
              setDialogState(() {
                customCalendarDate = DateTime(picked.year, picked.month, picked.day, 23, 59, 59);
                selectedOption = 'calendario';
              });
            }
          }

          return AlertDialog(
            backgroundColor: AppTheme.charcoalBackground,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            title: Text(
              paymentId != null ? 'Aprobar Pago y Asignar Días' : 'Cobrar / Renovar Cuota',
              style: GoogleFonts.outfit(color: AppTheme.goldAccent, fontWeight: FontWeight.bold),
            ),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Socio: $nombre',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurface,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  if (tieneVigenciaFutura) ...[
                    const SizedBox(height: 4),
                    Text(
                      'Vigencia actual hasta: ${formatFecha(baseDate)} (acumulativo)',
                      style: const TextStyle(color: Colors.greenAccent, fontSize: 11),
                    ),
                  ],
                  const SizedBox(height: 16),
                  Text(
                    'SELECCIONÁ LA VIGENCIA:',
                    style: GoogleFonts.inter(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.goldAccent,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Fila 1: 1 Día y 1 Semana
                  Row(
                    children: [
                      Expanded(
                        child: _buildOptionCard(
                          title: '1 DÍA',
                          subtitle: 'Pase diario',
                          icon: Icons.bolt,
                          isSelected: selectedOption == '1dia',
                          onTap: () => setDialogState(() => selectedOption = '1dia'),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: _buildOptionCard(
                          title: '1 SEMANA',
                          subtitle: 'Pase semanal',
                          icon: Icons.view_week_rounded,
                          isSelected: selectedOption == '1semana',
                          onTap: () => setDialogState(() => selectedOption = '1semana'),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // Fila 2: 1 Mes y Calendario
                  Row(
                    children: [
                      Expanded(
                        child: _buildOptionCard(
                          title: '1 MES',
                          subtitle: 'Membresía mensual',
                          badgeText: 'Mismo día prox. mes',
                          icon: Icons.calendar_month,
                          isSelected: selectedOption == '1mes',
                          onTap: () => setDialogState(() => selectedOption = '1mes'),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: _buildOptionCard(
                          title: 'CALENDARIO',
                          subtitle: customCalendarDate != null
                              ? formatFecha(customCalendarDate!)
                              : 'Fecha exacta',
                          badgeText: customCalendarDate != null ? 'Toca para cambiar' : 'Elegir fecha',
                          badgeColor: customCalendarDate != null ? Colors.greenAccent : AppTheme.goldAccent,
                          icon: Icons.edit_calendar,
                          isSelected: selectedOption == 'calendario',
                          onTap: pickFecha,
                        ),
                      ),
                    ],
                  ),

                  if (selectedOption == 'calendario') ...[
                    const SizedBox(height: 8),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppTheme.goldAccent,
                          side: const BorderSide(color: AppTheme.goldAccent),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          padding: const EdgeInsets.symmetric(vertical: 8),
                        ),
                        icon: const Icon(Icons.date_range, size: 16),
                        label: Text(
                          customCalendarDate == null
                              ? 'ELEGIR FECHA EN CALENDARIO'
                              : 'CAMBIAR FECHA: ${formatFecha(customCalendarDate!)}',
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
                        ),
                        onPressed: pickFecha,
                      ),
                    ),
                  ],

                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppTheme.warmGrey,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: AppTheme.goldAccent.withOpacity(0.35)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.event_available, color: Colors.greenAccent, size: 20),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                'Vencerá el: ${formatFecha(fechaFinal)}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          tieneVigenciaFutura
                              ? 'Extiende sobre la fecha actual (${formatFecha(baseDate)})'
                              : 'Contado a partir de hoy (${formatFecha(now)})',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.7),
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),
                  TextField(
                    controller: montoCtrl,
                    keyboardType: TextInputType.number,
                    style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
                    decoration: InputDecoration(
                      labelText: 'Monto cobrado (\$) [Opcional]',
                      labelStyle: TextStyle(color: AppTheme.goldAccent.withOpacity(0.8)),
                      prefixIcon: const Icon(Icons.attach_money, color: AppTheme.goldAccent),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: AppTheme.goldAccent),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx),
                child: Text(
                  'Cancelar',
                  style: TextStyle(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6)),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: paymentId != null ? Colors.green : AppTheme.goldAccent,
                  foregroundColor: paymentId != null ? Colors.white : Colors.black,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                ),
                onPressed: () async {
                  final monto = double.tryParse(montoCtrl.text.trim()) ?? 0.0;
                  final planName = getPlanLabel(selectedOption, fechaFinal);
                  Navigator.pop(ctx);

                  final admin = context.read<AdminProvider>();

                  if (paymentId != null) {
                    final success = await admin.approvePayment(
                      paymentId: paymentId,
                      userId: userId,
                      fechaVencimiento: fechaFinal,
                      plan: planName,
                      monto: monto,
                    );
                    if (success && mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Pago de $nombre aprobado por $planName'),
                          backgroundColor: Colors.green.shade700,
                        ),
                      );
                    }
                  } else {
                    final success = await admin.cobrarSocio(
                      idSocio: userId,
                      fechaVencimiento: fechaFinal,
                      plan: planName,
                      monto: monto,
                    );
                    if (success && mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Membresía de $nombre activada por $planName'),
                          backgroundColor: Colors.green.shade700,
                        ),
                      );
                    }
                  }
                },
                child: Text(
                  paymentId != null ? 'SÍ, APROBAR PAGO' : 'CONFIRMAR Y ACTIVAR',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildOptionCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
    String? badgeText,
    Color? badgeColor,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? AppTheme.goldAccent.withOpacity(0.18) : AppTheme.warmGrey,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? AppTheme.goldAccent : Colors.white24,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  icon,
                  color: isSelected ? AppTheme.goldAccent : Colors.white70,
                  size: 22,
                ),
                const Spacer(),
                if (isSelected)
                  const Icon(
                    Icons.check_circle,
                    color: AppTheme.goldAccent,
                    size: 18,
                  ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: GoogleFonts.outfit(
                color: isSelected ? AppTheme.goldAccent : Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              subtitle,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.white70,
                fontSize: 11,
                fontWeight: isSelected ? FontWeight.w500 : FontWeight.normal,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            if (badgeText != null) ...[
              const SizedBox(height: 6),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: (badgeColor ?? AppTheme.goldAccent).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  badgeText,
                  style: TextStyle(
                    color: badgeColor ?? AppTheme.goldAccent,
                    fontSize: 9,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final admin = context.watch<AdminProvider>();

    return Scaffold(
      backgroundColor: AppTheme.charcoalBackground,
      appBar: AppBar(
        title: const Text('PANEL DE CONTROL'),
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            icon: const Icon(Icons.cloud_upload, color: Colors.blueAccent),
            tooltip: 'Sembrar Rutinas',
            onPressed: () => SeedRutinasService.inyectarDatos(context),
          ),
        ],
      ),
      body: admin.loading
          ? const Center(child: CircularProgressIndicator(color: AppTheme.goldAccent))
          : admin.errorMessage != null
              ? Center(child: Text(admin.errorMessage!, style: const TextStyle(color: Colors.redAccent)))
              : CustomScrollView(
                  slivers: [
                    // Sección Pagos Pendientes
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          'PAGOS PENDIENTES POR VERIFICAR',
                          style: GoogleFonts.outfit(
                            color: AppTheme.goldAccent,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.5,
                          ),
                        ),
                      ),
                    ),
                    _buildPendingPayments(admin),

                    // Sección Gestión de Socios
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
                        child: Text(
                          'GESTIÓN DE SOCIOS',
                          style: GoogleFonts.outfit(
                            color: AppTheme.goldAccent,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.5,
                          ),
                        ),
                      ),
                    ),
                    _buildSociosList(admin),
                  ],
                ),
    );
  }

  Widget _buildPendingPayments(AdminProvider admin) {
    return StreamBuilder<QuerySnapshot>(
      stream: admin.getPendingPaymentsStream(),
      builder: (context, snapshot) {
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'No hay pagos pendientes.',
                style: TextStyle(color: Colors.grey, fontStyle: FontStyle.italic),
              ),
            ),
          );
        }

        return SliverList(
          delegate: SliverChildListDelegate(
            snapshot.data!.docs.map((doc) {
              final data = doc.data() as Map<String, dynamic>;
              final paymentId = doc.id;
              final userId = data['userId'] ?? '';
              final nombre = data['nombre'] ?? 'Sin nombre';
              final dynamic rawFecha = data['fecha'];
              final fecha = (rawFecha is Timestamp) ? rawFecha.toDate() : DateTime.now();

              UsuarioModel? socio;
              try {
                socio = admin.socios.firstWhere((s) => s.uid == userId);
              } catch (_) {
                socio = null;
              }

              return Card(
                color: Colors.amber.withOpacity(0.06),
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.amber.withOpacity(0.35)),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  title: Row(
                    children: [
                      Expanded(
                        child: Text(
                          nombre,
                          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.amber.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(color: Colors.amber),
                        ),
                        child: const Text(
                          'TRANSFERENCIA',
                          style: TextStyle(
                            color: Colors.amber,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  subtitle: Text(
                    'Enviado: ${fecha.day}/${fecha.month} - ${fecha.hour.toString().padLeft(2, '0')}:${fecha.minute.toString().padLeft(2, '0')}',
                    style: const TextStyle(color: Colors.white70, fontSize: 12),
                  ),
                  trailing: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    ),
                    icon: const Icon(Icons.check_circle_outline, size: 16),
                    label: const Text('APROBAR', style: TextStyle(fontWeight: FontWeight.bold)),
                    onPressed: () => _mostrarSelectorVigenciaDialog(
                      context: context,
                      socio: socio,
                      userId: userId,
                      nombre: nombre,
                      paymentId: paymentId,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }

  Widget _buildSociosList(AdminProvider admin) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (ctx, i) {
          final socio = admin.socios[i];
          final estado = admin.getEstadoSocio(socio);
          final color = admin.getColorEstado(estado);

          String vencimientoTexto;
          if (socio.expiryDate != null) {
            final exp = socio.expiryDate!;
            final diff = exp.difference(DateTime.now()).inDays;
            final formattedDate =
                '${exp.day.toString().padLeft(2, '0')}/${exp.month.toString().padLeft(2, '0')}/${exp.year}';
            if (diff >= 0) {
              vencimientoTexto = 'Vence: $formattedDate (quedan $diff días)';
            } else {
              vencimientoTexto = 'Venció: $formattedDate (hace ${diff.abs()} días)';
            }
          } else {
            vencimientoTexto = socio.subscriptionStatus == 'activo'
                ? 'Activo (sin fecha fija)'
                : 'Sin suscripción activa';
          }

          return Card(
            color: AppTheme.warmGrey,
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            shape: RoundedRectangleBorder(
              side: BorderSide(color: color.withOpacity(0.5), width: 1.5),
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              title: Text(
                socio.nombre,
                style: GoogleFonts.outfit(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onSurface,
                  fontSize: 17,
                ),
              ),
              subtitle: Text(
                vencimientoTexto,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                  fontSize: 12,
                ),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: color.withOpacity(0.5)),
                    ),
                    child: Text(
                      estado,
                      style: GoogleFonts.inter(color: color, fontWeight: FontWeight.bold, fontSize: 11),
                    ),
                  ),
                  if (!socio.isAdmin) ...[
                    const SizedBox(width: 8),
                    IconButton(
                      icon: const Icon(Icons.add_card, color: AppTheme.goldAccent, size: 22),
                      tooltip: 'Cobrar / Renovar',
                      onPressed: () => _mostrarSelectorVigenciaDialog(
                        context: context,
                        socio: socio,
                        userId: socio.uid,
                        nombre: socio.nombre,
                      ),
                    ),
                  ],
                ],
              ),
              onTap: socio.isAdmin
                  ? null
                  : () => _mostrarSelectorVigenciaDialog(
                        context: context,
                        socio: socio,
                        userId: socio.uid,
                        nombre: socio.nombre,
                      ),
            ),
          );
        },
        childCount: admin.socios.length,
      ),
    );
  }
}
