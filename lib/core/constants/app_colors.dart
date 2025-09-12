// lib/core/constants/app_colors.dart
import 'package:flutter/material.dart';

///
/// As cores possuem medidas em hexadecimal
///

class AppColors {
  // Primary Colors
  static const Color primaryRed = Color(0xFFEA1D2C);
  static const Color primaryRedDark = Color(0xFFD61426);
  static const Color primaryRedLight = Color(0xFFFF4757);

  // Neutral Colors
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color grey100 = Color(0xFFF5F5F5);
  static const Color grey200 = Color(0xFFEEEEEE);
  static const Color grey300 = Color(0xFFE0E0E0);
  static const Color grey400 = Color(0xFFBDBDBD);
  static const Color grey500 = Color(0xFF9E9E9E);
  static const Color grey600 = Color(0xFF757575);
  static const Color grey700 = Color(0xFF616161);
  static const Color grey800 = Color(0xFF424242);
  static const Color grey900 = Color(0xFF212121);

  // Status Colors
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFF9800);
  static const Color error = Color(0xFFF44336);
  static const Color info = Color(0xFF2196F3);

  // Text Colors
  static const Color textPrimary = grey900;
  static const Color textSecondary = grey600;
  static const Color textDisabled = grey400;
  static const Color textOnPrimary = white;

  // Background Colors
  static const Color backgroundPrimary = grey100;
  static const Color backgroundSecondary = grey200;
  static const Color backgroundCard = white;
}