import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/theme/app_theme.dart';

/// Botón de pago que conecta con el Cloudflare Worker de checkout.
///
/// Flujo:
///   1. El Worker genera una preferencia en MercadoPago con el alias "pitbullgym".
///   2. El usuario es redirigido al checkout oficial de MercadoPago.
///   3. El pago se acredita en la cuenta asociada al alias "pitbullgym".
///
/// Worker URL: https://pitbull-gym-checkout.workers.dev
class MercadoPagoButton extends StatefulWidget {
  final double amount;
  final String description;
  final String? payerEmail;

  const MercadoPagoButton({
    Key? key,
    this.amount = 0,
    this.description = 'Cuota PITBULL GYM',
    this.payerEmail,
  }) : super(key: key);

  @override
  State<MercadoPagoButton> createState() => _MercadoPagoButtonState();
}

class _MercadoPagoButtonState extends State<MercadoPagoButton> {
  static const String _workerBase = 'https://pitbull-gym-checkout.pitbullgym.workers.dev';
  static const String _alias = 'pitbullgym';

  bool _loading = false;

  Future<void> _pay() async {
    setState(() => _loading = true);

    try {
      Uri url;

      if (widget.amount > 0) {
        // Ruta con monto: el Worker crea una preferencia MP completa
        url = Uri.parse('$_workerBase/pay').replace(queryParameters: {
          'amount': widget.amount.toStringAsFixed(2),
          'description': widget.description,
          if (widget.payerEmail != null) 'email': widget.payerEmail!,
        });
      } else {
        // Sin monto definido: redirige directo al alias de MercadoPago
        url = Uri.parse('https://link.mercadopago.com.ar/$_alias');
      }

      if (await canLaunchUrl(url)) {
        await launchUrl(url, mode: LaunchMode.externalApplication);
      } else {
        throw Exception('No se pudo abrir el enlace de pago.');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error al procesar el pago: $e'),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 60,
      decoration: BoxDecoration(
        color: const Color(0xFF00B1EA), // MercadoPago Blue
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF00B1EA).withOpacity(0.35),
            blurRadius: 15,
            spreadRadius: 2,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: _loading ? null : _pay,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (_loading)
                  const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2.5,
                    ),
                  )
                else
                  const Icon(Icons.payment, color: Colors.white, size: 28),
                const SizedBox(width: 14),
                Text(
                  _loading ? 'PROCESANDO...' : 'PAGAR CUOTA',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    letterSpacing: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
