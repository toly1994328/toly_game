import 'dart:ui';
import 'package:flame/components.dart';

class BoxComponent extends PositionComponent {
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

  double vX = 100; // 水平速度
  double sX = 0; // 水平总位移

  @override
  void update(double dt) {
    super.update(dt);
    double ds = vX * dt;
    sX += ds;

    x = initX + sX;
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