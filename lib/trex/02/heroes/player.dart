import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import '../trex_game.dart';

enum PlayerState {
  waiting, // 等待
  running, // 奔跑
  jumping, // 跳跃
  down, // 趴下
  crashed, // 死亡
}

class Player extends SpriteAnimationGroupComponent<PlayerState> with HasGameReference<TrexGame> {

  double get centerY {
    return (game.size.y / 2) - height / 2;
  }

  bool get active => current == PlayerState.running ||
      current == PlayerState.jumping ||
      current == PlayerState.down;

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    y = centerY;
    x = 60;
  }

  void toggleDebugMode() {
    debugMode = !debugMode;
  }

  void toggleState() {
    int nextIndex = (current?.index ?? 0) + 1;
    nextIndex = nextIndex % PlayerState.values.length;
    current = PlayerState.values[nextIndex];
  }

  void toggleRun() {
    if(current!=PlayerState.running){
      current = PlayerState.running;
    }else{
      current = PlayerState.waiting;
    }
  }

  @override
  Future<void> onLoad() async {
    _initAnimations();
  }

  void _initAnimations(){
    animations = {
      PlayerState.running: loadAnimation(
        size: Vector2(88.0, 90.0),
        frames: [Vector2(1514.0, 4.0), Vector2(1602.0, 4.0)],
        stepTime: 0.2,
      ),
      PlayerState.waiting: loadAnimation(
        size: Vector2(88.0, 90.0),
        frames: [Vector2(76.0, 6.0)],
      ),
      PlayerState.jumping: loadAnimation(
        size: Vector2(88.0, 90.0),
        frames: [Vector2(1338.0, 4.0)],
      ),
      PlayerState.crashed: loadAnimation(
        size: Vector2(88.0, 90.0),
        frames: [Vector2(1778.0, 4.0)],
      ),
      PlayerState.down: loadAnimation(
        size: Vector2(114.0, 90.0),
        frames: [Vector2(1866, 6.0), Vector2(1984, 6.0)],
        stepTime: 0.2,
      ),
    };
    current = PlayerState.waiting;
  }

  SpriteAnimation loadAnimation({
    required Vector2 size,
    required List<Vector2> frames,
    double stepTime = double.infinity,
  }) {
    return SpriteAnimation.spriteList(
      frames.map((vector) => Sprite(
              game.spriteImage,
              srcSize: size,
              srcPosition: vector,
            )).toList(),
      stepTime: stepTime,
    );
  }
}
