import 'package:flutter/material.dart';

class AppMotion {
  AppMotion._();

  static Duration tabStaggerDuration(int index) {
    const base = 220;
    const step = 24;
    return Duration(milliseconds: base + (index * step));
  }

  static Curve get tabCurve => Curves.easeOutBack;

  static Curve get tabScaleCurve => Curves.elasticOut;

  static double selectedScale(bool selected) => selected ? 1.08 : 1.0;
}
