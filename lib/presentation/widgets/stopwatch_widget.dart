import 'dart:async';
import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

class StopwatchWidget extends StatefulWidget {
  @override
  _StopwatchWidgetState createState() => _StopwatchWidgetState();
}

class _StopwatchWidgetState extends State<StopwatchWidget> {
  final Stopwatch _stopwatch = Stopwatch();
  Timer? _timer;

  void _startStopwatch() {
    setState(() {
      if (_stopwatch.isRunning) {
        _stopwatch.stop();
        _timer?.cancel();
      } else {
        _stopwatch.start();
        _timer = Timer.periodic(Duration(milliseconds: 30), (timer) {
          setState(() {});
        });
      }
    });
  }

  void _resetStopwatch() {
    setState(() {
      _stopwatch.reset();
      if (!_stopwatch.isRunning) {
        _timer?.cancel();
      }
    });
  }

  String _formatTime() {
    final duration = _stopwatch.elapsed;
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    final milliseconds = twoDigits((duration.inMilliseconds.remainder(1000) ~/ 10));
    return '$minutes:$seconds:$milliseconds';
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenW = MediaQuery.of(context).size.width;
    // Scale font size based on screen width: small phones get smaller text
    final timerFontSize = (screenW * 0.11).clamp(28.0, 52.0);
    final labelFontSize = (screenW * 0.03).clamp(10.0, 13.0);
    final buttonSize = (screenW * 0.12).clamp(40.0, 56.0);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: screenW < 380 ? 12 : 20,
        vertical: screenW < 380 ? 14 : 20,
      ),
      decoration: BoxDecoration(
        color: AppTheme.warmGrey,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppTheme.goldAccent.withOpacity(0.3), width: 1),
        boxShadow: [
          BoxShadow(
            color: AppTheme.goldAccent.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'TIEMPO DE CLASE',
            style: TextStyle(
              color: AppTheme.goldAccent,
              letterSpacing: 2,
              fontWeight: FontWeight.bold,
              fontSize: labelFontSize,
            ),
          ),
          const SizedBox(height: 8),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              _formatTime(),
              style: TextStyle(
                fontSize: timerFontSize,
                fontFamily: 'Courier',
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildButton(
                icon: _stopwatch.isRunning ? Icons.pause : Icons.play_arrow,
                color: _stopwatch.isRunning ? AppTheme.electricOrange : AppTheme.goldAccent,
                onPressed: _startStopwatch,
                size: buttonSize,
              ),
              SizedBox(width: screenW < 380 ? 14 : 20),
              _buildButton(
                icon: Icons.refresh,
                color: Colors.white,
                onPressed: _resetStopwatch,
                size: buttonSize,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildButton({
    required IconData icon,
    required Color color,
    required VoidCallback onPressed,
    required double size,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: size,
        width: size,
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          shape: BoxShape.circle,
          border: Border.all(color: color, width: 2),
        ),
        child: Icon(icon, color: color, size: size * 0.48),
      ),
    );
  }
}
