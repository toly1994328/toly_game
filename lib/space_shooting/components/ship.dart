import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/game.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/services.dart';

class Ship extends SpriteComponent with HasGameRef {

  Ship({required Sprite sprite}) : super(sprite: sprite);

  @override
  Future<void> onLoad() async {
    super.onLoad();
    size = Vector2(64, 64);
    anchor = Anchor.center;
    position = gameRef.size / 2;
  }

  void move(Vector2 ds){
    position.add(ds);
  }

}
