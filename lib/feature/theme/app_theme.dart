import 'package:flutter/material.dart';
import 'package:smart_fishtank/feature/theme/fishtank_theme.dart';

class AppTheme {
  InputDecorationTheme _getInputDecorationTheme() {
    final borderRadius = BorderRadius.circular(4);

    return InputDecorationTheme(
      fillColor: AppColors.catskillWhite,
      floatingLabelBehavior: FloatingLabelBehavior.auto,
      filled: true,
      border: OutlineInputBorder(
        borderRadius: borderRadius,
        borderSide: const BorderSide(color: AppColors.mercury),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: borderRadius,
        borderSide: const BorderSide(color: AppColors.mercury),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: borderRadius,
        borderSide: const BorderSide(color: AppColors.carnation),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: borderRadius,
        borderSide: const BorderSide(color: Colors.black),
      ),
      hintStyle: const TextStyle(
        fontSize: 18,
        color: AppColors.paleSky,
        fontWeight: FontWeight.normal,
      ),
      labelStyle: const TextStyle(
        fontSize: 18,
        color: AppColors.paleSky,
        fontWeight: FontWeight.normal,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      constraints: const BoxConstraints(maxWidth: 440),
      errorStyle: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: AppColors.carnation,
      ),
    );
  }

  ThemeData get light => ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.light,
        ),
        inputDecorationTheme: _getInputDecorationTheme(),
        extensions: [
          FishTankTheme.light(),
        ],
      );

  ThemeData get dark => ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.dark,
        ),
      );
}

abstract final class AppColors {
  static const Color athensGray = Color(0xFFF5F6F8);
  static const Color catskillWhite = Color(0xFFF5F8FA);
  static const Color mercury = Color(0xFFE4E4E4);
  static const Color botticelli = Color(0xFFC2CFE0);

  static const Color dodgerBlue = Color(0xFF109CF1);
  static const Color dodgerBlue2 = Color(0x34109CF1);
  static const Color carnation = Color(0xFFF7685B);
  static const Color tamarillo = Color(0xFF891115);

  static const Color paleSky = Color(0xFF707683);
  static const Color limedSpruce = Color(0xFF323C47);
  static const Color shadow = Color(0x0F000000);

  static const Color apple = Color(0xFF558B2F);
  static const Color seaBuckthorn = Color(0xFFF9A825);
  static const Color pomegranate = Color(0xFFEF3A2B);
  static const Color daisyBush = Color(0xFF512DA8);

  static Color colorLineOf(int line) {
    assert(line >= 1 && line <= 4);
    return {
      1: AppColors.apple,
      2: AppColors.seaBuckthorn,
      3: AppColors.pomegranate,
      4: AppColors.daisyBush,
    }[line]!;
  }
}
