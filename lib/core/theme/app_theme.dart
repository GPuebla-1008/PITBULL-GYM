import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Ajustado para coincidir exactamente con el fondo de logo.png (#363B3E)
  static const Color charcoalBackground = Color(0xFF363B3E);
  static const Color goldAccent = Color(0xFFFFB300);
  static const Color deepBlack = Color(0xFF000000);
  static const Color warmGrey = Color(0xFF424242);
  static const Color electricOrange = Color(0xFFFF8C00);

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: charcoalBackground,
    primaryColor: goldAccent,
    colorScheme: ColorScheme.dark(
      primary: goldAccent,
      secondary: goldAccent,
      surface: warmGrey,
      onPrimary: Colors.black,
      onSurface: Colors.white70,
    ),
    textTheme: GoogleFonts.outfitTextTheme(ThemeData.dark().textTheme).copyWith(
      displayLarge: GoogleFonts.outfit(
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      bodyLarge: GoogleFonts.inter(color: Colors.white70),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: deepBlack,
      elevation: 0,
      titleTextStyle: GoogleFonts.outfit(
        fontWeight: FontWeight.bold,
        fontSize: 20,
        color: goldAccent,
      ),
      iconTheme: IconThemeData(color: goldAccent),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: goldAccent,
        foregroundColor: Colors.black,
        textStyle: GoogleFonts.outfit(fontWeight: FontWeight.bold),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 10,
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      ),
    ),
    cardTheme: CardThemeData(
      color: warmGrey,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.black26,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: goldAccent, width: 2),
      ),
      labelStyle: TextStyle(color: goldAccent.withOpacity(0.7)),
    ),
  );

  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: goldAccent,
    scaffoldBackgroundColor: Colors.white,
    colorScheme: ColorScheme.light(
      primary: goldAccent,
      secondary: goldAccent,
      surface: Colors.grey[100]!,
      onPrimary: Colors.black,
      onSurface: Colors.black87,
    ),
    textTheme: GoogleFonts.outfitTextTheme(ThemeData.light().textTheme),
  );
}
