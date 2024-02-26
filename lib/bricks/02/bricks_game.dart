import 'dart:async';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame_ext/flame_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:toly_game/trex/06/ext/hit_box_show.dart';
import 'package:toly_game/trex/06/heroes/fps_text.dart';
import 'heroes/ball.dart';

import 'heroes/bricks.dart';
import 'heroes/playground.dart';
import 'heroes/paddle.dart';

class BricksGame extends FlameGame
    with DragCallbacks, KeyboardEvents, HasCollisionDetection,TapCallbacks {
  TextureLoader loader = TextureLoader();
  double get width => size.x;
  double get height => size.y;

  // Brick brick = Brick();
  Ball ball = Ball();
  Paddle paddle = Paddle();
  BrickManager brickManager = BrickManager();

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    brickManager.x = (size.x - brickManager.width) / 2;
    // brick.y = 20;

    paddle.x = size.x / 2 - paddle.width / 2;
    paddle.y = size.y - paddle.height - 20;

  }

  @override
  FutureOr<void> onLoad() async {
    super.onLoad();
    await loader.load(
      'assets/images/break_bricks/break_bricks.json',
      'break_bricks/break_bricks.png',
    );
    add(Playground());
    add(FpsText());
    add(paddle);
    add(ball);
    add(brickManager);
    // toggleHitBoxTree();

  }

  final double moveStep = 40;

  @override
  KeyEventResult onKeyEvent(KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    super.onKeyEvent(event, keysPressed);

    if (event is KeyDownEvent || event is KeyRepeatEvent) {
      switch (event.logicalKey) {
        case LogicalKeyboardKey.arrowLeft:
          paddle.moveBy(-moveStep);
        case LogicalKeyboardKey.arrowRight:
          paddle.moveBy(moveStep);
      }
    }

    return KeyEventResult.handled;
  }

  @override
  void onTapDown(TapDownEvent event) {
    print("=====onTapDown=============");
    ball.run();
  }

  @override
  void onDragUpdate(DragUpdateEvent event) {
    super.onDragUpdate(event);
    double dx = event.localDelta.x;
    double max = width - paddle.width;
    paddle.x = (paddle.x + dx).clamp(0, max);
  }
}
