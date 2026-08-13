import 'package:flutter/material.dart';

class AppTheme {
  // Primary Colors
  static const Color primaryBlue = Color(0xFF0066FF);
  static const Color primaryCyan = Color(0xFF00D4FF);
  static const Color accentGreen = Color(0xFF00FF88);
  static const Color accentOrange = Color(0xFFFF9500);

  // Block Colors
  static const Color blockRed = Color(0xFFFF3B30);
  static const Color blockBlue = Color(0xFF0099FF);
  static const Color blockGreen = Color(0xFF00DD88);
  static const Color blockYellow = Color(0xFFFFDD00);
  static const Color blockPurple = Color(0xFFDD44FF);
  static const Color blockOrange = Color(0xFFFF9500);
  static const Color blockCyan = Color(0xFF00DDFF);

  // Backgrounds
  static const Color bgDark = Color(0xFF1a2a4a);
  static const Color bgCardDark = Color(0xFF2a3f5f);
  static const Color bgCardLight = Color(0xFF4a6fa5);

  // UI Elements
  static const Color buttonGreen = Color(0xFF44DD88);
  static const Color buttonRed = Color(0xFFFF6B6B);
  static const Color textWhite = Color(0xFFFFFFFF);
  static const Color textGrey = Color(0xFFCCCCCC);

  // Gradients
  static final LinearGradient bgGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF0099FF), Color(0xFF0055DD)],
  );

  static final LinearGradient buttonGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF44DD88), Color(0xFF00BB66)],
  );

  static final LinearGradient cardGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF3a5f8f), Color(0xFF2a4a7f)],
  );

  // Text Styles
  static const TextStyle titleLarge = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: textWhite,
  );

  static const TextStyle titleMedium = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: textWhite,
  );

  static const TextStyle headingStyle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: textWhite,
  );

  static const TextStyle bodyLarge = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: textWhite,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: textWhite,
  );

  static const TextStyle bodySmall = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: textGrey,
  );

  static const TextStyle labelLarge = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: textWhite,
  );

  static const TextStyle labelMedium = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: textWhite,
  );
}
