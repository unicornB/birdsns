import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class CustomArcIndicator extends Decoration {
  Color color;
  CustomArcIndicator({required this.color});
  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _CustomBoxPainter(this, onChanged!);
  }
}

class _CustomBoxPainter extends BoxPainter {
  final CustomArcIndicator decoration;

  _CustomBoxPainter(this.decoration, VoidCallback onChanged) : super(onChanged);

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    double rowWidth = 20;
    final size = configuration.size;
    final newOffset =
        Offset(offset.dx + size!.width / 2 - rowWidth.w, size.height / 2.5);
    var paint = Paint();
    double rowHeight = 12;
    paint.strokeWidth = rowHeight / 4;
    paint.style = PaintingStyle.stroke;
    Path path = Path();
    Rect rect = Rect.fromLTWH(
        newOffset.dx, newOffset.dy + rowHeight / 2, rowWidth, rowHeight);
    path.arcTo(rect, pi / 4, pi / 2, true);

    paint.color = decoration.color;
    paint.strokeCap = StrokeCap.round;
    paint.style = PaintingStyle.stroke;
    canvas.drawPath(path, paint);
  }
}
