import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatefulWidget {
  final String assetPath;
  final double? height;

  const VideoPlayerWidget({
    super.key,
    required this.assetPath,
    this.height,
  });

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _controller;
  bool _initialized = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _initializeController();
  }

  @override
  void didUpdateWidget(covariant VideoPlayerWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.assetPath != widget.assetPath) {
      _controller.dispose();
      _initialized = false;
      _initializeController();
    }
  }

  Future<void> _initializeController() async {
    _controller = VideoPlayerController.asset(widget.assetPath);
    try {
      await _controller.initialize();
      await _controller.setLooping(true);
      await _controller.setVolume(0.0); // Silenciado como un GIF
      if (mounted) {
        setState(() {
          _initialized = true;
        });
        _controller.play();
      }
    } catch (e) {
      debugPrint("Error al inicializar el video '${widget.assetPath}': $e");
      if (mounted) {
        setState(() {
          _error = e.toString();
        });
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_error != null) {
      return Container(
        height: widget.height,
        color: Colors.black12,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, color: Colors.redAccent, size: 36),
              const SizedBox(height: 8),
              Text(
                'No se pudo reproducir el video',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      );
    }

    if (!_initialized) {
      return Container(
        height: widget.height,
        color: Colors.black12,
        child: const Center(
          child: SizedBox(
            width: 30,
            height: 30,
            child: CircularProgressIndicator(strokeWidth: 2, color: Colors.amber),
          ),
        ),
      );
    }

    return Container(
      height: widget.height,
      color: Colors.black,
      child: Center(
        child: AspectRatio(
          aspectRatio: _controller.value.aspectRatio,
          child: VideoPlayer(_controller),
        ),
      ),
    );
  }
}
