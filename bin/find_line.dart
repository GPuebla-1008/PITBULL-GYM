import 'dart:io';
import 'package:image/image.dart' as img;

void main() {
  final originalFile = File(
    r'C:\Users\gerar\.gemini\antigravity\brain\1bffcad3-20d2-450c-afed-0b6bf545ec81\media__1774598939616.png',
  );
  final image = img.decodeImage(originalFile.readAsBytesSync());
  if (image == null) return;

  for (int x = 200; x < 600; x++) {
    int blackCount = 0;
    for (int y = 0; y < image.height; y++) {
      final p = image.getPixel(x, y);
      if (p.r < 30 && p.g < 30 && p.b < 30) {
        blackCount++;
      }
    }
    if (blackCount > image.height * 0.9) {
      print('Found black line at x=$x (count=$blackCount)');
    }
  }
}
