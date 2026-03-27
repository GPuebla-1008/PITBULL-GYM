class ValidationService {
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) return 'El email es obligatorio';
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) return 'Ingresa un email válido';
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'La contraseña es obligatoria';
    if (value.length < 6) return 'Debe tener al menos 6 caracteres';
    return null;
  }

  static String? validateNumeric(String? value, String fieldName) {
    if (value == null || value.isEmpty) return '$fieldName es obligatorio';
    if (double.tryParse(value) == null) return '$fieldName debe ser un número';
    return null;
  }

  static String sanitizeString(String value) {
    // Basic sanitization to prevent common injection characters
    return value.replaceAll(RegExp(r"[<>{}\[\]\\/']"), '').trim();
  }
}
