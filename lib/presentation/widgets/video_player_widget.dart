import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'video_player_stub_view.dart'
    if (dart.library.html) 'video_player_html_view.dart' as platform_view;

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
  VideoPlayerController? _controller;
  bool _initialized = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    if (!kIsWeb) {
      _initializeNativeController();
    }
  }

  @override
  void didUpdateWidget(covariant VideoPlayerWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.assetPath != widget.assetPath) {
      if (!kIsWeb) {
        if (_initialized && _controller != null) {
          _controller!.dispose();
        }
        _initialized = false;
        _initializeNativeController();
      }
    }
  }

  Future<void> _initializeNativeController() async {
    final cleanPath = widget.assetPath.replaceFirst(RegExp(r'^/+'), '');
    final pathWithoutAssets = cleanPath.replaceFirst(RegExp(r'^assets/'), '');
    final canonicalAssetPath = 'assets/$pathWithoutAssets';

    try {
      final controller = VideoPlayerController.asset(
        canonicalAssetPath,
        videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
      );
      await controller.initialize();
      await controller.setLooping(true);
      await controller.setVolume(0.0);

      if (!mounted) {
        await controller.dispose();
        return;
      }

      _controller = controller;
      setState(() {
        _initialized = true;
        _error = null;
      });

      try {
        await _controller!.play();
      } catch (_) {}
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = e.toString();
        });
      }
    }
  }

  @override
  void dispose() {
    if (_initialized && _controller != null) {
      _controller!.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 1. En Web, utilizamos el reproductor DOM HTML5 nativo:
    // Máxima compatibilidad con Chrome, Safari iOS, Edge, autoplay silenciado instantáneo y sin límites de texturas WebGL
    if (kIsWeb) {
      return platform_view.buildPlatformVideoView(
        assetPath: widget.assetPath,
        height: widget.height,
      );
    }

    // 2. En Móvil / Desktop nativo:
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

    if (!_initialized || _controller == null) {
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
          aspectRatio: _controller!.value.aspectRatio,
          child: VideoPlayer(_controller!),
        ),
      ),
    );
  }
}
