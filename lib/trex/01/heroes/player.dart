import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import '../trex_game.dart';

enum PlayerState {
  waiting,
  running,
  jumping,
  down,
  crashed,
}

class Player extends SpriteAnimationGroupComponent<PlayerState>
    with HasGameReference<TrexGame>, CollisionCallbacks {
  double get groundYPos {
    return (game.size.y / 2) - height / 2;
  }
  late final TextComponent _helpText;
  late final RectangleHitbox box;
  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    y = groundYPos;
    x = 60;
  }

  void toggleDebugMode(){
    debugMode=!debugMode;
  }

  void toggleState() {
    int nextIndex = (current?.index ?? 0) + 1;
    nextIndex = nextIndex % PlayerState.values.length;
    current = PlayerState.values[nextIndex];
    _helpText.text = current.toString();
  }

  @override
  Future<void> onLoad() async {
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
        frames: [
          Vector2(1782.0 + 100 - 16, 6.0),
          Vector2(1782.0 + 100 - 12 + 114.0, 6.0)
        ],
        stepTime: 0.2,
      ),
    };
    current = PlayerState.waiting;

    _helpText = TextComponent(
      position: Vector2(0,96),
        text: current.toString(),
        textRenderer: TextPaint(
            style: const TextStyle(fontSize: 12, color: Colors.blue)));
    add(_helpText);


    add(TextComponent(
        position: Vector2(0,96+20),
        text: '提示信息:\n'
            '键盘a/点击: 切换恐龙状态\n'
        '键盘 d: 切换展示边框信息'
        ,
        textRenderer: TextPaint(
            style: const TextStyle(fontSize: 12, color: Colors.grey))));
  }

  SpriteAnimation loadAnimation({
    required Vector2 size,
    required List<Vector2> frames,
    double stepTime = double.infinity,
  }) {
    return SpriteAnimation.spriteList(
      frames.map(
            (vector) => Sprite(
              game.spriteImage,
              srcSize: size,
              srcPosition: vector,
            ),
          )
          .toList(),
      stepTime: stepTime,
    );
  }
}
