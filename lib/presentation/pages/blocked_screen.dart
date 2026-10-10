import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../core/theme/app_theme.dart';
import '../../core/services/payment_service.dart';
import '../../core/services/auth_provider.dart';
import '../../core/models/usuario_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BlockedScreen extends StatefulWidget {
  final UsuarioModel perfil;

  const BlockedScreen({super.key, required this.perfil});

  @override
  State<BlockedScreen> createState() => _BlockedScreenState();
}

class _BlockedScreenState extends State<BlockedScreen> {
  final String alias = 'mza.pitbullgym';
  bool _isSubmitting = false;

  void _copyAlias(BuildContext context) {
    Clipboard.setData(ClipboardData(text: alias)).then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('¡Alias copiado al portapapeles!'),
          backgroundColor: Colors.green.shade700,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          duration: const Duration(seconds: 2),
        ),
      );
    });
  }

  Future<void> _notifyPayment(BuildContext context) async {
    final paymentService = context.read<PaymentService>();
    
    setState(() => _isSubmitting = true);

    try {
      await paymentService.notifyTransfer(
        userId: widget.perfil.uid,
        nombre: widget.perfil.nombre,
      );
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Notificación enviada. Verificaremos tu pago pronto.'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error al enviar notificación: $e'),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final paymentService = context.watch<PaymentService>();
    final userId = widget.perfil.uid;

    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: AppTheme.charcoalBackground,
        appBar: AppBar(
          title: const Text('ACCESO BLOQUEADO'),
          backgroundColor: Colors.redAccent.withOpacity(0.1),
          elevation: 0,
          centerTitle: true,
          automaticallyImplyLeading: false, // Ocultar el botón de retroceso
          actions: [
            // Permitir hacer logout para salir de la cuenta bloqueada
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () async {
                await context.read<AuthProvider>().logout();
              },
              tooltip: 'Cerrar Sesión',
            )
          ],
        ),
        body: StreamBuilder<DocumentSnapshot?>(
          stream: paymentService.getPendingPaymentDoc(userId),
          builder: (context, snapshot) {
            final isPending = snapshot.data != null;

            return Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 500),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // --- CARTEL DE AVISO DE VENCIMIENTO ---
                      Container(
                        padding: const EdgeInsets.all(20),
                        margin: const EdgeInsets.only(bottom: 24),
                        decoration: BoxDecoration(
                          color: Colors.redAccent.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Colors.redAccent, width: 2),
                        ),
                        child: Column(
                          children: [
                            const Icon(Icons.lock_outline, color: Colors.redAccent, size: 56),
                            const SizedBox(height: 16),
                            Text(
                              'TU CUOTA HA VENCIDO',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.outfit(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.redAccent,
                                letterSpacing: 1.5,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              'Para seguir entrenando y utilizar la aplicación, por favor realizá el pago.',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.inter(
                                color: Theme.of(context).colorScheme.onSurface,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      ),

                      if (isPending) ...[
                        // --- BANNER DE PAGO PENDIENTE ---
                        Container(
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            color: Colors.amber.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: Colors.amber, width: 1.5),
                          ),
                          child: Column(
                            children: [
                              const Icon(Icons.hourglass_empty, color: Colors.amber, size: 48),
                              const SizedBox(height: 16),
                              Text(
                                'Aviso enviado',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.outfit(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.amber,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Tu pago está en revisión por el administrador. Se desbloqueará el acceso cuando sea aprobado.',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.inter(
                                  color: Theme.of(context).colorScheme.onSurface,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ] else ...[
                        // --- DATOS DE TRANSFERENCIA ---
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppTheme.goldAccent.withOpacity(0.12),
                            border: Border.all(
                              color: AppTheme.goldAccent.withOpacity(0.3),
                              width: 1.5,
                            ),
                          ),
                          child: const Icon(
                            Icons.account_balance_wallet_outlined,
                            color: AppTheme.goldAccent,
                            size: 44,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'DATOS PARA TRANSFERIR',
                          style: GoogleFonts.outfit(
                            fontSize: 20,
                            fontWeight: FontWeight.w900,
                            color: AppTheme.goldAccent,
                            letterSpacing: 2,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Transfiere tu cuota al siguiente alias y presiona el botón de confirmación:',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.inter(
                            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                            fontSize: 13,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 18,
                            horizontal: 24,
                          ),
                          decoration: BoxDecoration(
                            color: AppTheme.warmGrey,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.1)),
                          ),
                          child: Column(
                            children: [
                              Text(
                                'ALIAS:',
                                style: GoogleFonts.inter(
                                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.54),
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 2,
                                ),
                              ),
                              const SizedBox(height: 6),
                              FittedBox(
                                child: Text(
                                  alias,
                                  style: GoogleFonts.outfit(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).colorScheme.onSurface,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16),
                              ElevatedButton.icon(
                                onPressed: () => _copyAlias(context),
                                icon: const Icon(Icons.copy, size: 16),
                                label: const Text('COPIAR ALIAS'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppTheme.goldAccent,
                                  foregroundColor: Colors.black,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 28),
                        SizedBox(
                          width: double.infinity,
                          height: 54,
                          child: ElevatedButton(
                            onPressed: _isSubmitting ? null : () => _notifyPayment(context),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                            ),
                            child: _isSubmitting
                                ? const CircularProgressIndicator(color: Colors.white)
                                : Text(
                                    'YA REALICÉ LA TRANSFERENCIA',
                                    style: GoogleFonts.outfit(fontWeight: FontWeight.bold, letterSpacing: 1),
                                  ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
