import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/image_composition.dart';
import 'package:flame_ext/flame_ext.dart';
import 'package:flutter/material.dart' hide Image;
import 'package:flutter/services.dart';
import 'config/audio_manager/audio_manager.dart';
import 'config/audio_manager/sound_effect.dart';
import 'heroes/ball.dart';

import 'heroes/bricks.dart';
import 'heroes/playground.dart';
import 'heroes/paddle.dart';
import 'heroes/game_top_bar/game_top_bar.dart';

const Size kViewPort = Size(64 * 9, 64 * 9 * 2400 / 1080);

enum GameStatus { playing, ready, gameOver }

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

  GameStatus status = GameStatus.ready;

  AudioManager am = AudioManager();

  late final Image bgImage;

  int blueCrystal = 10;

  void restart() {
    world = PlayWorld();
    status = GameStatus.ready;
  }

  @override
  FutureOr<void> onLoad() async {
    am.startBgm();
    await loader.load(
      'assets/images/break_bricks/break_bricks.json',
      'break_bricks/break_bricks.png',
    );
    bgImage = await Flame.images.load('break_bricks/bg_gallery.png');
    camera.viewfinder.anchor = Anchor.topLeft;
  }

  @override
  Color backgroundColor() => const Color(0xffC5CDDA);

  final double moveStep = 40;

  @override
  KeyEventResult onKeyEvent(
      KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    super.onKeyEvent(event, keysPressed);
    if (event is KeyDownEvent || event is KeyRepeatEvent) {
      switch (event.logicalKey) {
        case LogicalKeyboardKey.arrowLeft:
          world.paddle.moveBy(-moveStep);
        case LogicalKeyboardKey.arrowRight:
          world.paddle.moveBy(moveStep);
          world.paddle.moveBy(moveStep);
      }
    }
    return KeyEventResult.handled;
  }
}

class PlayWorld extends World
    with
        HasGameRef<BricksGame>,
        DragCallbacks,
        HasCollisionDetection,
        TapCallbacks {

  Ball ball = Ball();
  Paddle paddle = Paddle();
  BrickManager brickManager = BrickManager(row: 6);
  GameTopBar titleBar = GameTopBar();
  int _life = 3;

  void gameOver() {
    game.status = GameStatus.gameOver;
    game.am.play(SoundEffect.uiClose);
    game.overlays.add('GameOverMenu');
    ball.removeFromParent();
  }

  void checkSuccess() {
    if (brickManager.children.isEmpty) {
      game.am.play(SoundEffect.uiClose);
      game.overlays.add('GameSuccessMenu');
      game.blueCrystal += 1;
      game.status = GameStatus.gameOver;
    }
  }

  void died() {
    _life -= 1;
    titleBar.updateLifeCount(_life);
    game.status = GameStatus.ready;

    if (_life == 0) {
      gameOver();
    }else{
      changeBallPosition();
    }
  }

  @override
  FutureOr<void> onLoad() async {
    super.onLoad();
    add(Playground());
    add(paddle);
    add(ball);
    add(brickManager);
    add(titleBar);
    initPosition();
    // toggleHitBoxTree();
  }

  void initPosition(){
    brickManager.y = titleBar.height;
    changeBallPosition();
  }

  void changeBallPosition() {
    ball.position = paddle.position +
        Vector2(
          (paddle.width - ball.width) / 2,
          (paddle.height - ball.height) / 2 - paddle.height - 4,
        );
  }

  @override
  void onTapDown(TapDownEvent event) => play();

  void play() {
    if (game.status == GameStatus.ready) {
      ball.run();
      game.status = GameStatus.playing;
    }
  }

  @override
  void onDragUpdate(DragUpdateEvent event) {
    super.onDragUpdate(event);
    double dx = event.localDelta.x;
    double max = kViewPort.width - paddle.width;
    paddle.x = (paddle.x + dx).clamp(0, max);
  }
}
