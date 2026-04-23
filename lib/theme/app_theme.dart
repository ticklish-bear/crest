import 'package:flutter/material.dart';

/// Domain-specific colors for fertility tracking.
/// UI colors come from Theme.of(context).colorScheme.
class AppColors {
  AppColors._();

  // Fertility status — chosen for clear visual distinction
  static const Color fertile = Color(0xFFD4764E);     // warm orange — high attention
  static const Color infertilePre = Color(0xFF7BA7C9); // cool blue — moderate caution
  static const Color infertilePost = Color(0xFF4A9B6F); // confident green — safe
  static const Color menstruation = Color(0xFFCF6679); // pink-red
  static const Color unknown = Color(0xFFAAAAAA);

  // Bleeding intensity gradient
  static const Color bleedingSpotting = Color(0xFFE8A0AA);
  static const Color bleedingLight = Color(0xFFD98090);
  static const Color bleedingMedium = Color(0xFFCF6679);
  static const Color bleedingHeavy = Color(0xFFB5404F);

  // Chart
  static const Color temperatureLine = Color(0xFF6B7FD7);
  static const Color temperatureDot = Color(0xFF5568C8);
  static const Color temperatureExcluded = Color(0xFFBDBDBD);
  static const Color coverline = Color(0xFFE8956A);

  // Mucus quality
  static const Color mucusDry = Color(0xFFE8E0DC);
  static const Color mucusNothing = Color(0xFFD4C5B9);
  static const Color mucusMoist = Color(0xFFC9B8A8);
  static const Color mucusWet = Color(0xFFB09ECD);
  static const Color mucusEggWhite = Color(0xFF9378A8);
}

class AppTheme {
  AppTheme._();

  static const _seed = Color(0xFF8B5E83);

  static ThemeData get lightTheme {
    final scheme = ColorScheme.fromSeed(
      seedColor: _seed,
      brightness: Brightness.light,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: scheme.surface,
      appBarTheme: AppBarTheme(
        backgroundColor: scheme.surface,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0.5,
        centerTitle: false,
        titleTextStyle: TextStyle(
          color: scheme.onSurface,
          fontSize: 22,
          fontWeight: FontWeight.w600,
          letterSpacing: -0.3,
        ),
        iconTheme: IconThemeData(color: scheme.onSurfaceVariant),
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: scheme.outlineVariant.withAlpha(100)),
        ),
        color: scheme.surface,
        margin: EdgeInsets.zero,
      ),
      navigationBarTheme: NavigationBarThemeData(
        height: 72,
        elevation: 0,
        backgroundColor: scheme.surface,
        surfaceTintColor: Colors.transparent,
        indicatorColor: scheme.primaryContainer,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: scheme.surfaceContainerLowest,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: scheme.outlineVariant),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: scheme.outlineVariant),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: scheme.primary, width: 2),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
      chipTheme: ChipThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      dividerTheme: DividerThemeData(
        color: scheme.outlineVariant.withAlpha(100),
        thickness: 1,
        space: 1,
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      dialogTheme: DialogThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
      ),
    );
  }

  static Color bleedingColor(int bleedingIndex) {
    switch (bleedingIndex) {
      case 1: // spotting
        return AppColors.bleedingSpotting;
      case 2: // light
        return AppColors.bleedingLight;
      case 3: // medium
        return AppColors.bleedingMedium;
      case 4: // heavy
        return AppColors.bleedingHeavy;
      default:
        return AppColors.menstruation;
    }
  }

  static Color mucusColor(int quality) {
    switch (quality) {
      case 0:
        return AppColors.mucusDry;
      case 1:
        return AppColors.mucusNothing;
      case 2:
        return AppColors.mucusMoist;
      case 3:
        return AppColors.mucusWet;
      case 4:
        return AppColors.mucusEggWhite;
      default:
        return AppColors.mucusDry;
    }
  }
}
