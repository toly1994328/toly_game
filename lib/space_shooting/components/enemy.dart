import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/particles.dart';
import 'package:flutter/material.dart';
import 'bullet.dart';

class Enemy extends SpriteComponent with HasGameRef, CollisionCallbacks {
  double _speed = 250;

  Enemy({
    required Sprite sprite,
  }) : super(sprite: sprite);

  @override
  void onMount(){
    super.onMount();
    double rate = 0.5;
    final ShapeHitbox hitbox = CircleHitbox.relative(rate, parentSize: size,position:size/2-size*rate/2);
    // hitbox.debugMode = true;
    add(hitbox);
  }

  Random _random = Random();

  Vector2 randomVector() {
    Vector2 base = Vector2.random(_random);
    return (base-Vector2.random(_random)) * 500;
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    if(other is Bullet){
      removeFromParent();

      CircleParticle circleParticle = CircleParticle(
        radius: 1,
        lifespan: 1,
        paint: Paint()..color = Colors.white,
      );

      Particle particle = Particle.generate(
        count: 20,
        lifespan: 0.1,
        generator: (i) => AcceleratedParticle(
            child: circleParticle,
            acceleration: randomVector(),
            speed: randomVector(),
            position: position.clone()),
      );

      final ParticleSystemComponent psc =
      ParticleSystemComponent(particle: particle);
      gameRef.add(psc);
    }
  }
  @override
  void update(double dt) {
    super.update(dt);
    position.add(Vector2(0, 1) * _speed * dt);
    if(position.y>gameRef.size.y){
      removeFromParent();
    }
  }

}
