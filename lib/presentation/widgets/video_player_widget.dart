import 'package:flutter/foundation.dart';
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
    // 1. Normalizar la ruta eliminando barras iniciales y cualquier duplicación de assets/
    final cleanPath = widget.assetPath.replaceFirst(RegExp(r'^/+'), '');
    final pathWithoutAssets = cleanPath.replaceFirst(RegExp(r'^assets/'), '');
    final canonicalAssetPath = 'assets/$pathWithoutAssets';

    // 2. Definir estrategias de carga limpias sin duplicar assets/
    final List<Future<VideoPlayerController> Function()> strategies = [];

    if (kIsWeb) {
      // En Web:
      // A) VideoPlayerController.networkUrl con URL codificada canónica (ej. 'assets/RUTINAS/...mp4')
      strategies.add(() async => VideoPlayerController.networkUrl(
            Uri.parse(Uri.encodeFull(canonicalAssetPath)),
            videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
          ));

      // B) VideoPlayerController.networkUrl con URL codificada relativa (ej. 'RUTINAS/...mp4')
      strategies.add(() async => VideoPlayerController.networkUrl(
            Uri.parse(Uri.encodeFull(pathWithoutAssets)),
            videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
          ));

      // C) VideoPlayerController.asset pasando la ruta relativa limpia
      // (Flutter Web internamente le agrega un único 'assets/', quedando 'assets/RUTINAS/...')
      strategies.add(() async => VideoPlayerController.asset(
            pathWithoutAssets,
            videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
          ));
    } else {
      // En Mobile / Desktop:
      strategies.add(() async => VideoPlayerController.asset(
            canonicalAssetPath,
            videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
          ));
      strategies.add(() async => VideoPlayerController.asset(
            pathWithoutAssets,
            videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
          ));
    }

    Object? lastError;

    for (final strategy in strategies) {
      try {
        final controller = await strategy();
        await controller.initialize();
        await controller.setLooping(true);
        await controller.setVolume(0.0); // Muted para permitir autoplay en navegadores

        if (!mounted) {
          await controller.dispose();
          return;
        }

        _controller = controller;
        setState(() {
          _initialized = true;
          _error = null;
        });

        // Iniciar reproducción
        try {
          await _controller.play();
        } catch (playErr) {
          debugPrint("Autoplay note for '${widget.assetPath}': $playErr");
        }

        return; // Éxito
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
