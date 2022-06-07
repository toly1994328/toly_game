import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class Line extends PositionComponent with CollisionCallbacks{
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
    canvas.drawLine(Offset.zero, Offset(width,0), _paint);
  }
  late ShapeHitbox hitbox;

  @override
  Future<void> onLoad() async {
    hitbox = RectangleHitbox();
    // hitbox.debugMode = true;

    add(hitbox);
  }
  final _collisionColor = Colors.amber;

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints,
      PositionComponent other,
      ) {
    super.onCollisionStart(intersectionPoints, other);
    print('onCollisionStart==========');
    _paint.color = _collisionColor;
  }

  @override
  void onCollisionEnd(PositionComponent other) {
    super.onCollisionEnd(other);
    _paint.color = Colors.white;
    print('onCollisionEnd==========');
  }
}
