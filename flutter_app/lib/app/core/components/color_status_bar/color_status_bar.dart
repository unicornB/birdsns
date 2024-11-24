import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../theme/color_palettes.dart';

class ColoredStatusBar extends StatelessWidget {
  const ColoredStatusBar({
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
    var isDarkStyle = ColorPalettes.instance.isDark();
    var defaultColor = ColorPalettes.instance.pure;
    final androidIconBrightness =
        brightness == Brightness.dark ? Brightness.light : Brightness.dark;
    return AnnotatedRegion(
      value: SystemUiOverlayStyle(
        statusBarColor: color ?? defaultColor,
        statusBarIconBrightness: androidIconBrightness,
        statusBarBrightness: isDarkStyle ? Brightness.dark : Brightness.light,
      ),
      child: Container(
        color: color ?? defaultColor,
        child: SafeArea(
          bottom: false,
          child: Container(
            child: child,
          ),
        ),
      ),
    );
  }
}
