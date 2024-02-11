import 'dart:ui';
import 'package:flame/components.dart';

import 'dot_component.dart';


class BoxComponent extends PositionComponent {
  final TickerTap dotRecord;

  BoxComponent({required this.dotRecord});

  final double initX = 60; // 初始位置 x
  double initY = 60; // 初始位置 y
  final double groundHeight = 12; // 地面高度
  final Vector2 boxSize = Vector2(40, 40); // 方块尺寸

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    x = initX;
    initY = size.y - groundHeight - 60 - boxSize.y;
    y = initY;
  }

  double vX = 0; // 水平速度
  double vY = 0; // 竖直速度
  double sX = 0; // 水平总位移
  double sY = 0; // 竖直总位移
  double aX = 0; // 水平加速度
  double aY = 0; // 竖直加速度

  final double maxWallX = 700;
  final double maxWallY = -200;

  void run() {
    sX = 0;
    sY = 0;
    aX = 100;
    vX = 150;
    vY = -60;
  }

  @override
  void update(double dt) {
    super.update(dt);
    vX += aX * dt;
    vY += aY * dt;
    sX += vX * dt;
    sY += vY * dt;

    // 达到最大位移
    if (sX > maxWallX - initX) {
      sX = maxWallX - initX;
      vX = -vX;
    }
    // 达到顶部高度
    if (sY < maxWallY + boxSize.y) {
      sY = maxWallY + boxSize.y;
      vY = -vY;
    }

    // 达到底部高度
    if (sY > 0) {
      sY = 0;
      vY = -vY;
      dotRecord.clear();
    }

    // 达到最小位移
    if (sX < 0) {
      sX = 0;
      vX = -vX;
    }
    x = initX + sX;
    y = initY + sY;
    if (vX != 0 && vY != 0) {
      dotRecord.onTick(Offset(x + boxSize.x / 2, sY + boxSize.y / 2), dt);
    }
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
