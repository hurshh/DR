import 'package:flutter/material.dart';

class AppTheme {
  const AppTheme._();

  // Colors are inferred from the wireframes (PDF export).
  static const Color orange = Color(0xFFF36B3B);
  static const Color orangeDeep = Color(0xFFE95A2A);
  static const Color teal = Color(0xFF53D2C7);
  static const Color tealDeep = Color(0xFF2BC7B7);
  static const Color purple = Color(0xFF6A59E0);
  static const Color purpleDeep = Color(0xFF5748D6);
  static const Color yellow = Color(0xFFF5D457);
  static const Color yellowDeep = Color(0xFFF0C937);
  static const Color dark = Color(0xFF1D2630);
  static const Color lightCream = Color(0xFFF6EFE3);
  static const Color offWhite = Color(0xFFF8FAFC);

  static ThemeData light() {
    const base = TextStyle(
      fontFamily: 'system-ui',
      color: Color(0xFF1D2630),
    );

    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: lightCream,
      colorScheme: const ColorScheme.light(
        primary: orange,
        secondary: teal,
        surface: Colors.white,
      ),
      textTheme: Typography.material2021().black.apply(
        fontFamily: base.fontFamily,
      ),
    );
  }
}

