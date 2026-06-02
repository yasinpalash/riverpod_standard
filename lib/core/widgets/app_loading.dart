import 'package:flutter/material.dart';

class AppLoading extends StatelessWidget {
  const AppLoading({
    super.key,
    this.size = 32,
    this.color,
    this.fullScreen = false,
  });

  final double size;
  final Color? color;
  final bool fullScreen;

  @override
  Widget build(BuildContext context) {
    final loader = Center(
      child: SizedBox.square(
        dimension: size,
        child: CircularProgressIndicator(
          color: color,
          strokeWidth: size <= 24 ? 2.5 : 4,
        ),
      ),
    );

    if (fullScreen) {
      return Scaffold(body: loader);
    }

    return loader;
  }
}
