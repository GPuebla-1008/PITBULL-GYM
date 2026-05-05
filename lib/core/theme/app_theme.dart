import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Ajustado para coincidir exactamente con el fondo de logo.jpeg (#3F3E40)
  static const Color charcoalBackground = Color(0xFF3F3E40);
  static const Color goldAccent = Color(0xFFFFB300);
  static const Color deepBlack = Color(0xFF000000);
  static const Color warmGrey = Color(0xFF424242);
  static const Color electricOrange = Color(0xFFFF8C00);

  // MODO CLARO: El antiguo modo oscuro (Fondo Charcoal #3F3E40, letras blancas/grises, detalles amarillos)
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.dark, // Usamos dark para que las letras por defecto sean blancas
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
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
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

  // MODO OSCURO: Fondo completamente negro (#000000), letras y detalles en amarillo (goldAccent)
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: deepBlack,
    primaryColor: goldAccent,
    colorScheme: ColorScheme.dark(
      primary: goldAccent,
      secondary: goldAccent,
      surface: deepBlack,
      onPrimary: Colors.black, // Como solicitó el usuario, botones amarillos con texto negro
      onSurface: goldAccent,
    ),
    textTheme: GoogleFonts.outfitTextTheme(ThemeData.dark().textTheme).copyWith(
      displayLarge: GoogleFonts.outfit(
        fontWeight: FontWeight.bold,
        color: goldAccent,
      ),
      displayMedium: GoogleFonts.outfit(color: goldAccent),
      displaySmall: GoogleFonts.outfit(color: goldAccent),
      headlineLarge: GoogleFonts.outfit(color: goldAccent),
      headlineMedium: GoogleFonts.outfit(color: goldAccent),
      headlineSmall: GoogleFonts.outfit(color: goldAccent),
      titleLarge: GoogleFonts.outfit(color: goldAccent),
      titleMedium: GoogleFonts.outfit(color: goldAccent),
      titleSmall: GoogleFonts.outfit(color: goldAccent),
      bodyLarge: GoogleFonts.inter(color: goldAccent),
      bodyMedium: GoogleFonts.inter(color: goldAccent),
      bodySmall: GoogleFonts.inter(color: goldAccent),
      labelLarge: GoogleFonts.inter(color: goldAccent),
      labelMedium: GoogleFonts.inter(color: goldAccent),
      labelSmall: GoogleFonts.inter(color: goldAccent),
    ).apply(
      bodyColor: goldAccent,
      displayColor: goldAccent,
    ),
    iconTheme: IconThemeData(color: goldAccent),
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
        foregroundColor: Colors.black, // Botones con fondo amarillo y texto negro
        textStyle: GoogleFonts.outfit(fontWeight: FontWeight.bold),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
        ),
        elevation: 10,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: goldAccent,
        side: BorderSide(color: goldAccent, width: 2),
        textStyle: GoogleFonts.outfit(fontWeight: FontWeight.bold),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
    ),
    cardTheme: CardThemeData(
      color: deepBlack,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: goldAccent.withOpacity(0.5), width: 1.5),
      ),
      elevation: 4,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: deepBlack,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: goldAccent.withOpacity(0.5), width: 1),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: goldAccent.withOpacity(0.5), width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: goldAccent, width: 2),
      ),
      labelStyle: TextStyle(color: goldAccent),
      hintStyle: TextStyle(color: goldAccent.withOpacity(0.5)),
      prefixIconColor: goldAccent,
      suffixIconColor: goldAccent,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: deepBlack,
      selectedItemColor: goldAccent,
      unselectedItemColor: goldAccent.withOpacity(0.5),
    ),
  );
}
