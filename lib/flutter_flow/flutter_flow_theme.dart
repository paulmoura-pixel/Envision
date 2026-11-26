// ignore_for_file: overridden_fields, annotate_overrides

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:shared_preferences/shared_preferences.dart';

const kThemeModeKey = '__theme_mode__';

SharedPreferences? _prefs;

abstract class FlutterFlowTheme {
  static Future initialize() async =>
      _prefs = await SharedPreferences.getInstance();

  static ThemeMode get themeMode {
    final darkMode = _prefs?.getBool(kThemeModeKey);
    return darkMode == null
        ? ThemeMode.system
        : darkMode
            ? ThemeMode.dark
            : ThemeMode.light;
  }

  static void saveThemeMode(ThemeMode mode) => mode == ThemeMode.system
      ? _prefs?.remove(kThemeModeKey)
      : _prefs?.setBool(kThemeModeKey, mode == ThemeMode.dark);

  static FlutterFlowTheme of(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? DarkModeTheme()
        : LightModeTheme();
  }

  @Deprecated('Use primary instead')
  Color get primaryColor => primary;
  @Deprecated('Use secondary instead')
  Color get secondaryColor => secondary;
  @Deprecated('Use tertiary instead')
  Color get tertiaryColor => tertiary;

  late Color primary;
  late Color secondary;
  late Color tertiary;
  late Color alternate;
  late Color primaryText;
  late Color secondaryText;
  late Color primaryBackground;
  late Color secondaryBackground;
  late Color accent1;
  late Color accent2;
  late Color accent3;
  late Color accent4;
  late Color success;
  late Color warning;
  late Color error;
  late Color info;

  late Color night;
  late Color nightCard;
  late Color nightCardRaised;
  late Color nightBorder;
  late Color nightText;
  late Color nightMuted;
  late Color lime;
  late Color limeDeep;
  late Color limeWash;
  late Color canvasLight;
  late Color surfaceLight;
  late Color surfaceSubtle;
  late Color onPrimary;
  late Color primaryContainer;
  late Color onPrimaryContainer;
  late Color onSecondary;
  late Color secondaryContainer;
  late Color onSecondaryContainer;
  late Color onAccent;
  late Color accentContainer;
  late Color onAccentContainer;
  late Color onBackground;
  late Color onSurface;
  late Color surfaceVariant;
  late Color onSurfaceVariant;
  late Color onSuccess;
  late Color onWarning;
  late Color onError;
  late Color onInfo;
  late Color transparent;
  late Color fullContrast;

  FFDesignTokens get designToken => FFDesignTokens(this);

  @Deprecated('Use displaySmallFamily instead')
  String get title1Family => displaySmallFamily;
  @Deprecated('Use displaySmall instead')
  TextStyle get title1 => typography.displaySmall;
  @Deprecated('Use headlineMediumFamily instead')
  String get title2Family => typography.headlineMediumFamily;
  @Deprecated('Use headlineMedium instead')
  TextStyle get title2 => typography.headlineMedium;
  @Deprecated('Use headlineSmallFamily instead')
  String get title3Family => typography.headlineSmallFamily;
  @Deprecated('Use headlineSmall instead')
  TextStyle get title3 => typography.headlineSmall;
  @Deprecated('Use titleMediumFamily instead')
  String get subtitle1Family => typography.titleMediumFamily;
  @Deprecated('Use titleMedium instead')
  TextStyle get subtitle1 => typography.titleMedium;
  @Deprecated('Use titleSmallFamily instead')
  String get subtitle2Family => typography.titleSmallFamily;
  @Deprecated('Use titleSmall instead')
  TextStyle get subtitle2 => typography.titleSmall;
  @Deprecated('Use bodyMediumFamily instead')
  String get bodyText1Family => typography.bodyMediumFamily;
  @Deprecated('Use bodyMedium instead')
  TextStyle get bodyText1 => typography.bodyMedium;
  @Deprecated('Use bodySmallFamily instead')
  String get bodyText2Family => typography.bodySmallFamily;
  @Deprecated('Use bodySmall instead')
  TextStyle get bodyText2 => typography.bodySmall;

  String get displayLargeFamily => typography.displayLargeFamily;
  bool get displayLargeIsCustom => typography.displayLargeIsCustom;
  TextStyle get displayLarge => typography.displayLarge;
  String get displayMediumFamily => typography.displayMediumFamily;
  bool get displayMediumIsCustom => typography.displayMediumIsCustom;
  TextStyle get displayMedium => typography.displayMedium;
  String get displaySmallFamily => typography.displaySmallFamily;
  bool get displaySmallIsCustom => typography.displaySmallIsCustom;
  TextStyle get displaySmall => typography.displaySmall;
  String get headlineLargeFamily => typography.headlineLargeFamily;
  bool get headlineLargeIsCustom => typography.headlineLargeIsCustom;
  TextStyle get headlineLarge => typography.headlineLarge;
  String get headlineMediumFamily => typography.headlineMediumFamily;
  bool get headlineMediumIsCustom => typography.headlineMediumIsCustom;
  TextStyle get headlineMedium => typography.headlineMedium;
  String get headlineSmallFamily => typography.headlineSmallFamily;
  bool get headlineSmallIsCustom => typography.headlineSmallIsCustom;
  TextStyle get headlineSmall => typography.headlineSmall;
  String get titleLargeFamily => typography.titleLargeFamily;
  bool get titleLargeIsCustom => typography.titleLargeIsCustom;
  TextStyle get titleLarge => typography.titleLarge;
  String get titleMediumFamily => typography.titleMediumFamily;
  bool get titleMediumIsCustom => typography.titleMediumIsCustom;
  TextStyle get titleMedium => typography.titleMedium;
  String get titleSmallFamily => typography.titleSmallFamily;
  bool get titleSmallIsCustom => typography.titleSmallIsCustom;
  TextStyle get titleSmall => typography.titleSmall;
  String get labelLargeFamily => typography.labelLargeFamily;
  bool get labelLargeIsCustom => typography.labelLargeIsCustom;
  TextStyle get labelLarge => typography.labelLarge;
  String get labelMediumFamily => typography.labelMediumFamily;
  bool get labelMediumIsCustom => typography.labelMediumIsCustom;
  TextStyle get labelMedium => typography.labelMedium;
  String get labelSmallFamily => typography.labelSmallFamily;
  bool get labelSmallIsCustom => typography.labelSmallIsCustom;
  TextStyle get labelSmall => typography.labelSmall;
  String get bodyLargeFamily => typography.bodyLargeFamily;
  bool get bodyLargeIsCustom => typography.bodyLargeIsCustom;
  TextStyle get bodyLarge => typography.bodyLarge;
  String get bodyMediumFamily => typography.bodyMediumFamily;
  bool get bodyMediumIsCustom => typography.bodyMediumIsCustom;
  TextStyle get bodyMedium => typography.bodyMedium;
  String get bodySmallFamily => typography.bodySmallFamily;
  bool get bodySmallIsCustom => typography.bodySmallIsCustom;
  TextStyle get bodySmall => typography.bodySmall;

  Typography get typography => ThemeTypography(this);
}

class LightModeTheme extends FlutterFlowTheme {
  @Deprecated('Use primary instead')
  Color get primaryColor => primary;
  @Deprecated('Use secondary instead')
  Color get secondaryColor => secondary;
  @Deprecated('Use tertiary instead')
  Color get tertiaryColor => tertiary;

  late Color primary = const Color(0xFFFF6500);
  late Color secondary = const Color(0xFF0B0B0B);
  late Color tertiary = const Color(0xFF16A34A);
  late Color alternate = const Color(0xFFEEEEF0);
  late Color primaryText = const Color(0xFF0B0B0B);
  late Color secondaryText = const Color(0xFF85858D);
  late Color primaryBackground = const Color(0xFFFFFFFF);
  late Color secondaryBackground = const Color(0xFFFFFFFF);
  late Color accent1 = const Color(0xFFF0F8D9);
  late Color accent2 = const Color(0xFFF9F9F9);
  late Color accent3 = const Color(0xFFAEAEB2);
  late Color accent4 = const Color(0xCCFFFFFF);
  late Color success = const Color(0xFF16A34A);
  late Color warning = const Color(0xFFF59E0B);
  late Color error = const Color(0xFFEF4444);
  late Color info = const Color(0xFF3B82F6);

  late Color night = const Color(0xFF0B0D0C);
  late Color nightCard = const Color(0xFF151816);
  late Color nightCardRaised = const Color(0xFF1B1F1C);
  late Color nightBorder = const Color(0xFF292E2A);
  late Color nightText = const Color(0xFFF4F6F1);
  late Color nightMuted = const Color(0xFF929A92);
  late Color lime = const Color(0xFFB8F238);
  late Color limeDeep = const Color(0xFF587A08);
  late Color limeWash = const Color(0xFFF0F8D9);
  late Color canvasLight = const Color(0xFFF5F5F7);
  late Color surfaceLight = const Color(0xFFFFFFFF);
  late Color surfaceSubtle = const Color(0xFFF9F9F9);
  late Color onPrimary = const Color(0xFFFFFFFF);
  late Color primaryContainer = const Color(0x1AFF6500);
  late Color onPrimaryContainer = const Color(0xFF0B0B0B);
  late Color onSecondary = const Color(0xFFFFFFFF);
  late Color secondaryContainer = const Color(0x1A0B0B0B);
  late Color onSecondaryContainer = const Color(0xFF0B0B0B);
  late Color onAccent = const Color(0xFFFFFFFF);
  late Color accentContainer = const Color(0x1A16A34A);
  late Color onAccentContainer = const Color(0xFF0B0B0B);
  late Color onBackground = const Color(0xFF0B0B0B);
  late Color onSurface = const Color(0xFF0B0B0B);
  late Color surfaceVariant = const Color(0xFFFFF1E8);
  late Color onSurfaceVariant = const Color(0xFF85858D);
  late Color onSuccess = const Color(0xFFFFFFFF);
  late Color onWarning = const Color(0xFFFFFFFF);
  late Color onError = const Color(0xFFFFFFFF);
  late Color onInfo = const Color(0xFFFFFFFF);
  late Color transparent = const Color(0x00000000);
  late Color fullContrast = const Color(0xFF000000);
}

abstract class Typography {
  String get displayLargeFamily;
  bool get displayLargeIsCustom;
  TextStyle get displayLarge;
  String get displayMediumFamily;
  bool get displayMediumIsCustom;
  TextStyle get displayMedium;
  String get displaySmallFamily;
  bool get displaySmallIsCustom;
  TextStyle get displaySmall;
  String get headlineLargeFamily;
  bool get headlineLargeIsCustom;
  TextStyle get headlineLarge;
  String get headlineMediumFamily;
  bool get headlineMediumIsCustom;
  TextStyle get headlineMedium;
  String get headlineSmallFamily;
  bool get headlineSmallIsCustom;
  TextStyle get headlineSmall;
  String get titleLargeFamily;
  bool get titleLargeIsCustom;
  TextStyle get titleLarge;
  String get titleMediumFamily;
  bool get titleMediumIsCustom;
  TextStyle get titleMedium;
  String get titleSmallFamily;
  bool get titleSmallIsCustom;
  TextStyle get titleSmall;
  String get labelLargeFamily;
  bool get labelLargeIsCustom;
  TextStyle get labelLarge;
  String get labelMediumFamily;
  bool get labelMediumIsCustom;
  TextStyle get labelMedium;
  String get labelSmallFamily;
  bool get labelSmallIsCustom;
  TextStyle get labelSmall;
  String get bodyLargeFamily;
  bool get bodyLargeIsCustom;
  TextStyle get bodyLarge;
  String get bodyMediumFamily;
  bool get bodyMediumIsCustom;
  TextStyle get bodyMedium;
  String get bodySmallFamily;
  bool get bodySmallIsCustom;
  TextStyle get bodySmall;
}

class ThemeTypography extends Typography {
  ThemeTypography(this.theme);

  final FlutterFlowTheme theme;

  String get displayLargeFamily => 'Outfit';
  bool get displayLargeIsCustom => false;
  TextStyle get displayLarge => GoogleFonts.outfit(
        color: theme.primaryText,
        fontWeight: FontWeight.w900,
        fontSize: 50.0,
        height: 1.05,
      );
  String get displayMediumFamily => 'Outfit';
  bool get displayMediumIsCustom => false;
  TextStyle get displayMedium => GoogleFonts.outfit(
        color: theme.primaryText,
        fontWeight: FontWeight.w900,
        fontSize: 46.0,
        height: 1.05,
      );
  String get displaySmallFamily => 'Outfit';
  bool get displaySmallIsCustom => false;
  TextStyle get displaySmall => GoogleFonts.outfit(
        color: theme.primaryText,
        fontWeight: FontWeight.w900,
        fontSize: 38.0,
        height: 1.1,
      );
  String get headlineLargeFamily => 'Outfit';
  bool get headlineLargeIsCustom => false;
  TextStyle get headlineLarge => GoogleFonts.outfit(
        color: theme.primaryText,
        fontWeight: FontWeight.w800,
        fontSize: 32.0,
        height: 1.2,
      );
  String get headlineMediumFamily => 'Outfit';
  bool get headlineMediumIsCustom => false;
  TextStyle get headlineMedium => GoogleFonts.outfit(
        color: theme.primaryText,
        fontWeight: FontWeight.w800,
        fontSize: 26.0,
        height: 1.2,
      );
  String get headlineSmallFamily => 'Outfit';
  bool get headlineSmallIsCustom => false;
  TextStyle get headlineSmall => GoogleFonts.outfit(
        color: theme.primaryText,
        fontWeight: FontWeight.bold,
        fontSize: 24.0,
        height: 1.2,
      );
  String get titleLargeFamily => 'Manrope';
  bool get titleLargeIsCustom => false;
  TextStyle get titleLarge => GoogleFonts.manrope(
        color: theme.primaryText,
        fontWeight: FontWeight.bold,
        fontSize: 22.0,
        height: 1.3,
      );
  String get titleMediumFamily => 'Manrope';
  bool get titleMediumIsCustom => false;
  TextStyle get titleMedium => GoogleFonts.manrope(
        color: theme.primaryText,
        fontWeight: FontWeight.bold,
        fontSize: 18.0,
        height: 1.3,
      );
  String get titleSmallFamily => 'Manrope';
  bool get titleSmallIsCustom => false;
  TextStyle get titleSmall => GoogleFonts.manrope(
        color: theme.primaryText,
        fontWeight: FontWeight.bold,
        fontSize: 16.0,
        height: 1.3,
      );
  String get labelLargeFamily => 'Manrope';
  bool get labelLargeIsCustom => false;
  TextStyle get labelLarge => GoogleFonts.manrope(
        color: theme.secondaryText,
        fontWeight: FontWeight.w600,
        fontSize: 15.0,
        height: 1.2,
      );
  String get labelMediumFamily => 'Manrope';
  bool get labelMediumIsCustom => false;
  TextStyle get labelMedium => GoogleFonts.manrope(
        color: theme.secondaryText,
        fontWeight: FontWeight.w600,
        fontSize: 13.0,
        height: 1.2,
      );
  String get labelSmallFamily => 'Manrope';
  bool get labelSmallIsCustom => false;
  TextStyle get labelSmall => GoogleFonts.manrope(
        color: theme.secondaryText,
        fontWeight: FontWeight.w600,
        fontSize: 11.0,
        height: 1.2,
      );
  String get bodyLargeFamily => 'Manrope';
  bool get bodyLargeIsCustom => false;
  TextStyle get bodyLarge => GoogleFonts.manrope(
        color: theme.primaryText,
        fontWeight: FontWeight.normal,
        fontSize: 16.0,
        height: 1.5,
      );
  String get bodyMediumFamily => 'Manrope';
  bool get bodyMediumIsCustom => false;
  TextStyle get bodyMedium => GoogleFonts.manrope(
        color: theme.primaryText,
        fontWeight: FontWeight.normal,
        fontSize: 15.0,
        height: 1.45,
      );
  String get bodySmallFamily => 'Manrope';
  bool get bodySmallIsCustom => false;
  TextStyle get bodySmall => GoogleFonts.manrope(
        color: theme.primaryText,
        fontWeight: FontWeight.normal,
        fontSize: 13.0,
        height: 1.4,
      );
}

class DarkModeTheme extends FlutterFlowTheme {
  @Deprecated('Use primary instead')
  Color get primaryColor => primary;
  @Deprecated('Use secondary instead')
  Color get secondaryColor => secondary;
  @Deprecated('Use tertiary instead')
  Color get tertiaryColor => tertiary;

  late Color primary = const Color(0xFFFF6500);
  late Color secondary = const Color(0xFFF7F7F8);
  late Color tertiary = const Color(0xFF22C55E);
  late Color alternate = const Color(0xFF2C2C2E);
  late Color primaryText = const Color(0xFFF7F7F8);
  late Color secondaryText = const Color(0xFF85858D);
  late Color primaryBackground = const Color(0xFF0B0B0B);
  late Color secondaryBackground = const Color(0xFF1C1C1E);
  late Color accent1 = const Color(0xFF263315);
  late Color accent2 = const Color(0xFF1B1F1C);
  late Color accent3 = const Color(0xFF48484A);
  late Color accent4 = const Color(0x1AFFFFFF);
  late Color success = const Color(0xFF22C55E);
  late Color warning = const Color(0xFFFBBF24);
  late Color error = const Color(0xFFF87171);
  late Color info = const Color(0xFF60A5FA);

  late Color night = const Color(0xFF0B0D0C);
  late Color nightCard = const Color(0xFF151816);
  late Color nightCardRaised = const Color(0xFF1B1F1C);
  late Color nightBorder = const Color(0xFF292E2A);
  late Color nightText = const Color(0xFFF4F6F1);
  late Color nightMuted = const Color(0xFF929A92);
  late Color lime = const Color(0xFFB8F238);
  late Color limeDeep = const Color(0xFF9BD41E);
  late Color limeWash = const Color(0xFF263315);
  late Color canvasLight = const Color(0xFF0B0D0C);
  late Color surfaceLight = const Color(0xFF151816);
  late Color surfaceSubtle = const Color(0xFF1B1F1C);
  late Color onPrimary = const Color(0xFFFFFFFF);
  late Color primaryContainer = const Color(0x24FF6500);
  late Color onPrimaryContainer = const Color(0xFFF7F7F8);
  late Color onSecondary = const Color(0xFF000000);
  late Color secondaryContainer = const Color(0x24F7F7F8);
  late Color onSecondaryContainer = const Color(0xFFF7F7F8);
  late Color onAccent = const Color(0xFFFFFFFF);
  late Color accentContainer = const Color(0x2422C55E);
  late Color onAccentContainer = const Color(0xFFF7F7F8);
  late Color onBackground = const Color(0xFFF7F7F8);
  late Color onSurface = const Color(0xFFF7F7F8);
  late Color surfaceVariant = const Color(0xFF2C2C2E);
  late Color onSurfaceVariant = const Color(0xFF85858D);
  late Color onSuccess = const Color(0xFFFFFFFF);
  late Color onWarning = const Color(0xFF000000);
  late Color onError = const Color(0xFFFFFFFF);
  late Color onInfo = const Color(0xFFFFFFFF);
  late Color transparent = const Color(0x00000000);
  late Color fullContrast = const Color(0xFFFFFFFF);
}

class FFDesignTokens {
  const FFDesignTokens(this.theme);
  final FlutterFlowTheme theme;
  FFSpacing get spacing => const FFSpacing();
  FFRadius get radius => const FFRadius();
  FFShadows get shadow => FFShadows(theme);
}

class FFSpacing {
  const FFSpacing();
  double get none => 0.0;
  double get xs => 4.0;
  double get sm => 8.0;
  double get md => 16.0;
  double get lg => 24.0;
  double get xl => 32.0;
  double get xxl => 48.0;
  double get xxxl => 64.0;
}

class FFRadius {
  const FFRadius();
  double get none => 0.0;
  double get xs => 4.0;
  double get sm => 8.0;
  double get md => 14.0;
  double get lg => 18.0;
  double get xl => 24.0;
  double get xxl => 32.0;
  double get full => 9999.0;
}

class FFShadows {
  const FFShadows(this.theme);
  final FlutterFlowTheme theme;
  BoxShadow get none => const BoxShadow(
      blurRadius: 0.0,
      color: const Color(0x00000000),
      offset: const Offset(0.0, 0.0),
      spreadRadius: 0.0);
  BoxShadow get xs => const BoxShadow(
      blurRadius: 2.0,
      color: const Color(0x0A000000),
      offset: const Offset(0.0, 1.0),
      spreadRadius: 0.0);
  BoxShadow get sm => const BoxShadow(
      blurRadius: 4.0,
      color: const Color(0x0D000000),
      offset: const Offset(0.0, 2.0),
      spreadRadius: 0.0);
  BoxShadow get md => const BoxShadow(
      blurRadius: 8.0,
      color: const Color(0x0F000000),
      offset: const Offset(0.0, 4.0),
      spreadRadius: 0.0);
  BoxShadow get lg => const BoxShadow(
      blurRadius: 20.0,
      color: const Color(0x14000000),
      offset: const Offset(0.0, 10.0),
      spreadRadius: -2.0);
  BoxShadow get xl => const BoxShadow(
      blurRadius: 25.0,
      color: const Color(0x1A000000),
      offset: const Offset(0.0, 20.0),
      spreadRadius: -5.0);
  BoxShadow get xxl => const BoxShadow(
      blurRadius: 50.0,
      color: const Color(0x26000000),
      offset: const Offset(0.0, 25.0),
      spreadRadius: -12.0);
}

extension TextStyleHelper on TextStyle {
  TextStyle override({
    TextStyle? font,
    String? fontFamily,
    Color? color,
    double? fontSize,
    FontWeight? fontWeight,
    double? letterSpacing,
    FontStyle? fontStyle,
    bool useGoogleFonts = false,
    TextDecoration? decoration,
    double? lineHeight,
    List<Shadow>? shadows,
    String? package,
  }) {
    if (useGoogleFonts && fontFamily != null && fontFamily.isNotEmpty) {
      font = GoogleFonts.getFont(fontFamily,
          fontWeight: fontWeight ?? this.fontWeight,
          fontStyle: fontStyle ?? this.fontStyle);
    }

    return font != null
        ? font.copyWith(
            color: color ?? this.color,
            fontSize: fontSize ?? this.fontSize,
            letterSpacing: letterSpacing ?? this.letterSpacing,
            fontWeight: fontWeight ?? this.fontWeight,
            fontStyle: fontStyle ?? this.fontStyle,
            decoration: decoration,
            height: lineHeight,
            shadows: shadows,
          )
        : copyWith(
            fontFamily: fontFamily,
            package: package,
            color: color,
            fontSize: fontSize,
            letterSpacing: letterSpacing,
            fontWeight: fontWeight,
            fontStyle: fontStyle,
            decoration: decoration,
            height: lineHeight,
            shadows: shadows,
          );
  }
}
