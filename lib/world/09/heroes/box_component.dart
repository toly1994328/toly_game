import 'dart:ui';
import 'package:flame/components.dart';
import 'package:flame/events.dart';

import 'dot_component.dart';

class BoxComponent extends PositionComponent with TapCallbacks {
  final TickerTap dotRecord;

  BoxComponent({required this.dotRecord});

  final double initX = 60; // 初始位置 x
  late double initY = -boxSize.y; // 初始位置 y
  final double groundHeight = 12; // 地面高度
  final Vector2 boxSize = Vector2(40, 40); // 方块尺寸

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    width = boxSize.x;
    height = boxSize.y;
  }

  double vX = 0; // 水平速度
  double vY = 0; // 竖直速度
  double sX = 0; // 水平总位移
  double sY = 0; // 竖直总位移
  double aX = 0; // 水平加速度
  double aY = 0; // 竖直加速度

  void run() {
    aY = 100;
    sY = 0;
    vY = -200;
    Offset first = dotRecord.points.first;
    dotRecord.clear();
    dotRecord.points.add(first);
  }

  @override
  void update(double dt) {
    super.update(dt);
    vX += aX * dt;
    vY += aY * dt;
    sX += vX * dt;
    sY += vY * dt;
    // 达到底部高度
    if (sY > 0) {
      sY = 0;
      vX = 0;
      vY = 0;
      aY = 0;
      dotRecord.clear();
    }
    x = initX + sX;
    y = initY + sY;
    dotRecord.onTick(Offset(x + boxSize.x / 2, y + boxSize.y / 2), dt);
  }

  @override
  void onTapDown(TapDownEvent event) {
    run();
  }

  Paint paint = Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = 2
    ..color = const Color(0xff133C9A);

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    canvas.drawRect(Rect.fromLTRB(0, 0, boxSize.x, boxSize.y), paint);
  }
}
