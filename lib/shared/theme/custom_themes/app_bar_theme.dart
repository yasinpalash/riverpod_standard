import 'package:flutter/material.dart';
import '../app_colors.dart';
import '../text_styles.dart';

class AppBarForTheme {
  AppBarForTheme._();

  static AppBarTheme _baseAppBarTheme({
    required Color backgroundColor,
    required Color iconColor,
    required Color titleColor,
    required Color surfaceTintColor,
    required double elevation,
  }) {
    return AppBarTheme(
      foregroundColor: Colors.transparent,
      surfaceTintColor: surfaceTintColor,
      elevation: elevation,
      backgroundColor: backgroundColor,
      iconTheme: IconThemeData(color: iconColor),
      titleTextStyle: AppTextStyles.h2.copyWith(color: titleColor),
      actionsIconTheme: IconThemeData(color: iconColor),
      centerTitle: true,
      // systemOverlayStyle: SystemUiOverlayStyle.light,
    );
  }

  static final AppBarTheme lightAppBarTheme = _baseAppBarTheme(
    backgroundColor: AppColors.primary,
    iconColor: AppColors.white,
    titleColor: AppColors.white,
    surfaceTintColor: AppColors.primary,
    elevation: 0,
  );

  static final AppBarTheme darkAppBarTheme = _baseAppBarTheme(
    backgroundColor: AppColors.black,
    iconColor: Colors.white,
    titleColor: Colors.white,
    surfaceTintColor: Colors.transparent,
    elevation: 0,
  );
}
