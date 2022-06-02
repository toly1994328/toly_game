import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class Ball extends PositionComponent with HasGameRef {
  final Color color;

  Ball({this.color = Colors.white})
      : super(
          size: Vector2(60, 60),
          anchor: Anchor.center,
        );

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
  }

  final Paint _paint = Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = 1;

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    canvas.translate(size.x / 2, size.y / 2);
    canvas.drawCircle(Offset.zero, size.x / 2, _paint);
  }




  @override
  void update(double dt) {
    super.update(dt);
    v += a * dt;
    position += v * dt;
    Vector2 winSize = gameRef.size;
    //限定下边界
    if (position.y > winSize.y - size.y/2) {
      position.y = winSize.y - size.y/2;
      v.y = -v.y;
    }
    //限定上边界
    if (position.y < size.y/2) {
      position.y = size.y/2;
      v.y = -v.y;
    }

    //限定左边界
    if (position.x < size.x/2) {
      position.x = size.x/2;
      v.x = -v.x;
    }

    //限定右边界
    if (position.x > winSize.x - size.x/2) {
      position.x = winSize.x - size.x/2;
      v.x = -v.x;
    }
  }

  @override
  void onRemove() {
    super.onRemove();
  }

  @override
  void onMount() {
    super.onMount();
  }

  Vector2 v = Vector2.zero(); // 速度 px/s
  Vector2 a = Vector2.zero(); // 加速度 px/s^2

  @override
  Future<void> onLoad() async {
    _paint.color = color;
    position = gameRef.size / 2;
    v = Vector2(80, 50);
  }
}