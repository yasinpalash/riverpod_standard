import 'package:flutter/services.dart';

class HapticService {
  const HapticService();

  Future<void> lightImpact() => HapticFeedback.lightImpact();

  Future<void> mediumImpact() => HapticFeedback.mediumImpact();

  Future<void> heavyImpact() => HapticFeedback.heavyImpact();

  Future<void> selectionClick() => HapticFeedback.selectionClick();

  Future<void> vibrate() => HapticFeedback.vibrate();
}
