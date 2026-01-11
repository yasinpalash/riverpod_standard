import 'package:flutter/material.dart';
import 'package:riverpod_standard/shared/theme/text_styles.dart';
import 'app_colors.dart';


class TextThemes {
  static TextTheme get baseTextTheme {
    return const TextTheme(
      bodyLarge: AppTextStyles.bodyLg,
      bodyMedium: AppTextStyles.body,
      bodySmall: AppTextStyles.bodySm,
      labelSmall: AppTextStyles.bodyXs,
      displayLarge: AppTextStyles.h1,
      displayMedium: AppTextStyles.h2,
      displaySmall: AppTextStyles.h3,
      headlineMedium: AppTextStyles.h4,
    );
  }

  static TextTheme get darkTextTheme {
    return baseTextTheme.apply(
      bodyColor: AppColors.white,
      displayColor: AppColors.white,
      decorationColor: AppColors.white,
      fontFamily: AppTextStyles.fontFamily,
    );
  }

  static TextTheme get lightTextTheme {
    return baseTextTheme.apply(
      bodyColor: AppColors.black,
      displayColor: AppColors.black,
      decorationColor: AppColors.black,
      fontFamily: AppTextStyles.fontFamily,
    );
  }

  static TextTheme get primaryTextTheme {
    return baseTextTheme.apply(
      bodyColor: AppColors.primary,
      displayColor: AppColors.primary,
      decorationColor: AppColors.primary,
      fontFamily: AppTextStyles.fontFamily,
    );
  }
}

