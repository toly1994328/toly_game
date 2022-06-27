import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/material.dart';

class Rock extends SpriteComponent with HasGameRef, Tappable {
  Rock(Vector2 position)
      : super(
    position: position,
    size: Vector2.all(50),
    priority: 1,
  );

  @override
  Future<void> onLoad() async {
    sprite = await gameRef.loadSprite('nine-box.png');
    paint = Paint()..color = Colors.white;
    add(RectangleHitbox());
  }

  @override
  bool onTapDown(_) {
    add(
      ScaleEffect.by(
        Vector2.all(10),
        EffectController(duration: 0.3),
      ),
    );
    return true;
  }
}
