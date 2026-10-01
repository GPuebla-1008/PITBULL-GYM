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
      if (_initialized) {
        _controller.dispose();
      }
      _initialized = false;
      _initializeController();
    }
  }

  Future<void> _initializeController() async {
    final cleanPath = widget.assetPath.startsWith('/')
        ? widget.assetPath.substring(1)
        : widget.assetPath;

    // Build candidates for asset / web loading
    final List<Future<VideoPlayerController> Function()> strategies = [
      () async => VideoPlayerController.asset(
            cleanPath,
            videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
          ),
      () async => VideoPlayerController.networkUrl(
            Uri.parse(cleanPath),
            videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
          ),
      () async => VideoPlayerController.networkUrl(
            Uri.parse('assets/$cleanPath'),
            videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
          ),
      () async => VideoPlayerController.networkUrl(
            Uri.parse('assets/assets/${cleanPath.replaceFirst('assets/', '')}'),
            videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
          ),
    ];

    Object? lastError;

    for (final strategy in strategies) {
      try {
        final controller = await strategy();
        await controller.initialize();
        await controller.setLooping(true);
        await controller.setVolume(0.0); // Muted for autoplay compatibility

        if (!mounted) {
          await controller.dispose();
          return;
        }

        _controller = controller;
        setState(() {
          _initialized = true;
          _error = null;
        });

        // Safely initiate playback
        try {
          await _controller.play();
        } catch (playErr) {
          debugPrint("Autoplay note for '${widget.assetPath}': $playErr");
        }

        return; // Successfully initialized
      } catch (e) {
        lastError = e;
        debugPrint("Strategy attempt failed for '${widget.assetPath}': $e");
      }
    }

    if (mounted) {
      setState(() {
        _error = lastError?.toString() ?? 'Error al cargar video';
      });
    }
  }

  @override
  void dispose() {
    if (_initialized) {
      _controller.dispose();
    }
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
