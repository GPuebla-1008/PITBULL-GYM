import 'dart:io';
import 'package:image/image.dart' as img;

void main() {
  final originalFile = File(r'C:\Users\gerar\.gemini\antigravity\brain\1bffcad3-20d2-450c-afed-0b6bf545ec81\media__1774598939616.png');
  final image = img.decodeImage(originalFile.readAsBytesSync());
  if (image == null) return;
  
  // Get the background color from top-left pixel
  final bgColor = image.getPixel(0, 0);
  final rBg = bgColor.r;
  final gBg = bgColor.g;
  final bBg = bgColor.b;

  // Make the background transparent with a simple tolerance
  // This will process the whole image and make the gray transparent
  final transparentImage = img.copyResize(image, width: image.width, height: image.height); // Create a copy
  
  for (int y = 0; y < transparentImage.height; y++) {
    for (int x = 0; x < transparentImage.width; x++) {
      final p = transparentImage.getPixel(x, y);
      final rSrc = p.r;
      final gSrc = p.g;
      final bSrc = p.b;
      
      final dist = (rSrc - rBg).abs() + (gSrc - gBg).abs() + (bSrc - bBg).abs();
      if (dist < 30 || (x >= 390 && x <= 400)) { 
        p.setRgba(rSrc, gSrc, bSrc, 0); // Transparent 
      }
    }
  }

  // Save the new contacts image
  final contactOutput = File(r'c:\Users\gerar\OneDrive\Escritorio\PITBULL GYM2\assets\images\contacts.png');
  contactOutput.writeAsBytesSync(img.encodePng(transparentImage));
  print('Done contacts.');
}
