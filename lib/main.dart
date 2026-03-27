import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';
import 'core/theme/app_theme.dart';
import 'core/services/auth_service.dart';
import 'presentation/pages/login_page.dart';
import 'presentation/widgets/stopwatch_widget.dart';
import 'presentation/widgets/mercado_pago_button.dart';
import 'presentation/pages/my_account_page.dart';
import 'presentation/pages/routines_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => AuthService()),
      ],
      child: const PitbullGymApp(),
    ),
  );
}

class PitbullGymApp extends StatelessWidget {
  const PitbullGymApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    
    return MaterialApp(
      title: 'Pitbull Gym PWA',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeProvider.mode,
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginPage(),
        '/dashboard': (context) => MainDashboard(),
      },
    );
  }
}


// Mock dashboard to demonstrate the widgets
class MainDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthService>(context);
    final user = auth.currentUser;

    if (user == null) return LoginPage();

    return Scaffold(
      appBar: AppBar(
        title: Text(user.role == UserRole.admin ? 'ADMIN PANEL' : 'GESTOR DE CLASE'),
        actions: [
          IconButton(
            icon: Icon(Icons.brightness_6),
            onPressed: () => Provider.of<ThemeProvider>(context, listen: false).toggleMode(),
          ),
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              Provider.of<AuthService>(context, listen: false).logout();
              Navigator.of(context).pushReplacementNamed('/login');
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: AppTheme.goldAccent,
                  child: Text(user.username[0].toUpperCase(), style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                ),
                SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Hola, ${user.username}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    Text('Rol: ${user.role.toString().split('.').last.toUpperCase()} | Tenant: ${user.tenantId}', style: TextStyle(fontSize: 12, color: Colors.white54)),
                    SizedBox(height: 8),
                    InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => MyAccountPage()));
                      },
                      child: Text('Mi Cuenta', style: TextStyle(color: AppTheme.goldAccent, decoration: TextDecoration.underline, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 32),
            _buildSectionHeader('SEGUIMIENTO DE CLASE'),
            SizedBox(height: 16),
            Center(
              child: Image.asset(
                'assets/images/logo.png',
                height: 480, // Quadrupled logo size
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(height: 16),
            StopwatchWidget(),
            SizedBox(height: 48),
            _buildSectionHeader('ENTRENAMIENTO'),
            SizedBox(height: 16),
            Card(
              child: ListTile(
                leading: Icon(Icons.fitness_center, color: AppTheme.goldAccent, size: 36),
                title: Text('MIS RUTINAS', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                subtitle: Text('Principiante, Intermedio y Avanzado'),
                trailing: Icon(Icons.arrow_forward_ios, color: AppTheme.goldAccent),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => RoutinesPage()));
                },
              ),
            ),
            SizedBox(height: 48),
            _buildSectionHeader('SUSCRIPCIÓN'),
            SizedBox(height: 16),
            MercadoPagoButton(),
            SizedBox(height: 48),
            _buildSectionHeader('ENTIDADES (TENANT)'),
            Card(
              child: ListTile(
                leading: Icon(Icons.fitness_center, color: AppTheme.goldAccent),
                title: Text('HIIT AVANZADO', style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text('ID del Tenant: ${user.tenantId}'),
                trailing: user.role == UserRole.admin 
                    ? Icon(Icons.edit, color: AppTheme.goldAccent) 
                    : Icon(Icons.lock_outline, size: 16),
              ),
            ),
            if (user.role == UserRole.admin) ...[
              SizedBox(height: 20),
              Card(
                child: ListTile(
                  leading: Icon(Icons.people, color: AppTheme.goldAccent),
                  title: Text('GESTIÓN DE USUARIOS', style: TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text('Admin access enabled'),
                  trailing: Icon(Icons.settings),
                ),
              ),
            ],
            SizedBox(height: 48),
            _buildSectionHeader('CONTACTOS'),
            SizedBox(height: 16),
            Image.asset(
              'assets/images/contacts.png',
              width: double.infinity,
              fit: BoxFit.contain,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: AppTheme.goldAccent.withOpacity(0.8),
        letterSpacing: 2,
      ),
    );
  }
}


// Basic Theme Manager
class ThemeProvider with ChangeNotifier {
  ThemeMode _mode = ThemeMode.system;
  ThemeMode get mode => _mode;

  void toggleMode() {
    _mode = (_mode == ThemeMode.dark) ? ThemeMode.light : ThemeMode.dark;
    notifyListeners();
  }
}
