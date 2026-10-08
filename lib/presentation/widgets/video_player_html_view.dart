// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;
import 'dart:ui_web' as ui_web;
import 'package:flutter/material.dart';

Widget buildPlatformVideoView({
  required String assetPath,
  double? height,
}) {
  return HtmlVideoPlayer(assetPath: assetPath, height: height);
}

class HtmlVideoPlayer extends StatefulWidget {
  final String assetPath;
  final double? height;

  const HtmlVideoPlayer({
    super.key,
    required this.assetPath,
    this.height,
  });

  @override
  State<HtmlVideoPlayer> createState() => _HtmlVideoPlayerState();
}

class _HtmlVideoPlayerState extends State<HtmlVideoPlayer> {
  late String _viewId;
  html.VideoElement? _videoElement;

  @override
  void initState() {
    super.initState();
    _initVideo();
  }

  void _initVideo() {
    final cleanPath = widget.assetPath.replaceFirst(RegExp(r'^/+'), '');
    final pathWithoutAssets = cleanPath.replaceFirst(RegExp(r'^assets/'), '');
    final canonicalAssetPath = 'assets/$pathWithoutAssets';

    _viewId = 'video-dom-${canonicalAssetPath.hashCode}-${DateTime.now().microsecondsSinceEpoch}';

    final video = html.VideoElement()
      ..autoplay = true
      ..loop = true
      ..muted = true
      ..setAttribute('playsinline', 'true')
      ..setAttribute('webkit-playsinline', 'true')
      ..setAttribute('muted', 'true')
      ..setAttribute('controlslist', 'nodownload nofullscreen noremoteplayback')
      ..setAttribute('disablePictureInPicture', 'true')
      ..style.width = '100%'
      ..style.height = '100%'
      ..style.objectFit = 'contain'
      ..style.backgroundColor = 'black'
      ..style.border = 'none'
      ..style.outline = 'none';

    // Lista de candidatos de URL con fallback dinámico
    final candidates = [
      Uri.encodeFull(canonicalAssetPath),
      Uri.encodeFull(pathWithoutAssets),
      Uri.encodeFull('assets/assets/$pathWithoutAssets'),
    ];

    int candidateIdx = 0;
    video.src = candidates[0];

    video.onError.listen((_) {
      candidateIdx++;
      if (candidateIdx < candidates.length) {
        video.src = candidates[candidateIdx];
        video.load();
        video.play().catchError((_) {});
      }
    });

    video.load();
    video.play().catchError((_) {});

    _videoElement = video;

    ui_web.platformViewRegistry.registerViewFactory(
      _viewId,
      (int viewId) => _videoElement!,
    );
  }

  @override
  void didUpdateWidget(covariant HtmlVideoPlayer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.assetPath != widget.assetPath) {
      _initVideo();
      setState(() {});
    }
  }

  @override
  void dispose() {
    _videoElement?.pause();
    _videoElement?.src = '';
    _videoElement?.remove();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      color: Colors.black,
      child: HtmlElementView(
        key: ValueKey(_viewId),
        viewType: _viewId,
      ),
    );
  }
}
