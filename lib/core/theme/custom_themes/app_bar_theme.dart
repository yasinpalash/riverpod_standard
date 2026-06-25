import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../system/system_ui_config.dart';
import 'app_text_styles.dart';

class AppBarForTheme {
  AppBarForTheme._();

  static AppBarTheme _baseAppBarTheme({
    required Color backgroundColor,
    required Color iconColor,
    required Color titleColor,
    required Color surfaceTintColor,
    required double elevation,
    required Brightness systemOverlayBrightness,
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
      systemOverlayStyle: SystemUiConfig.overlayStyleFor(
        systemOverlayBrightness,
      ),
    );
  }

  static final AppBarTheme lightAppBarTheme = _baseAppBarTheme(
    backgroundColor: AppColors.primary,
    iconColor: AppColors.white,
    titleColor: AppColors.white,
    surfaceTintColor: AppColors.primary,
    elevation: 0,
    systemOverlayBrightness: Brightness.dark,
  );

  static final AppBarTheme darkAppBarTheme = _baseAppBarTheme(
    backgroundColor: AppColors.black,
    iconColor: Colors.white,
    titleColor: Colors.white,
    surfaceTintColor: Colors.transparent,
    elevation: 0,
    systemOverlayBrightness: Brightness.dark,
  );
}
