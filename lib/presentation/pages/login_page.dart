import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/services/auth_service.dart';
import '../../core/services/validation_service.dart';
import '../../core/theme/app_theme.dart';
import 'package:universal_html/html.dart' as html;
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  void _handleLogin() {
    if (_formKey.currentState!.validate()) {
      final auth = Provider.of<AuthService>(context, listen: false);
      final success = auth.login(_usernameController.text, _passwordController.text);
      if (success) {
        Navigator.of(context).pushReplacementNamed('/dashboard');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Credenciales incorrectas'),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
    }
  }

  Future<void> _downloadAPK() async {
    // 1. Detección Inteligente para iPhone/iPad/iOS
    // Ni Apple ni los iPhones permiten instalar archivos .apk
    if (defaultTargetPlatform == TargetPlatform.iOS || defaultTargetPlatform == TargetPlatform.macOS) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          backgroundColor: AppTheme.charcoalBackground,
          title: Text('Instalación en Dispositivos Apple', style: TextStyle(color: AppTheme.goldAccent)),
          content: Text(
            'Los dispositivos de Apple (iPhone/iPad) no admiten instaladores .APK.\n\n'
            'Para usar PITBULL GYM como aplicación en tu pantalla, toca el botón "Compartir" (el ícono cuadrado inferior con una flecha hacia arriba) y selecciona "Agregar a Inicio".',
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: Text('ENTENDIDO', style: TextStyle(color: AppTheme.goldAccent)),
            ),
          ],
        ),
      );
      return; // Detenemos la ejecución aquí para dispositivos Apple
    }

    // 2. Si es Android o PC, descargar el APK desde Firebase (evita el Error 404 de GitHub Privado)
    final Uri url = Uri.parse('https://pitbull-gym-100889.web.app/app-release.apk');
    
    try {
      if (kIsWeb) {
        final html.AnchorElement anchor = html.AnchorElement(href: url.toString())
          ..setAttribute('download', 'app-release.apk')
          ..target = '_blank';
        html.document.body?.append(anchor);
        anchor.click();
        anchor.remove();
      } else {
        if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
          throw Exception('No se pudo abrir el enlace de descarga.');
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error al procesar la descarga de la App.'),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(32),
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 400),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildLogo(),
                  SizedBox(height: 48),
                  _buildTextField(
                    controller: _usernameController,
                    label: 'Usuario',
                    icon: Icons.person,
                    validator: (v) => v == null || v.isEmpty ? 'Requerido' : null,
                  ),
                  SizedBox(height: 20),
                  _buildTextField(
                    controller: _passwordController,
                    label: 'Contraseña',
                    icon: Icons.lock,
                    isObscure: true,
                    validator: (v) => v == null || v.isEmpty ? 'Requerido' : null,
                  ),
                  SizedBox(height: 40),
                  ElevatedButton(
                    onPressed: _handleLogin,
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.infinity, 60),
                    ),
                    child: Text('ENTRAR'),
                  ),
                  SizedBox(height: 24),
                  ElevatedButton.icon(
                    onPressed: _downloadAPK,
                    icon: Icon(Icons.download, color: Colors.black),
                    label: Text('Descargar App (Todos los Dispositivos)', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.goldAccent,
                      minimumSize: Size(double.infinity, 50),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Column(
      children: [
        Image.asset(
          'assets/images/logo.png',
          height: 360,
          fit: BoxFit.contain,
        ),
      ],
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool isObscure = false,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: isObscure,
      validator: validator,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: AppTheme.goldAccent),
      ),
    );
  }
}
