import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class Line extends PositionComponent {
  double lineWidth;

  Line({
    required this.lineWidth,
    required Vector2 position,
  }) : super(
          position: position,
          size: Vector2(lineWidth, 2),
          anchor: Anchor.center,
        );

  final Paint _paint = Paint()
    ..color = Colors.white
    ..style = PaintingStyle.stroke..strokeWidth=1;

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    canvas.translate(size.x / 2, size.y / 2);
    canvas.drawLine(Offset.zero, Offset(width,0), _paint);
  }
}
