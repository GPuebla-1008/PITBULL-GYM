import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/utils/pwa_installer.dart';
import '../../core/services/auth_service.dart';
import '../../core/services/validation_service.dart';
import '../../core/theme/app_theme.dart';

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
                    onPressed: () {
                      final prompted = promptPwaInstall();
                      
                      if (!prompted) {
                        showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            backgroundColor: AppTheme.charcoalBackground,
                            title: Text('Instalación Manual', style: TextStyle(color: AppTheme.goldAccent)),
                            content: Text(
                              'Tu dispositivo no permite lanzar la instalación directa (es posible que estés en iOS o falte HTTPS).\n\n'
                              'Para descargar la aplicación, abre el menú de tu navegador (los 3 puntos en Android o "Compartir" en Safari) y selecciona "Agregar a la pantalla principal".',
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
                      }
                    },
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
