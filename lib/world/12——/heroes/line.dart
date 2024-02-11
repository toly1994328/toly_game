import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class Line extends PositionComponent with CollisionCallbacks {
  Line() : super(position: Vector2(300, 100), size: Vector2(120, 2));

  final Paint _paint = Paint()
    ..color = Colors.black
    ..style = PaintingStyle.stroke
    ..strokeWidth = 1;

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    canvas.drawLine(Offset.zero, Offset(width, 0), _paint);
  }

  @override
  Future<void> onLoad() async {
    add(RectangleHitbox());
  }

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    super.onCollisionStart(intersectionPoints, other);
    print('onCollisionStart==========');
    _paint.color = Colors.blue;
  }



  @override
  void onCollisionEnd(PositionComponent other) {
    super.onCollisionEnd(other);
    _paint.color = Colors.black;
    print('onCollisionEnd==========');
  }
}
