import 'dart:ui';
import 'package:flame/components.dart';

import 'dot_component.dart';

class BoxComponent extends PositionComponent {
  final TickerTap dotRecord;

  BoxComponent({required this.dotRecord});

  final double initX = 60; // 初始位置 x
  final double initY = 60; // 初始位置 y
  final double groundHeight = 12; // 地面高度
  final Vector2 boxSize = Vector2(40, 40); // 方块尺寸

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    width = size.x;
    x = initX;
    y = size.y - groundHeight - initY - boxSize.y;
  }

  double vX = 0; // 水平速度
  double sX = 0; // 水平总位移
  double aX = 0; // 水平加速度

  final double maxWallX = 700;

  void run() {
    sX = 0;
    aX = 100;
    vX = 150;
  }

  @override
  void update(double dt) {
    super.update(dt);
    vX += aX * dt;
    double ds = vX * dt;
    sX += ds;
    // 达到最大位移
    if (sX > maxWallX - initX) {
      sX = maxWallX - initX;
      vX = -vX;
      dotRecord.clear();
    }
    // 达到最小位移
    if (sX < 0) {
      sX = 0;
      vX = -vX;
      dotRecord.clear();
    }
    x = initX + sX;
    dotRecord.onTick(Offset(x+boxSize.x/2 ,0+boxSize.y/2), dt);

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
