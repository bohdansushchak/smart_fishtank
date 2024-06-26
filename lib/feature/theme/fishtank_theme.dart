import 'package:flutter/material.dart';

class FishTankTheme extends ThemeExtension<FishTankTheme> {
  final Gradient? backgroundGradient;

  FishTankTheme({
    required this.backgroundGradient,
  });

  factory FishTankTheme.of(BuildContext context) =>
      Theme.of(context).extension<FishTankTheme>()!;

  @override
  ThemeExtension<FishTankTheme> copyWith({
    Gradient? backgroundGradient,
  }) {
    return FishTankTheme(
      backgroundGradient: backgroundGradient ?? this.backgroundGradient,
    );
  }

  factory FishTankTheme.light() => FishTankTheme(
          backgroundGradient: const LinearGradient(
        colors: [
          Color(0xFF2C6CBC),
          Color(0xFF71C3F7),
          Color(0xFFF6F6F6),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ));

  @override
  ThemeExtension<FishTankTheme> lerp(FishTankTheme other, double t) {
    return FishTankTheme(
      backgroundGradient:
          Gradient.lerp(backgroundGradient, other.backgroundGradient, t),
    );
  }
}
