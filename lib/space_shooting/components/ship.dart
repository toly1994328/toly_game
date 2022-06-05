import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/game.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/services.dart';
import 'package:toly_game/space_shooting/components/enemy.dart';

class Ship extends SpriteComponent with HasGameRef,CollisionCallbacks {

  Ship({required Sprite sprite}) : super(sprite: sprite);


  @override
  void render(Canvas canvas){
    super.render(canvas);
    renderDebugMode(canvas);
  }

  @override
  Future<void> onLoad() async {
    super.onLoad();
    size = Vector2(64, 64);
    anchor = Anchor.center;
    position = gameRef.size / 2;
  }


  @override
  void onMount(){
    super.onMount();
    final ShapeHitbox hitbox = CircleHitbox();
    hitbox.debugMode = true;
    add(hitbox);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    if(other is Enemy){
      // removeFromParent();
      print('====Enemy==hit==Ship==');
    }
  }

  void move(Vector2 ds){
    position.add(ds);
  }

}
