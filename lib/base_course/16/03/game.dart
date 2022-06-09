import 'dart:math';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame/particles.dart';
import 'package:flutter/material.dart';

class TolyGame extends FlameGame with TapDetector, PanDetector {

  @override
  void onPanDown(DragDownInfo info) {
    createParticle(info.eventPosition.global);
  }

  double ds = 0;

  @override
  void onPanUpdate(DragUpdateInfo info) {
    // add(TouchIndicator(position: info.eventPosition.global));
    // ds += info.delta.global.length;
    // if (ds > 10) {
    //   createParticle(info.eventPosition.global);
    //   ds = 0;
    // }
  }

  Color randomColor(){
    return Color.fromARGB(255, _random.nextInt(255),  _random.nextInt(255),  _random.nextInt(255));
  }

  final Random _random = Random();

  Vector2 randomVector() {
    Vector2 base = Vector2.random(_random); //  (0, 0) ~ (1, 1)
    Vector2 fix = Vector2(-0.5,-0.5);
    base = base + fix; //  (-0.5, -0.5) ~ (0.5, 0.5)
    return base * 200;

    // Vector2 base = Vector2.random(_random); //  (0, 0) ~ (1, 1)
    // Vector2 fix = Vector2(-0.5,0);
    // base = base + fix; // (-0.5, 0) ~ (0.5, 1)
    // return base * 200;
  }

  void createParticle(Vector2 position) {
    CircleParticle circleParticle = CircleParticle(
      radius: 1,
      paint: Paint()..color = randomColor(),
    );

    Particle particle = Particle.generate(
      count: 20,
      lifespan: 1,
      generator: (i) =>
          AcceleratedParticle(
              child: circleParticle,
              acceleration: randomVector(),
              speed: randomVector(),
              position: position),
    );

    final ParticleSystemComponent psc =
    ParticleSystemComponent(particle: particle);
    add(psc);
  }

}
