import 'package:flutter/material.dart';

abstract class AppColors {
  AppColors._();

  // Brand Colors
  static Color get primary => const Color(0xFF13ECEC);
  static Color get primaryDark => const Color(0xFF0EBABA);
  static Color get secondary => const Color(0xFFFFAB91);
  static Color get accent => const Color(0xFF448AFF);

  // Feedback Colors
  static Color get success => const Color(0xFF4CAF50);
  static Color get warning => const Color(0xFFFFC107);
  static Color get error => const Color(0xFFF44336);

  // Neutral Colors
  static Color get grey100 => const Color(0xFFF5F5F5);
  static Color get grey200 => const Color(0xFFEEEEEE);
  static Color get grey300 => const Color(0xFFE0E0E0);

  // Surface Colors
  static Color get backgroundLight => const Color(0xFFF8F9FA);
  static Color get backgroundDark => const Color(0xFF102222);
  static Color get background => backgroundLight;
  static Color get surface => const Color(0xFFFFFFFF);

  // Text Colors
  static Color get textMain => const Color(0xFF2D3748);
  static Color get textSubtle => const Color(0xFF718096);
  static Color get textDisabled => const Color(0xFFBDBDBD);

  // Link Colors
  static Color get link => const Color(0xFF2196F3);
}
