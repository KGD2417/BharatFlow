import 'package:flutter/material.dart';

class AppTheme {
  // Colors
  static const Color primaryColor = Color(0xFFFFFFFF);
  static const Color secondaryColor = Color(0xFF625B71);
  static const Color tertiaryColor = Color(0xFF7D5260);
  static const Color errorColor = Color(0xFFB3261E);

  static const Color primaryContainer = Color(0xFFEADDFF);
  static const Color secondaryContainer = Color(0xFFE8DEF8);
  static const Color tertiaryContainer = Color(0xFFFFD8E4);

  static const Color surfaceLight = Color(0xffffffff);
  static const Color surfaceDark = Color(0xff051752);

  // Light Theme
  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.light(
      primary: primaryColor,
      secondary: secondaryColor,
      tertiary: tertiaryColor,
      error: errorColor,
      surface: surfaceLight,
      background: surfaceLight.withOpacity(0.95),
      primaryContainer: primaryContainer,
      secondaryContainer: secondaryContainer,
      tertiaryContainer: tertiaryContainer,
    ),
    appBarTheme: const AppBarTheme(
      elevation: 0,
      centerTitle: false,
      backgroundColor: Color(0xffffffff),
      foregroundColor: Colors.black  ),
    cardTheme: CardTheme(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      filled: true,
      fillColor: surfaceLight,
    ),
  );

  // Dark Theme
  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.dark(
      primary: primaryColor,
      secondary: secondaryColor,
      tertiary: tertiaryColor,
      error: errorColor,
      surface: surfaceDark,
      background: surfaceDark.withOpacity(0.95),
      primaryContainer: primaryContainer.withOpacity(0.15),
      secondaryContainer: secondaryContainer.withOpacity(0.15),
      tertiaryContainer: tertiaryContainer.withOpacity(0.15),
    ),
    appBarTheme: const AppBarTheme(
      elevation: 0,
      centerTitle: false,
      backgroundColor: Color(0xffffffff),
      foregroundColor: Colors.white,
    ),
    cardTheme: CardTheme(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        backgroundColor: primaryColor,
        foregroundColor: Colors.black,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      filled: true,
      fillColor: surfaceDark.withOpacity(0.3),
    ),
  );
}

