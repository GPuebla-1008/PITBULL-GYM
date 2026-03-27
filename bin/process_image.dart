import 'dart:io';
import 'package:image/image.dart' as img;

void main() {
  // Load original image
  final originalFile = File(r'C:\Users\gerar\.gemini\antigravity\brain\1bffcad3-20d2-450c-afed-0b6bf545ec81\media__1774598939616.png');
  if (!originalFile.existsSync()) {
    print('Original file not found.');
    return;
  }
  
  final image = img.decodeImage(originalFile.readAsBytesSync());
  if (image == null) return;
  
  print('Image size: ${image.width}x${image.height}');
  
  // The user wants "solamente el logo", which is on the left half. Let's crop it.
  // We'll crop a square from the left.
  final cropSize = image.height; 
  final cropped = img.copyCrop(image, x: 0, y: 0, width: 390, height: cropSize);
  
  // Get the background color from top-left pixel
  final bgColor = cropped.getPixel(0, 0);
  final rBg = bgColor.r;
  final gBg = bgColor.g;
  final bBg = bgColor.b;
  print('Background rgb: $rBg, $gBg, $bBg');
  
  // Make the background transparent with a simple tolerance
  // We'll calculate distance. If it's close to the bg color, set alpha to 0.
  for (int y = 0; y < cropped.height; y++) {
    for (int x = 0; x < cropped.width; x++) {
      final p = cropped.getPixel(x, y);
      final rSrc = p.r;
      final gSrc = p.g;
      final bSrc = p.b;
      
      final dist = (rSrc - rBg).abs() + (gSrc - gBg).abs() + (bSrc - bBg).abs();
      if (dist < 40) { // Tolerance
        p.setRgba(rSrc, gSrc, bSrc, 0); // Transparent
      }
    }
  }

  // Save the new image
  final output = File(r'c:\Users\gerar\OneDrive\Escritorio\PITBULL GYM2\assets\images\logo.png');
  output.createSync(recursive: true);
  output.writeAsBytesSync(img.encodePng(cropped));
  print('Done.');
}
