import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class Circle extends PositionComponent with CollisionCallbacks{
  double radius;

  Circle({
    required this.radius,
    required Vector2 position,
  }) : super(
          position: position,
          size: Vector2(radius*2, radius*2),
          anchor: Anchor.center,
        );

  final Paint _paint = Paint()
    ..color = Colors.white
    ..style = PaintingStyle.stroke..strokeWidth=1;

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    canvas.save();
    canvas.translate(size.x / 2, size.y / 2);
    canvas.drawCircle(Offset.zero, radius, _paint);
    canvas.restore();
  }

  late ShapeHitbox hitbox;
  @override
  Future<void> onLoad() async {
    hitbox = CircleHitbox();
    // hitbox.debugMode = true;
    add(hitbox);
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints,
      PositionComponent other,
      ) {
    super.onCollisionStart(intersectionPoints, other);
    _paint.color = Colors.blue;
  }

  @override
  void onCollisionEnd(PositionComponent other) {
    super.onCollisionEnd(other);
    _paint.color = Colors.white;
  }
}
