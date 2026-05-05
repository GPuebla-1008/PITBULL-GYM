import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/services/admin_provider.dart';
import '../../core/theme/app_theme.dart';
import '../../core/models/usuario_model.dart';
import '../../core/services/seed_rutinas_service.dart';

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
        title: Text('PANEL DE CONTROL'),
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            icon: Icon(Icons.cloud_upload, color: Colors.blueAccent),
            tooltip: 'Sembrar Rutinas',
            onPressed: () => SeedRutinasService.inyectarDatos(context),
          ),
        ],
      ),
      body: admin.loading
          ? Center(
              child: CircularProgressIndicator(color: AppTheme.goldAccent),
            )
          : admin.errorMessage != null
          ? Center(
              child: Text(
                admin.errorMessage!,
                style: TextStyle(color: Colors.redAccent),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: admin.socios.length,
              itemBuilder: (ctx, i) {
                final socio = admin.socios[i];
                final estado = admin.getEstadoSocio(socio);
                final color = admin.getColorEstado(estado);

                return Card(
                  color: AppTheme.warmGrey,
                  margin: const EdgeInsets.only(bottom: 12),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: color.withOpacity(0.5), width: 2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    title: Text(
                      socio.nombre,
                      style: GoogleFonts.outfit(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onSurface,
                        fontSize: 18,
                      ),
                    ),
                    subtitle: Text(
                      'Día de pago: ${socio.diaPagoFijo}  •  Rol: ${socio.rol}',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                        fontSize: 12,
                      ),
                    ),
                    trailing: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: color.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: color.withOpacity(0.5)),
                      ),
                      child: Text(
                        estado,
                        style: GoogleFonts.inter(
                          color: color,
                          fontWeight: FontWeight.bold,
                          fontSize: 11,
                        ),
                      ),
                    ),
                    onTap: () {
                      if (estado != 'AL DÍA') {
                        _registrarPago(context, socio);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Este socio ya pagó este mes'),
                          ),
                        );
                      }
                    },
                  ),
                );
              },
            ),
    );
  }
}
