import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:math' as math;

class RotatingPWAIcon extends StatefulWidget {
  final String svgPath;
  final double size;
  final Color color;

  const RotatingPWAIcon({
    super.key,
    required this.svgPath,
    this.size = 40,
    required this.color,
  });

  @override
  State<RotatingPWAIcon> createState() => _RotatingPWAIconState();
}

class _RotatingPWAIconState extends State<RotatingPWAIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _rotationAnimation;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    // Animación de ida y vuelta: 0 -> 15 grados -> 0
    _rotationAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(
          begin: 0.0,
          end: 15.0 * math.pi / 180.0,
        ).chain(CurveTween(curve: Curves.easeOut)),
        weight: 50,
      ),
      TweenSequenceItem(
        tween: Tween<double>(
          begin: 15.0 * math.pi / 180.0,
          end: 0.0,
        ).chain(CurveTween(curve: Curves.easeIn)),
        weight: 50,
      ),
    ]).animate(_controller);
  }

  void _triggerAnimation() {
    if (!_controller.isAnimating) {
      _controller.forward(from: 0.0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() => _isHovered = true);
        _triggerAnimation();
      },
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: () => _triggerAnimation(),
        child: AnimatedBuilder(
          animation: _rotationAnimation,
          builder: (context, child) {
            return Transform.rotate(
              angle: _rotationAnimation.value,
              child: SvgPicture.asset(
                widget.svgPath,
                width: widget.size,
                height: widget.size,
                colorFilter: ColorFilter.mode(widget.color, BlendMode.srcIn),
              ),
            );
          },
        ),
      ),
    );
  }
}
