import 'package:flutter/material.dart';

extension BuildContextX on BuildContext {
  void dismissKeyboard() {
    final focusScope = FocusScope.of(this);
    if (!focusScope.hasPrimaryFocus) {
      focusScope.unfocus();
    }
  }

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSnackBar(
    String message, {
    Color? backgroundColor,
    SnackBarBehavior behavior = SnackBarBehavior.floating,
  }) {
    final messenger = ScaffoldMessenger.of(this);
    messenger.hideCurrentSnackBar();
    return messenger.showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: backgroundColor,
        behavior: behavior,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showErrorSnackBar(
    String message,
  ) {
    return showSnackBar(message, backgroundColor: Colors.red.shade400);
  }
}
