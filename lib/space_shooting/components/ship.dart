import 'dart:math';
import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/game.dart';
import 'package:flame/particles.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';
import 'package:toly_game/space_shooting/components/enemy.dart';

class Ship extends SpriteComponent with HasGameRef,CollisionCallbacks {

  Ship({required Sprite sprite}) : super(sprite: sprite);

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
    // hitbox.debugMode = true;
    add(hitbox);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    if (other is Enemy) {
      // removeFromParent();
      print('====Enemy==hit==Ship==');
    }
  }

  void move(Vector2 ds) {
    position.add(ds);
  }

  Random _random = Random();

  Vector2 randomVector() {
    Vector2 base = Vector2.random(_random);
    return (base+Vector2(-0.5,1)) * 300;
  }

  @override
  void update(double dt) {
    super.update(dt);
    CircleParticle circleParticle = CircleParticle(
      radius: 1,
      lifespan: 1,
      paint: Paint()..color = Colors.white,
    );

    Particle particle = Particle.generate(
      count: 10,
      lifespan: 0.1,
      generator: (i) => AcceleratedParticle(
          child: circleParticle,
          acceleration: randomVector(),
          speed: randomVector(),
          position: position + Vector2(0,size.y/3)),
    );

    final ParticleSystemComponent psc =
        ParticleSystemComponent(particle: particle);
    gameRef.add(psc);
  }
}
