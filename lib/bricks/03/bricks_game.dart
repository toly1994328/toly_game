import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame_ext/flame_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'heroes/ball.dart';

import 'heroes/bricks.dart';
import 'heroes/playground.dart';
import 'heroes/paddle.dart';

const Size kViewPort = Size(64 * 9, 64 * 9 * 2400 / 1080);

class BricksGame extends FlameGame<PlayWorld>
    with KeyboardEvents, HasCollisionDetection {
  BricksGame()
      : super(
          camera: CameraComponent.withFixedResolution(
            width: kViewPort.width,
            height: kViewPort.height,
          ),
          world: PlayWorld(),
        );

  TextureLoader loader = TextureLoader();
  @override
  FutureOr<void> onLoad() async {
    await loader.load(
      'assets/images/break_bricks/break_bricks.json',
      'break_bricks/break_bricks.png',
    );
    camera.viewfinder.anchor=Anchor.topLeft;
  }

  @override
  Color backgroundColor() => const Color(0xffC5CDDA);

  final double moveStep = 40;

  @override
  KeyEventResult onKeyEvent(KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    super.onKeyEvent(event, keysPressed);
    if (event is KeyDownEvent || event is KeyRepeatEvent) {
      switch (event.logicalKey) {
        case LogicalKeyboardKey.arrowLeft:
          world.paddle.moveBy(-moveStep);
        case LogicalKeyboardKey.arrowRight:
          world.paddle.moveBy(moveStep);
      }
    }

    return KeyEventResult.handled;
  }
}

class PlayWorld extends World with HasGameRef<BricksGame>, DragCallbacks, HasCollisionDetection, TapCallbacks {

  Ball ball = Ball();
  Paddle paddle = Paddle();
  BrickManager brickManager = BrickManager();

  @override
  FutureOr<void> onLoad() async {
    super.onLoad();
    add(Playground());
    add(paddle);
    add(ball);
    add(brickManager);
  }

  @override
  void onTapDown(TapDownEvent event) {
    ball.run();
  }

  @override
  void onDragUpdate(DragUpdateEvent event) {
    super.onDragUpdate(event);
    double dx = event.localDelta.x;
    double max = kViewPort.width - paddle.width;
    paddle.x = (paddle.x + dx).clamp(0, max);
  }
}
