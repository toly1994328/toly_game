import 'dart:ui';

import 'package:flame/components.dart';

class GroundComponent extends PositionComponent {
  final double groundHeight = 12;

  final Vector2 boxSize = Vector2(40, 40);
  final double maxWallX = 700;
  final double wallHeight = 200;

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
    Path wallBottom = horizontalWallPath(
      0,
      Size(width, groundHeight),
      left: true,
    );
    canvas.drawPath(wallBottom, paint);

    Path wallTop = horizontalWallPath(
      -200,
      Size(width, groundHeight),
      left: false,
    );
    canvas.drawPath(wallTop, paint);

    Path wall1 = verticalWallPath(
        maxWallX + boxSize.x,
        Size(
          groundHeight,
          wallHeight,
        ));
    canvas.drawPath(wall1, paint);
    Path wall2 = verticalWallPath(
        60,
        Size(
          groundHeight,
          wallHeight,
        ),
        left: false);
    canvas.drawPath(wall2, paint);
  }

  Path verticalWallPath(
    double x,
    Size wallSize, {
    double step = 15,
    bool left = true,
  }) {
    Path path = Path();
    path.moveTo(x, 0);
    path.lineTo(x, -wallSize.height);
    double step = 15;
    double width = left ? wallSize.width : -wallSize.width;

    for (double i = 0; i < wallSize.height - step; i += step) {
      path
        ..moveTo(x, -(step + i))
        ..relativeLineTo(width, step);
    }
    return path;
  }

  Path horizontalWallPath(
    double y,
    Size wallSize, {
    double step = 15,
    bool left = true,
  }) {
    Path path = Path()..moveTo(0, y)..lineTo(wallSize.width, y);
    double step = 15;
    double height = left ? wallSize.height : -wallSize.height;

    for (double i = 0; i < wallSize.width; i += step) {
      path
        ..moveTo(step + i, y)
        ..relativeLineTo(-step,height);
    }
    return path;
  }
}
