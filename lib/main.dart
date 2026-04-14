import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'core/services/firebase_config.dart';
import 'core/theme/app_theme.dart';
import 'core/services/auth_provider.dart' as gym;
import 'core/services/admin_provider.dart';
import 'core/services/workout_provider.dart';
import 'core/services/metrics_provider.dart';
import 'presentation/pages/login_page.dart';
import 'presentation/widgets/stopwatch_widget.dart';
import 'presentation/pages/my_account_page.dart';
import 'presentation/pages/routines_page.dart';
import 'presentation/pages/dietas_page.dart';
import 'presentation/pages/payment_info_page.dart';
import 'presentation/pages/admin_dashboard_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializar Firebase con las credenciales del proyecto pitbull-gym-100889
  await Firebase.initializeApp(options: FirebaseConfig.webOptions);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => gym.AuthProvider()),
        ChangeNotifierProvider(create: (_) => AdminProvider()),
        ChangeNotifierProvider(create: (_) => WorkoutProvider()),
        ChangeNotifierProvider(create: (_) => MetricsProvider()),
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

    final displayName =
        perfil?.nombre ?? firebaseUser.email?.split('@').first ?? 'Atleta';
    final inicial = displayName[0].toUpperCase();

    return Scaffold(
      appBar: AppBar(
        title: const Text('PITBULL GYM'),
        actions: [
          IconButton(
            icon: const Icon(Icons.brightness_6),
            onPressed: () =>
                Provider.of<ThemeProvider>(context, listen: false).toggleMode(),
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await authProvider.logout();
              if (context.mounted)
                Navigator.of(context).pushReplacementNamed('/login');
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width < 380 ? 16 : 24,
          vertical: 24,
        ),
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
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hola, $displayName 💪',
                        style: GoogleFonts.outfit(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      if (perfil != null)
                        Text(
                          'Objetivo: ${perfil.objetivo}',
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            color: Colors.white54,
                          ),
                        ),
                      const SizedBox(height: 4),
                      InkWell(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => MyAccountPage()),
                        ),
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
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final logoH = (MediaQuery.of(context).size.height * 0.28)
                      .clamp(140.0, 280.0);
                  return Image.asset(
                    'assets/images/logo.png',
                    height: logoH,
                    fit: BoxFit.contain,
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            StopwatchWidget(),
            const SizedBox(height: 16),
            _buildRutinaActiva(context),
            const SizedBox(height: 48),

            _sectionHeader('ENTRENAMIENTO'),
            const SizedBox(height: 16),
            Card(
              child: ListTile(
                leading: Icon(
                  Icons.fitness_center,
                  color: AppTheme.goldAccent,
                  size: 36,
                ),
                title: Text(
                  'MIS RUTINAS',
                  style: GoogleFonts.outfit(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                subtitle: const Text('Principiante, Intermedio y Avanzado'),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: AppTheme.goldAccent,
                ),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => RoutinesPage()),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              child: ListTile(
                leading: Image.asset(
                  'assets/images/dietas_logo.png',
                  width: 36,
                  height: 36,
                  fit: BoxFit.contain,
                ),
                title: Text(
                  'PLANES DE ALIMENTACIÓN Y SEGUIMIENTO',
                  style: GoogleFonts.outfit(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: AppTheme.goldAccent,
                  ),
                ),
                subtitle: const Text('Nutrición, Agua y Monitor de Peso'),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: AppTheme.goldAccent,
                ),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const DietasRecomendadasPage(),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 48),

            _sectionHeader('SUSCRIPCIÓN'),
            const SizedBox(height: 16),
            Card(
              child: ListTile(
                leading: Icon(
                  Icons.payment,
                  color: AppTheme.goldAccent,
                  size: 36,
                ),
                title: Text(
                  'PAGAR CUOTA',
                  style: GoogleFonts.outfit(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                subtitle: const Text('Realizar transferencia (Alias)'),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: AppTheme.goldAccent,
                ),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const PaymentInfoPage()),
                ),
              ),
            ),
            const SizedBox(height: 48),

            _sectionHeader('CONTACTOS'),
            const SizedBox(height: 16),
            Image.asset(
              'assets/images/contacts.png',
              width: double.infinity,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 48),

            if (perfil != null && perfil.rol == 'admin') ...[
              _sectionHeader('ADMINISTRACIÓN (Solo Dueños)'),
              const SizedBox(height: 16),
              Card(
                color: Colors.redAccent.withOpacity(0.1),
                shape: RoundedRectangleBorder(
                  side: const BorderSide(color: Colors.redAccent, width: 1.5),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  leading: const Icon(
                    Icons.admin_panel_settings,
                    color: Colors.redAccent,
                    size: 36,
                  ),
                  title: Text(
                    'GESTOR DE SOCIOS',
                    style: GoogleFonts.outfit(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                  subtitle: const Text(
                    'Control de pagos y deudores',
                    style: TextStyle(color: Colors.white70),
                  ),
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.redAccent,
                  ),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const AdminDashboardPage(),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 48),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildRutinaActiva(BuildContext context) {
    final workout = Provider.of<WorkoutProvider>(context);
    final rutina = workout.rutinaActiva;

    if (rutina == null) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Center(
          child: Text(
            'RUTINA ACTIVA: ${rutina.nombreDia.toUpperCase()}',
            style: GoogleFonts.outfit(
              color: AppTheme.electricOrange,
              fontWeight: FontWeight.bold,
              fontSize: 16,
              letterSpacing: 1,
            ),
          ),
        ),
        const SizedBox(height: 16),
        LayoutBuilder(
          builder: (context, constraints) {
            final screenW = MediaQuery.of(context).size.width;
            final cardW = (screenW * 0.60).clamp(160.0, 220.0);
            final carouselH = (MediaQuery.of(context).size.height * 0.30).clamp(
              200.0,
              280.0,
            );

            return SizedBox(
              height: carouselH,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: rutina.ejercicios.length,
                itemBuilder: (ctx, i) {
                  final ej = rutina.ejercicios[i];
                  return Container(
                    width: cardW,
                    margin: const EdgeInsets.only(right: 12),
                    child: Card(
                      color: ej.isCompleted
                          ? Colors.green.withOpacity(0.1)
                          : AppTheme.warmGrey,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: ej.isCompleted
                              ? Colors.green
                              : AppTheme.electricOrange.withOpacity(0.5),
                          width: ej.isCompleted ? 2 : 1,
                        ),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: InkWell(
                        onTap: () => workout.toggleEjercicio(i),
                        borderRadius: BorderRadius.circular(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Expanded(
                              child: ClipRRect(
                                borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(16),
                                ),
                                child: Container(
                                  color: Colors.white,
                                  child: Stack(
                                    fit: StackFit.expand,
                                    children: [
                                      Image.asset(
                                        ej.urlGif,
                                        fit: BoxFit.contain,
                                        errorBuilder: (c, e, s) => const Icon(
                                          Icons.fitness_center,
                                          color: Colors.grey,
                                          size: 40,
                                        ),
                                      ),
                                      if (ej.isCompleted)
                                        Container(
                                          color: Colors.green.withOpacity(0.4),
                                          child: const Icon(
                                            Icons.check_circle,
                                            color: Colors.white,
                                            size: 60,
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    ej.nombre,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 13,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 3),
                                  Text(
                                    '${ej.seriesReps} • Descanso: ${ej.descanso}',
                                    style: const TextStyle(
                                      color: Colors.white70,
                                      fontSize: 10,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () => workout.finalizarSesion(),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.redAccent,
            foregroundColor: Colors.white,
          ),
          child: const Text('FINALIZAR ENTRENAMIENTO'),
        ),
      ],
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
