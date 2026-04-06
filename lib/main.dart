import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'core/services/firebase_config.dart';
import 'core/theme/app_theme.dart';
import 'core/services/auth_provider.dart' as gym;
import 'presentation/pages/login_page.dart';
import 'presentation/widgets/stopwatch_widget.dart';
import 'presentation/pages/my_account_page.dart';
import 'presentation/pages/routines_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializar Firebase con las credenciales del proyecto pitbull-gym-100889
  await Firebase.initializeApp(options: FirebaseConfig.webOptions);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => gym.AuthProvider()),
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
      title: 'PITBULL GYM',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeProvider.mode,
      // AuthGate decide la ruta inicial basándose en el estado de Firebase Auth
      home: const AuthGate(),
      routes: {
        '/login': (context) => const LoginPage(),
        '/dashboard': (context) => const MainDashboard(),
      },
    );
  }
}

/// AuthGate: escucha el stream de Firebase Auth y redirige automáticamente.
/// Si el usuario está autenticado → Dashboard. Si no → Login.
class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // Cargando
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            backgroundColor: AppTheme.charcoalBackground,
            body: Center(
              child: CircularProgressIndicator(color: AppTheme.goldAccent),
            ),
          );
        }
        // Autenticado → Dashboard
        if (snapshot.hasData) return const MainDashboard();
        // No autenticado → Login
        return const LoginPage();
      },
    );
  }
}

// ── Dashboard Principal ────────────────────────────────────────────────────────
class MainDashboard extends StatelessWidget {
  const MainDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<gym.AuthProvider>(context);
    final perfil = authProvider.perfil;
    final firebaseUser = authProvider.firebaseUser;

    // Protección extra: si no hay sesión, mandar al login
    if (firebaseUser == null) return const LoginPage();

    final displayName = perfil?.nombre ?? firebaseUser.email?.split('@').first ?? 'Atleta';
    final inicial = displayName[0].toUpperCase();

    return Scaffold(
      appBar: AppBar(
        title: const Text('PITBULL GYM'),
        actions: [
          IconButton(
            icon: const Icon(Icons.brightness_6),
            onPressed: () => Provider.of<ThemeProvider>(context, listen: false).toggleMode(),
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await authProvider.logout();
              if (context.mounted) Navigator.of(context).pushReplacementNamed('/login');
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header usuario
            Row(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundColor: AppTheme.goldAccent,
                  child: Text(
                    inicial,
                    style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hola, $displayName 💪',
                        style: GoogleFonts.outfit(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      if (perfil != null)
                        Text(
                          'Objetivo: ${perfil.objetivo}',
                          style: GoogleFonts.inter(fontSize: 12, color: Colors.white54),
                        ),
                      const SizedBox(height: 4),
                      InkWell(
                        onTap: () => Navigator.push(
                          context, MaterialPageRoute(builder: (_) => MyAccountPage())),
                        child: Text(
                          'Mi Cuenta',
                          style: GoogleFonts.inter(
                            color: AppTheme.goldAccent,
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),

            _sectionHeader('SEGUIMIENTO DE CLASE'),
            const SizedBox(height: 16),
            Center(
              child: Image.asset('assets/images/logo.png', height: 320, fit: BoxFit.contain),
            ),
            const SizedBox(height: 16),
            StopwatchWidget(),
            const SizedBox(height: 48),

            _sectionHeader('ENTRENAMIENTO'),
            const SizedBox(height: 16),
            Card(
              child: ListTile(
                leading: Icon(Icons.fitness_center, color: AppTheme.goldAccent, size: 36),
                title: Text('MIS RUTINAS', style: GoogleFonts.outfit(fontWeight: FontWeight.bold, fontSize: 18)),
                subtitle: const Text('Principiante, Intermedio y Avanzado'),
                trailing: Icon(Icons.arrow_forward_ios, color: AppTheme.goldAccent),
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => RoutinesPage())),
              ),
            ),
            const SizedBox(height: 48),

            _sectionHeader('CONTACTOS'),
            const SizedBox(height: 16),
            Image.asset('assets/images/contacts.png', width: double.infinity, fit: BoxFit.contain),
          ],
        ),
      ),
    );
  }

  Widget _sectionHeader(String title) => Text(
        title,
        style: GoogleFonts.outfit(
          fontSize: 13,
          fontWeight: FontWeight.bold,
          color: AppTheme.goldAccent.withOpacity(0.85),
          letterSpacing: 2.5,
        ),
      );
}

// ── Theme Provider ────────────────────────────────────────────────────────────
class ThemeProvider with ChangeNotifier {
  ThemeMode _mode = ThemeMode.dark;
  ThemeMode get mode => _mode;

  void toggleMode() {
    _mode = (_mode == ThemeMode.dark) ? ThemeMode.light : ThemeMode.dark;
    notifyListeners();
  }
}
