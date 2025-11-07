import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const Color primary = Color(0xFF4A90E2);
  static const Color primaryDark = Color(0xFF357ABD);
  static const Color primaryLight = Color(0xFF6BA3E8);

  static const Color secondary = Color(0xFFFF9500);
  static const Color secondaryDark = Color(0xFFE6850E);
  static const Color secondaryLight = Color(0xFFFFA726);

  static const Color success = Color(0xFF27AE60);
  static const Color successLight = Color(0xFF58D68D);
  static const Color error = Color(0xFFE74C3C);
  static const Color errorLight = Color(0xFFEC7063);
  static const Color warning = Color(0xFFF39C12);
  static const Color warningLight = Color(0xFFF4D03F);
  static const Color info = Color(0xFF3498DB);
  static const Color infoLight = Color(0xFF5DADE2);

  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color grey50 = Color(0xFFFAFAFA);
  static const Color grey100 = Color(0xFFF5F5F5);
  static const Color grey200 = Color(0xFFEEEEEE);
  static const Color grey300 = Color(0xFFE0E0E0);
  static const Color grey400 = Color(0xFFBDBDBD);
  static const Color grey500 = Color(0xFF9E9E9E);
  static const Color grey600 = Color(0xFF757575);
  static const Color grey700 = Color(0xFF616161);
  static const Color grey800 = Color(0xFF424242);
  static const Color grey900 = Color(0xFF212121);

  static const Color textPrimary = Color(0xFF2C3E50);
  static const Color textSecondary = Color(0xFF7F8C8D);
  static const Color textLight = Color(0xFF95A5A6);
  static const Color textOnPrimary = Color(0xFFFFFFFF);
  static const Color textOnSecondary = Color(0xFFFFFFFF);

  static const Color background = Color(0xFFF8F9FA);
  static const Color backgroundSecondary = Color(0xFFE3F2FD);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceVariant = Color(0xFFF0F4F8);

  static const Color border = Color(0xFFE1E5E9);
  static const Color borderLight = Color(0xFFF1F3F4);
  static const Color borderDark = Color(0xFFD5DBDB);

  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFFE3F2FD),
      Color(0xFFBBDEFB),
    ],
  );

  static const LinearGradient cardGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFFFFFFFF),
      Color(0xFFF8F9FA),
    ],
  );

  static const LinearGradient shimmerGradient = LinearGradient(
    begin: Alignment(-1.0, -0.3),
    end: Alignment(1.0, 0.3),
    colors: [
      Color(0xFFE0E0E0),
      Color(0xFFF5F5F5),
      Color(0xFFE0E0E0),
    ],
  );

  static Color primaryWithOpacity(double opacity) =>
      primary.withOpacity(opacity);
  static Color blackWithOpacity(double opacity) => black.withOpacity(opacity);
  static Color whiteWithOpacity(double opacity) => white.withOpacity(opacity);
}
