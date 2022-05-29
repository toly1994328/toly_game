import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class Monster extends SpriteAnimationComponent {
  Monster({
    required SpriteAnimation animation,
    required Vector2 size,
    required Vector2 position,
  }) : super(
          animation: animation,
          size: size,
          position: position,
          anchor: Anchor.center,
        );

  Paint _outlinePaint = Paint();
  Paint _fillPaint = Paint();

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    Color lifeColor = Colors.red;
    Color outlineColor = Colors.white;
    final double offsetY = 10; // 血条距构件顶部偏移量
    final double widthRadio = 1.5; // 血条/构件宽度
    final double lifeBarHeight = 4; // 血条高度
    final double lifeProgress = 0.8; // 当前血条百分百

    Rect rect = Rect.fromCenter(
        center: Offset(size.x / 2, lifeBarHeight / 2 - offsetY),
        width: size.x / 2 * widthRadio,
        height: lifeBarHeight);

    Rect lifeRect = Rect.fromPoints(
        rect.topLeft + Offset(rect.width * (1 - lifeProgress), 0),
        rect.bottomRight);

    _outlinePaint
      ..color = outlineColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    _fillPaint.color = lifeColor;

    canvas.drawRect(lifeRect, _fillPaint);
    canvas.drawRect(rect, _outlinePaint);
  }

  @override
  Future<void> onLoad() async {
    // add(RectangleHitbox()..debugMode = true);
  }

  double _speed = 50;

  @override
  void update(double dt) {
    super.update(dt);
    Vector2 ds = Vector2(-1, 0) * _speed * dt;
    move(ds);
    if (position.x + size.x / 2 < 0) {
      removeFromParent();
    }
  }

  void move(Vector2 ds) {
    position.add(ds);
  }
}
