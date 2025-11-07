import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTypography {
  AppTypography._();

  static const String fontFamily = 'Roboto';

  static const FontWeight light = FontWeight.w300;
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight semiBold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;
  static const FontWeight extraBold = FontWeight.w800;

  static const TextStyle h1 = TextStyle(
    fontSize: 32,
    fontWeight: bold,
    height: 1.2,
    color: AppColors.textPrimary,
    fontFamily: fontFamily,
  );

  static const TextStyle h2 = TextStyle(
    fontSize: 28,
    fontWeight: bold,
    height: 1.2,
    color: AppColors.textPrimary,
    fontFamily: fontFamily,
  );

  static const TextStyle h3 = TextStyle(
    fontSize: 24,
    fontWeight: semiBold,
    height: 1.3,
    color: AppColors.textPrimary,
    fontFamily: fontFamily,
  );

  static const TextStyle h4 = TextStyle(
    fontSize: 20,
    fontWeight: semiBold,
    height: 1.3,
    color: AppColors.textPrimary,
    fontFamily: fontFamily,
  );

  static const TextStyle h5 = TextStyle(
    fontSize: 18,
    fontWeight: medium,
    height: 1.3,
    color: AppColors.textPrimary,
    fontFamily: fontFamily,
  );

  static const TextStyle h6 = TextStyle(
    fontSize: 16,
    fontWeight: medium,
    height: 1.4,
    color: AppColors.textPrimary,
    fontFamily: fontFamily,
  );

  static const TextStyle bodyLarge = TextStyle(
    fontSize: 16,
    fontWeight: regular,
    height: 1.5,
    color: AppColors.textPrimary,
    fontFamily: fontFamily,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontSize: 14,
    fontWeight: regular,
    height: 1.4,
    color: AppColors.textPrimary,
    fontFamily: fontFamily,
  );

  static const TextStyle bodySmall = TextStyle(
    fontSize: 12,
    fontWeight: regular,
    height: 1.4,
    color: AppColors.textSecondary,
    fontFamily: fontFamily,
  );

  static const TextStyle labelLarge = TextStyle(
    fontSize: 14,
    fontWeight: medium,
    height: 1.3,
    color: AppColors.textPrimary,
    fontFamily: fontFamily,
  );

  static const TextStyle labelMedium = TextStyle(
    fontSize: 12,
    fontWeight: medium,
    height: 1.3,
    color: AppColors.textPrimary,
    fontFamily: fontFamily,
  );

  static const TextStyle labelSmall = TextStyle(
    fontSize: 10,
    fontWeight: medium,
    height: 1.2,
    color: AppColors.textSecondary,
    fontFamily: fontFamily,
  );

  static const TextStyle displayLarge = TextStyle(
    fontSize: 40,
    fontWeight: extraBold,
    height: 1.1,
    color: AppColors.textPrimary,
    fontFamily: fontFamily,
  );

  static const TextStyle displayMedium = TextStyle(
    fontSize: 36,
    fontWeight: bold,
    height: 1.1,
    color: AppColors.textPrimary,
    fontFamily: fontFamily,
  );

  static const TextStyle displaySmall = TextStyle(
    fontSize: 32,
    fontWeight: bold,
    height: 1.2,
    color: AppColors.textPrimary,
    fontFamily: fontFamily,
  );

  static const TextStyle button = TextStyle(
    fontSize: 14,
    fontWeight: medium,
    height: 1.2,
    color: AppColors.textOnPrimary,
    fontFamily: fontFamily,
  );

  static const TextStyle buttonSmall = TextStyle(
    fontSize: 12,
    fontWeight: medium,
    height: 1.2,
    color: AppColors.textOnPrimary,
    fontFamily: fontFamily,
  );

  static const TextStyle caption = TextStyle(
    fontSize: 11,
    fontWeight: regular,
    height: 1.3,
    color: AppColors.textSecondary,
    fontFamily: fontFamily,
  );

  static const TextStyle overline = TextStyle(
    fontSize: 10,
    fontWeight: medium,
    height: 1.2,
    color: AppColors.textSecondary,
    fontFamily: fontFamily,
    letterSpacing: 1.5,
  );

  static const TextStyle priceLarge = TextStyle(
    fontSize: 18,
    fontWeight: bold,
    height: 1.2,
    color: AppColors.success,
    fontFamily: fontFamily,
  );

  static const TextStyle priceMedium = TextStyle(
    fontSize: 16,
    fontWeight: bold,
    height: 1.2,
    color: AppColors.success,
    fontFamily: fontFamily,
  );

  static const TextStyle priceSmall = TextStyle(
    fontSize: 14,
    fontWeight: bold,
    height: 1.2,
    color: AppColors.success,
    fontFamily: fontFamily,
  );

  static const TextStyle brandTitle = TextStyle(
    fontSize: 20,
    fontWeight: bold,
    height: 1.2,
    color: AppColors.textOnPrimary,
    fontFamily: fontFamily,
  );

  static const TextStyle brandSubtitle = TextStyle(
    fontSize: 9,
    fontWeight: bold,
    height: 1.2,
    color: AppColors.textSecondary,
    fontFamily: fontFamily,
    letterSpacing: 0.5,
  );

  static const TextStyle productTitle = TextStyle(
    fontSize: 13,
    fontWeight: bold,
    height: 1.2,
    color: AppColors.textPrimary,
    fontFamily: fontFamily,
  );

  static const TextStyle productDescription = TextStyle(
    fontSize: 10,
    fontWeight: regular,
    height: 1.2,
    color: AppColors.textSecondary,
    fontFamily: fontFamily,
  );

  static const TextStyle categoryTag = TextStyle(
    fontSize: 9,
    fontWeight: bold,
    height: 1.0,
    color: AppColors.textOnPrimary,
    fontFamily: fontFamily,
  );
}
