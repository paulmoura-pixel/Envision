import 'package:flutter/material.dart';

final ValueNotifier<bool> appLightMode = ValueNotifier(false);

void toggleAppTheme() {
  appLightMode.value = !appLightMode.value;
}

/// Envision design tokens.
class EC {
  static bool isLight = false;

  static const orange = Color(0xFFB8F238);
  static Color get orangeDeep =>
      isLight ? const Color(0xFF587A08) : const Color(0xFF9BD41E);
  static Color get orangeTint =>
      isLight ? const Color(0xFFF0F8D9) : const Color(0xFF263315);
  static Color get bg =>
      isLight ? const Color(0xFFF5F5F7) : const Color(0xFF0B0D0C);
  static Color get card =>
      isLight ? const Color(0xFFFFFFFF) : const Color(0xFF151816);
  static Color get card2 =>
      isLight ? const Color(0xFFF9F9F9) : const Color(0xFF1B1F1C);
  static Color get text =>
      isLight ? const Color(0xFF111111) : const Color(0xFFF4F6F1);
  static Color get text2 =>
      isLight ? const Color(0xFF636366) : const Color(0xFF929A92);
  static Color get border =>
      isLight ? const Color(0xFFE5E5EA) : const Color(0xFF292E2A);
  static Color get workoutBorder =>
      isLight ? const Color(0xFFDDE8BF) : const Color(0xFFFBD9C6);
  static Color get workoutText =>
      isLight ? const Color(0xFF636366) : const Color(0xFF8A5A44);
  static const green = Color(0xFF66D68B);
  static const red = Color(0xFFFF715B);

  // Macro accents (kept warm, no neon).
  static const protein = Color(0xFFFF715B);
  static const carbs = Color(0xFFF4C95D);
  static const fat = Color(0xFF6CA8FF);

  static const r = 18.0; // card radius
  static const pad = 20.0; // screen side padding

  static List<BoxShadow> get shadow => [
        BoxShadow(
          color: Colors.black.withOpacity(isLight ? 0.04 : 0.28),
          blurRadius: isLight ? 8 : 26,
          offset: Offset(0, isLight ? 2 : 12),
        ),
      ];
}

ThemeData buildTheme() {
  final brightness = EC.isLight ? Brightness.light : Brightness.dark;
  final base = ThemeData(
    useMaterial3: true,
    brightness: brightness,
    scaffoldBackgroundColor: EC.bg,
    colorScheme: ColorScheme.fromSeed(
      seedColor: EC.orange,
      primary: EC.orange,
      surface: EC.bg,
      brightness: brightness,
    ),
  );
  return base.copyWith(
    textTheme: base.textTheme.apply(
      bodyColor: EC.text,
      displayColor: EC.text,
    ),
    dividerColor: EC.border,
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: TextStyle(color: EC.text2),
      hintStyle: TextStyle(color: EC.text2),
    ),
  );
}

TextStyle ts(double size,
        {FontWeight w = FontWeight.w500,
        Color? color,
        double? h,
        double? ls}) =>
    TextStyle(
        fontSize: size,
        fontWeight: w,
        color: color ?? EC.text,
        height: h,
        letterSpacing: ls);
