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
    // 创建 Particle 对象
    Paint circlePaint = Paint()..color = Colors.white;
    Particle particle = CircleParticle(
      paint: circlePaint,
      radius: 20,
      lifespan: 1,
    );
    // 创建 ParticleSystemComponent 构件
    final ParticleSystemComponent psc = ParticleSystemComponent(
      particle: particle,
      position: size/2
    );
    // 添加 ParticleSystemComponent 构件
    add(psc);
  }

  @override
  void onPanEnd(DragEndInfo info) {}

  @override
  void onPanStart(DragStartInfo info) {}

  @override
  void onPanDown(DragDownInfo info) {
    createParticle();
  }

  @override
  void onPanUpdate(DragUpdateInfo info) {}
}
