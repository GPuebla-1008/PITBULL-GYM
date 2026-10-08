import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../core/theme/app_theme.dart';

enum TimerMode { cronometro, temporizador }

class StopwatchWidget extends StatefulWidget {
  const StopwatchWidget({super.key});

  @override
  _StopwatchWidgetState createState() => _StopwatchWidgetState();
}

class _StopwatchWidgetState extends State<StopwatchWidget> {
  TimerMode _mode = TimerMode.cronometro;

  // --- Estado Cronómetro ---
  final Stopwatch _stopwatch = Stopwatch();
  Timer? _stopwatchTimer;

  // --- Estado Temporizador ---
  int _timerInitialSeconds = 60; // 1 minuto por defecto
  int _timerRemainingSeconds = 60;
  bool _isTimerRunning = false;
  Timer? _countdownTimer;
  bool _timerFinished = false;

  final List<int> _presetSeconds = [30, 45, 60, 90, 120, 180, 300];

  @override
  void dispose() {
    _stopwatchTimer?.cancel();
    _countdownTimer?.cancel();
    super.dispose();
  }

  // ================= CRONÓMETRO =================
  void _toggleStopwatch() {
    setState(() {
      if (_stopwatch.isRunning) {
        _stopwatch.stop();
        _stopwatchTimer?.cancel();
      } else {
        _stopwatch.start();
        _stopwatchTimer = Timer.periodic(const Duration(milliseconds: 30), (_) {
          if (mounted) setState(() {});
        });
      }
    });
  }

  void _resetStopwatch() {
    setState(() {
      _stopwatch.reset();
      if (!_stopwatch.isRunning) {
        _stopwatchTimer?.cancel();
      }
    });
  }

  String _formatStopwatchTime() {
    final duration = _stopwatch.elapsed;
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    final milliseconds = twoDigits(
      (duration.inMilliseconds.remainder(1000) ~/ 10),
    );
    return '$minutes:$seconds:$milliseconds';
  }

  // ================= TEMPORIZADOR =================
  void _toggleTimer() {
    if (_timerRemainingSeconds <= 0) {
      _resetTimer();
    }

    setState(() {
      if (_isTimerRunning) {
        _countdownTimer?.cancel();
        _isTimerRunning = false;
      } else {
        _isTimerRunning = true;
        _timerFinished = false;
        _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
          if (!mounted) return;
          if (_timerRemainingSeconds > 0) {
            setState(() {
              _timerRemainingSeconds--;
            });
          } else {
            _countdownTimer?.cancel();
            setState(() {
              _isTimerRunning = false;
              _timerFinished = true;
            });
            HapticFeedback.vibrate();
            _mostrarAlertaTiempoCumplido();
          }
        });
      }
    });
  }

  void _resetTimer() {
    setState(() {
      _countdownTimer?.cancel();
      _isTimerRunning = false;
      _timerRemainingSeconds = _timerInitialSeconds;
      _timerFinished = false;
    });
  }

  void _selectPreset(int seconds) {
    setState(() {
      _countdownTimer?.cancel();
      _isTimerRunning = false;
      _timerInitialSeconds = seconds;
      _timerRemainingSeconds = seconds;
      _timerFinished = false;
    });
  }

  void _addSeconds(int secondsToAdd) {
    setState(() {
      _timerRemainingSeconds += secondsToAdd;
      if (_timerRemainingSeconds > _timerInitialSeconds) {
        _timerInitialSeconds = _timerRemainingSeconds;
      }
      _timerFinished = false;
    });
  }

  String _formatTimerTime() {
    final minutes = (_timerRemainingSeconds ~/ 60).toString().padLeft(2, '0');
    final seconds = (_timerRemainingSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  void _mostrarAlertaTiempoCumplido() {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Row(
          children: [
            Icon(Icons.alarm_on, color: Colors.black, size: 28),
            SizedBox(width: 12),
            Text(
              '¡TIEMPO CUMPLIDO! Descanso finalizado.',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        backgroundColor: AppTheme.goldAccent,
        duration: const Duration(seconds: 4),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  Future<void> _abrirSelectorPersonalizado() async {
    int minutos = _timerInitialSeconds ~/ 60;
    int segundos = _timerInitialSeconds % 60;

    await showModalBottomSheet(
      context: context,
      backgroundColor: AppTheme.charcoalBackground,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'PERSONALIZAR TEMPORIZADOR',
                    style: TextStyle(
                      color: AppTheme.goldAccent,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Minutos
                      Column(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.keyboard_arrow_up,
                                color: AppTheme.goldAccent, size: 32),
                            onPressed: () {
                              if (minutos < 59) {
                                setModalState(() => minutos++);
                              }
                            },
                          ),
                          Text(
                            minutos.toString().padLeft(2, '0'),
                            style: const TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const Text('MIN',
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 12)),
                          IconButton(
                            icon: const Icon(Icons.keyboard_arrow_down,
                                color: AppTheme.goldAccent, size: 32),
                            onPressed: () {
                              if (minutos > 0) {
                                setModalState(() => minutos--);
                              }
                            },
                          ),
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          ':',
                          style: TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.goldAccent,
                          ),
                        ),
                      ),
                      // Segundos
                      Column(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.keyboard_arrow_up,
                                color: AppTheme.goldAccent, size: 32),
                            onPressed: () {
                              if (segundos < 55) {
                                setModalState(() => segundos += 5);
                              } else {
                                setModalState(() => segundos = 0);
                              }
                            },
                          ),
                          Text(
                            segundos.toString().padLeft(2, '0'),
                            style: const TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const Text('SEG',
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 12)),
                          IconButton(
                            icon: const Icon(Icons.keyboard_arrow_down,
                                color: AppTheme.goldAccent, size: 32),
                            onPressed: () {
                              if (segundos >= 5) {
                                setModalState(() => segundos -= 5);
                              } else {
                                setModalState(() => segundos = 55);
                              }
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {
                      final total = (minutos * 60) + segundos;
                      if (total > 0) {
                        _selectPreset(total);
                        Navigator.pop(ctx);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.goldAccent,
                      foregroundColor: Colors.black,
                      minimumSize: const Size(double.infinity, 48),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'ESTABLECER TIEMPO',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenW = MediaQuery.of(context).size.width;
    final isSmall = screenW < 380;
    final timerFontSize = (screenW * 0.11).clamp(28.0, 52.0);
    final buttonSize = (screenW * 0.12).clamp(42.0, 56.0);

    final isCronometro = _mode == TimerMode.cronometro;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isSmall ? 12 : 18,
        vertical: isSmall ? 14 : 18,
      ),
      decoration: BoxDecoration(
        color: AppTheme.warmGrey,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: _timerFinished
              ? AppTheme.electricOrange
              : AppTheme.goldAccent.withOpacity(0.35),
          width: _timerFinished ? 2 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: (_timerFinished
                    ? AppTheme.electricOrange
                    : AppTheme.goldAccent)
                .withOpacity(0.12),
            blurRadius: 12,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // ── Selector de Modo (Segmented Tabs) ──
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: AppTheme.charcoalBackground,
              borderRadius: BorderRadius.circular(50),
              border: Border.all(
                color: AppTheme.goldAccent.withOpacity(0.25),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildModeTab(
                  mode: TimerMode.cronometro,
                  title: 'CRONÓMETRO',
                  icon: Icons.timer,
                  isSelected: isCronometro,
                ),
                _buildModeTab(
                  mode: TimerMode.temporizador,
                  title: 'TEMPORIZADOR',
                  icon: Icons.hourglass_bottom,
                  isSelected: !isCronometro,
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),

          // ── Título del Modo Activo ──
          Text(
            isCronometro
                ? 'TIEMPO TRANSCURRIDO'
                : (_timerFinished
                    ? '¡TIEMPO CUMPLIDO!'
                    : 'CUENTA REGRESIVA'),
            style: TextStyle(
              color: _timerFinished
                  ? AppTheme.electricOrange
                  : AppTheme.goldAccent,
              letterSpacing: 2,
              fontWeight: FontWeight.bold,
              fontSize: isSmall ? 10 : 12,
            ),
          ),
          const SizedBox(height: 8),

          // ── Display del Tiempo ──
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              isCronometro ? _formatStopwatchTime() : _formatTimerTime(),
              style: TextStyle(
                fontSize: timerFontSize,
                fontFamily: 'Courier',
                fontWeight: FontWeight.bold,
                color: _timerFinished
                    ? AppTheme.electricOrange
                    : Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ),

          // ── Controles Extras para Temporizador (Presets) ──
          if (!isCronometro) ...[
            const SizedBox(height: 10),
            // Barra de Progreso Lineal
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: _timerInitialSeconds > 0
                    ? (_timerRemainingSeconds / _timerInitialSeconds)
                        .clamp(0.0, 1.0)
                    : 0.0,
                backgroundColor: AppTheme.charcoalBackground,
                color: _timerRemainingSeconds <= 10
                    ? AppTheme.electricOrange
                    : AppTheme.goldAccent,
                minHeight: 4,
              ),
            ),
            const SizedBox(height: 12),

            // Chips de Tiempos Rápidos
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  ..._presetSeconds.map((sec) {
                    final label = sec < 60 ? '${sec}s' : '${sec ~/ 60}m';
                    final isCurrentPreset = _timerInitialSeconds == sec &&
                        _timerRemainingSeconds == sec;

                    return Padding(
                      padding: const EdgeInsets.only(right: 6.0),
                      child: ChoiceChip(
                        label: Text(
                          label,
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: isCurrentPreset
                                ? Colors.black
                                : Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                        selected: isCurrentPreset,
                        selectedColor: AppTheme.goldAccent,
                        backgroundColor: AppTheme.charcoalBackground,
                        visualDensity: VisualDensity.compact,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: BorderSide(
                            color: isCurrentPreset
                                ? AppTheme.goldAccent
                                : Colors.white12,
                          ),
                        ),
                        onSelected: (_) => _selectPreset(sec),
                      ),
                    );
                  }),
                  // Botón Personalizar
                  IconButton(
                    icon: const Icon(Icons.tune,
                        color: AppTheme.goldAccent, size: 20),
                    tooltip: 'Personalizar tiempo',
                    visualDensity: VisualDensity.compact,
                    onPressed: _abrirSelectorPersonalizado,
                  ),
                ],
              ),
            ),
          ],

          const SizedBox(height: 14),

          // ── Botones de Acción ──
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Botón Play / Pause
              _buildButton(
                icon: isCronometro
                    ? (_stopwatch.isRunning ? Icons.pause : Icons.play_arrow)
                    : (_isTimerRunning ? Icons.pause : Icons.play_arrow),
                color: (isCronometro ? _stopwatch.isRunning : _isTimerRunning)
                    ? AppTheme.electricOrange
                    : AppTheme.goldAccent,
                onPressed:
                    isCronometro ? _toggleStopwatch : _toggleTimer,
                size: buttonSize,
              ),
              SizedBox(width: isSmall ? 12 : 18),

              // Botón Reset
              _buildButton(
                icon: Icons.refresh,
                color: Theme.of(context).colorScheme.onSurface,
                onPressed:
                    isCronometro ? _resetStopwatch : _resetTimer,
                size: buttonSize,
              ),

              // Si es Temporizador, botón para sumar +30s en caliente
              if (!isCronometro) ...[
                SizedBox(width: isSmall ? 12 : 18),
                _buildButton(
                  icon: Icons.add,
                  color: AppTheme.goldAccent,
                  label: '+30s',
                  onPressed: () => _addSeconds(30),
                  size: buttonSize,
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildModeTab({
    required TimerMode mode,
    required String title,
    required IconData icon,
    required bool isSelected,
  }) {
    return GestureDetector(
      onTap: () {
        if (_mode != mode) {
          setState(() {
            _mode = mode;
          });
        }
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppTheme.goldAccent : Colors.transparent,
          borderRadius: BorderRadius.circular(40),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 15,
              color: isSelected ? Colors.black : Colors.grey,
            ),
            const SizedBox(width: 6),
            Text(
              title,
              style: TextStyle(
                color: isSelected ? Colors.black : Colors.grey,
                fontSize: 11,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.8,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButton({
    required IconData icon,
    required Color color,
    required VoidCallback onPressed,
    required double size,
    String? label,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: size,
        width: label != null ? size * 1.3 : size,
        decoration: BoxDecoration(
          color: color.withOpacity(0.12),
          borderRadius: BorderRadius.circular(label != null ? 16 : 50),
          border: Border.all(color: color, width: 2),
        ),
        child: Center(
          child: label != null
              ? Text(
                  label,
                  style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                )
              : Icon(icon, color: color, size: size * 0.48),
        ),
      ),
    );
  }
}
