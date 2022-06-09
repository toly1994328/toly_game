import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame/particles.dart';
import 'package:flutter/material.dart';

class TolyGame extends FlameGame with PanDetector {
  @override
  Future<void> onLoad() async {
    createParticle();
  }


  void createParticle(){
    final List<Color> colors = [
      const Color(0xffff0000),
      const Color(0xff00ff00),
      const Color(0xff0000ff),
    ];
    final List<Vector2> positions = [
      Vector2(-10, 10),
      Vector2(10, 10),
      Vector2(0, -14),
    ];

    // 创建 Particle 对象
    Particle particle = Particle.generate(
      count: 3,
      lifespan: 3,
      generator: (i) => PaintParticle(
        paint: Paint()..blendMode = BlendMode.difference,
        child:MovingParticle(
        curve: Curves.easeIn,
        from: positions[i],
        to: i == 0 ? positions.last : positions[i - 1],
        child: CircleParticle(
          radius: 20.0,
          paint: Paint()..color = colors[i],
        ),
      ),
    ));

    // 创建 ParticleSystemComponent 构件
    final ParticleSystemComponent psc = ParticleSystemComponent(
      particle: particle,
      position: size/2
    );
    // 添加 ParticleSystemComponent 构件
    add(psc);
  }



  @override
  void onPanEnd(DragEndInfo info) {

  }

  @override
  void onPanStart(DragStartInfo info) {}

  @override
  void onPanDown(DragDownInfo info) {
    createParticle();
  }

  @override
  void onPanUpdate(DragUpdateInfo info) {}
}

class SineCurve extends Curve {
  @override
  double transformInternal(double t) {
    return (sin(pi * (t * 2 - 1 / 2)) + 1) / 2;
  }
}
