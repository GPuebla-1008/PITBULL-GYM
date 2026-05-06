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

  void _registrarPago(BuildContext context, UsuarioModel socio) {
    final montoCtrl = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppTheme.charcoalBackground,
        title: Text(
          'Registrar Pago',
          style: GoogleFonts.outfit(color: AppTheme.goldAccent),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Socio: ${socio.nombre}',
              style: TextStyle(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7)),
            ),
            SizedBox(height: 16),
            TextField(
              controller: montoCtrl,
              keyboardType: TextInputType.number,
              style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
              decoration: InputDecoration(
                labelText: 'Monto a pagar',
                labelStyle: TextStyle(color: AppTheme.goldAccent),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: AppTheme.goldAccent),
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(
              'Cancelar',
              style: TextStyle(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.54)),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.goldAccent,
            ),
            onPressed: () async {
              final montoStr = montoCtrl.text.trim();
              if (montoStr.isEmpty) return;
              final monto = double.tryParse(montoStr) ?? 0;

              Navigator.pop(ctx); // Cerrar modal

              final admin = context.read<AdminProvider>();
              final success = await admin.registrarPagoMesActual(
                socio.uid,
                monto,
              );

              if (success && mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Pago registrado correctamente'),
                    backgroundColor: Colors.green.shade700,
                  ),
                );
              }
            },
            child: Text(
              'CONFIRMAR',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
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
              final fecha = (data['fecha'] as Timestamp?)?.toDate() ?? DateTime.now();

              return Card(
                color: Colors.amber.withOpacity(0.05),
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.amber.withOpacity(0.3)),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  title: Text(
                    nombre,
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    'Enviado: ${fecha.day}/${fecha.month} - ${fecha.hour}:${fecha.minute.toString().padLeft(2, '0')}',
                    style: const TextStyle(color: Colors.white70, fontSize: 12),
                  ),
                  trailing: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                    ),
                    onPressed: () => _showApproveDialog(paymentId, userId, nombre),
                    child: const Text('APROBAR'),
                  ),
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }

  void _showApproveDialog(String paymentId, String userId, String nombre) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppTheme.charcoalBackground,
        title: const Text('Confirmar Aprobación'),
        content: Text('¿Deseas aprobar el pago de $nombre y extender su suscripción 30 días?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('CANCELAR'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            onPressed: () async {
              Navigator.pop(ctx);
              final admin = context.read<AdminProvider>();
              final success = await admin.approvePayment(paymentId, userId);
              if (success && mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Pago aprobado y suscripción extendida')),
                );
              }
            },
            child: const Text('SÍ, APROBAR'),
          ),
        ],
      ),
    );
  }

  Widget _buildSociosList(AdminProvider admin) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (ctx, i) {
          final socio = admin.socios[i];
          final estado = admin.getEstadoSocio(socio);
          final color = admin.getColorEstado(estado);

          return Card(
            color: AppTheme.warmGrey,
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            shape: RoundedRectangleBorder(
              side: BorderSide(color: color.withOpacity(0.5), width: 2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              title: Text(
                socio.nombre,
                style: GoogleFonts.outfit(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onSurface,
                  fontSize: 18,
                ),
              ),
              subtitle: Text(
                'Día de pago: ${socio.diaPagoFijo}  •  Status: ${socio.subscriptionStatus}',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                  fontSize: 12,
                ),
              ),
              trailing: Container(
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
              onTap: () {
                if (estado != 'AL DÍA') {
                  _registrarPago(context, socio);
                }
              },
            ),
          );
        },
        childCount: admin.socios.length,
      ),
    );
  }
}
