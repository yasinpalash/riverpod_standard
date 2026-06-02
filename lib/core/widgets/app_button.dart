import 'package:flutter/material.dart';

import 'app_loading.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
    this.isFullWidth = true,
    this.height = 56,
    this.borderRadius = 16,
    this.gradient,
    this.textStyle,
    this.padding = const EdgeInsets.symmetric(horizontal: 20),
    this.minWidth = 96,
    this.leading,
    this.trailing,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isFullWidth;
  final double height;
  final double borderRadius;
  final Gradient? gradient;
  final TextStyle? textStyle;
  final EdgeInsetsGeometry padding;
  final double minWidth;
  final Widget? leading;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final isEnabled = onPressed != null && !isLoading;
    final hasGradient = gradient != null && onPressed != null;
    final shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(borderRadius),
    );

    return SizedBox(
      width: isFullWidth ? double.infinity : null,
      height: height,
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: hasGradient ? gradient : null,
          borderRadius: BorderRadius.circular(borderRadius),
          boxShadow:
              hasGradient
                  ? [
                    BoxShadow(
                      color: Theme.of(
                        context,
                      ).colorScheme.primary.withValues(alpha: 0.3),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ]
                  : null,
        ),
        child: ElevatedButton(
          onPressed: isEnabled ? onPressed : null,
          style:
              hasGradient
                  ? ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    disabledBackgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    minimumSize: Size(minWidth, height),
                    padding: padding,
                    shape: shape,
                  )
                  : ElevatedButton.styleFrom(
                    minimumSize: Size(minWidth, height),
                    padding: padding,
                    shape: shape,
                  ),
          child:
              isLoading
                  ? const AppLoading(size: 22, color: Colors.white)
                  : Row(
                    mainAxisSize:
                        isFullWidth ? MainAxisSize.max : MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (leading != null) ...[
                        leading!,
                        const SizedBox(width: 8),
                      ],
                      Text(label, style: textStyle),
                      if (trailing != null) ...[
                        const SizedBox(width: 8),
                        trailing!,
                      ],
                    ],
                  ),
        ),
      ),
    );
  }
}
