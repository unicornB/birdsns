import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ColoredStatusBarWithBottom extends StatelessWidget {
  const ColoredStatusBarWithBottom({
    super.key,
    this.color,
    this.child,
    this.brightness = Brightness.light,
  });

  final Color? color;
  final Widget? child;
  final Brightness brightness;

  @override
  Widget build(BuildContext context) {
    const defaultColor = Colors.white;
    final androidIconBrightness =
        brightness == Brightness.dark ? Brightness.light : Brightness.dark;
    return AnnotatedRegion(
      value: SystemUiOverlayStyle(
        statusBarColor: color ?? defaultColor,
        statusBarIconBrightness: androidIconBrightness,
        statusBarBrightness: brightness,
      ),
      child: Container(
        color: color ?? defaultColor,
        child: SafeArea(
          bottom: true,
          child: Container(
            child: child,
          ),
        ),
      ),
    );
  }
}
