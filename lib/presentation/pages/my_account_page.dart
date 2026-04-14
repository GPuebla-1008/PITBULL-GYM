import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import 'package:provider/provider.dart';
import '../../core/services/auth_provider.dart';
import 'package:google_fonts/google_fonts.dart';

class MyAccountPage extends StatefulWidget {
  @override
  _MyAccountPageState createState() => _MyAccountPageState();
}

class _MyAccountPageState extends State<MyAccountPage> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController? _nameController;
  TextEditingController? _phoneController;
  TextEditingController? _emergencyPhoneController;
  TextEditingController? _emailController;
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController?.dispose();
    _phoneController?.dispose();
    _emergencyPhoneController?.dispose();
    _emailController?.dispose();
    super.dispose();
  }

  void _showPasswordRecovery() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppTheme.warmGrey,
        title: Text(
          'Recuperar Contraseña',
          style: TextStyle(color: AppTheme.goldAccent),
        ),
        content: Text(
          'Elige cómo deseas recibir el código o enlace de recuperación.',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Correo de recuperación enviado.')),
              );
            },
            child: Text(
              'VÍA CORREO',
              style: TextStyle(color: AppTheme.goldAccent),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('SMS de recuperación enviado al teléfono.'),
                ),
              );
            },
            child: Text(
              'VÍA SMS',
              style: TextStyle(color: AppTheme.goldAccent),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _saveChanges() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      final auth = Provider.of<AuthProvider>(context, listen: false);
      final success = await auth.updateProfile(
        nombre: _nameController?.text ?? '',
        email: _emailController?.text ?? '',
        telefono: _phoneController?.text ?? '',
        telefonoEmergencia: _emergencyPhoneController?.text ?? '',
      );

      setState(() => _isLoading = false);

      if (success) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Cambios guardados exitosamente.')),
          );
          Navigator.pop(context);
        }
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                auth.errorMessage ?? 'Error al guardar los cambios.',
              ),
              backgroundColor: Colors.redAccent,
            ),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    final perfil = auth.perfil;

    // Inicialización tardía segura
    _nameController ??= TextEditingController(text: perfil?.nombre ?? '');
    _emailController ??= TextEditingController(text: perfil?.email ?? '');
    _phoneController ??= TextEditingController(text: perfil?.telefono ?? '');
    _emergencyPhoneController ??= TextEditingController(
      text: perfil?.telefonoEmergencia ?? '',
    );

    return Scaffold(
      appBar: AppBar(title: Text('MI CUENTA')),
      body: _isLoading
          ? Center(child: CircularProgressIndicator(color: AppTheme.goldAccent))
          : SingleChildScrollView(
              padding: EdgeInsets.all(24),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _buildProfileImage(
                      perfil?.nombre.isNotEmpty == true
                          ? perfil!.nombre[0]
                          : 'U',
                    ),
                    SizedBox(height: 32),

                    // Warning Banner
                    Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.orangeAccent.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: Colors.orangeAccent.withOpacity(0.5),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.warning_amber_rounded,
                            color: Colors.orangeAccent,
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              'IMPORTANTE: Asegurate de que tus datos sean reales ante cualquier emergencia médica.',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 24),

                    _buildTextField(
                      controller: _nameController!,
                      label: 'Nombre y Apellido',
                      icon: Icons.person_outline,
                    ),
                    SizedBox(height: 16),
                    _buildTextField(
                      controller: _emailController!,
                      label: 'Correo Electrónico',
                      icon: Icons.email_outlined,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    SizedBox(height: 16),
                    _buildTextField(
                      controller: _phoneController!,
                      label: 'Teléfono Particular',
                      icon: Icons.phone_outlined,
                      keyboardType: TextInputType.phone,
                    ),
                    SizedBox(height: 16),
                    _buildTextField(
                      controller: _emergencyPhoneController!,
                      label: 'Teléfono de Emergencia',
                      icon: Icons.contact_emergency_outlined,
                      keyboardType: TextInputType.phone,
                    ),
                    SizedBox(height: 32),

                    Align(
                      alignment: Alignment.centerLeft,
                      child: TextButton.icon(
                        onPressed: _showPasswordRecovery,
                        icon: Icon(
                          Icons.lock_reset,
                          color: AppTheme.electricOrange,
                        ),
                        label: Text(
                          'Recuperar / Cambiar Contraseña',
                          style: TextStyle(
                            color: AppTheme.electricOrange,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 32),

                    ElevatedButton(
                      onPressed: _saveChanges,
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(double.infinity, 50),
                      ),
                      child: Text('GUARDAR CAMBIOS'),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildProfileImage(String initial) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        CircleAvatar(
          radius: 50,
          backgroundColor: AppTheme.goldAccent,
          child: Text(
            initial.toUpperCase(),
            style: TextStyle(
              fontSize: 40,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: AppTheme.charcoalBackground,
            shape: BoxShape.circle,
            border: Border.all(color: AppTheme.goldAccent, width: 2),
          ),
          child: IconButton(
            icon: Icon(Icons.camera_alt, color: AppTheme.goldAccent, size: 20),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Selector de imágenes no implementado en este demo.',
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      style: TextStyle(color: Colors.white),
      validator: (v) => v == null || v.isEmpty ? 'Campo requerido' : null,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: AppTheme.goldAccent),
      ),
    );
  }
}
