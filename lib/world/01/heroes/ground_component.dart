import 'dart:ui';

import 'package:flame/components.dart';

class GroundComponent extends PositionComponent {
  final double groundHeight = 12;

  final Vector2 boxSize = Vector2(40, 40);
  final double maxWallX = 700;
  final double wallHeight = 100;

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    width = size.x;
    y = size.y - groundHeight - 60;
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    Paint paint = Paint()..style = PaintingStyle.stroke;
    Path path = Path()..lineTo(width, 0);
    double step = 15;
    for (double i = 0; i < width; i += step) {
      path..moveTo(step + i, 0)
        ..relativeLineTo(-step, groundHeight);
    }
    canvas.drawPath(path, paint);
  }
}
