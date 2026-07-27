import 'package:flutter/material.dart';
import 'package:riverpod_standard/core/localization/locale_keys.g.dart';
import 'package:riverpod_standard/core/localization/localization_key.dart';
import 'app_button.dart';

class AppErrorView extends StatelessWidget {
  const AppErrorView({
    super.key,
    this.title = LocaleKeys.common_something_went_wrong,
    this.message = LocaleKeys.common_unknown_error_occurred,
    this.icon = Icons.error_outline,
    this.iconColor,
    this.onRetry,
    this.retryLabel = LocaleKeys.common_retry,
    this.maxWidth = 360,
    this.padding = const EdgeInsets.symmetric(horizontal: 22.0),
  });

  final String title;
  final String message;
  final IconData icon;
  final Color? iconColor;
  final VoidCallback? onRetry;
  final String retryLabel;
  final double maxWidth;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    final resolvedIconColor = iconColor ?? colorScheme.error;
    final resolvedTitle = _translateAppKey(title);
    final resolvedMessage = _translateAppKey(message);
    final resolvedRetryLabel = _translateAppKey(retryLabel);

    return Center(
      child: Padding(
        padding: padding,
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: maxWidth),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DecoratedBox(
                decoration: BoxDecoration(
                  color: resolvedIconColor.withValues(alpha: 0.12),
                  shape: BoxShape.circle,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Icon(icon, size: 34.0, color: resolvedIconColor),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                resolvedTitle,
                textAlign: TextAlign.center,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                resolvedMessage,
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurface.withValues(alpha: 0.72),
                  height: 1.35,
                ),
              ),
              if (onRetry != null) ...[
                const SizedBox(height: 20),
                AppButton(
                  label: resolvedRetryLabel,
                  onPressed: onRetry,
                  isFullWidth: false,
                  height: 44,
                  borderRadius: 12,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  String _translateAppKey(String value) {
    return translateIfLocalizationKey(value);
  }
}

class AppError extends StatelessWidget {
  const AppError({
    super.key,
    this.title = LocaleKeys.common_something_went_wrong,
    this.message = LocaleKeys.common_unknown_error_occurred,
    this.onRetry,
  });

  static const String routeName = 'appError';

  final String title;
  final String message;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: AppErrorView(title: title, message: message, onRetry: onRetry),
    );
  }
}
