import 'dart:ui';

import 'package:flame/components.dart';
import 'dot_component.dart';
import 'box_component.dart';

class GroundComponent extends PositionComponent{

  final TickerTap dotRecord = TickerTap(frequency: 8);
  late BoxComponent box = BoxComponent(dotRecord: dotRecord);
  late DotComponent dot = DotComponent(dotRecord);

  @override
  Future<void> onLoad() async {
    add(box);
    add(dot);
  }

  final double groundHeight = 12;

  final Vector2 boxSize = Vector2(40, 40);
  final double maxWallX = 700;
  final double wallHeight = 200;

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    width = size.x;
    height = groundHeight;
    y = size.y - groundHeight - 40;
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
    canvas.drawRect(Rect.fromPoints(const Offset(60+10,-195), const Offset(80,0)), paint);
    canvas.drawRect(Rect.fromPoints(const Offset(40+10,-200), const Offset(100,-195)), paint);
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
