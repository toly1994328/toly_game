import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/image_composition.dart';
import 'package:flame_ext/flame_ext.dart';
import 'package:flutter/material.dart' hide Image;
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toly_game/bricks/05/config/game_config.dart';
import 'package:toly_game/bricks/05/model/level.dart';
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

  late AudioManager am;
  late SharedPreferences sp;

  late GameConfigManager configManager;

  GameConfig get config => configManager.config;

  late final Image bgImage;

  // int blueCrystal = 10;

  int _levelNum = 1;

  int get levelCount => _levels.length;

  set levelNum(int level) {
    if (_levelNum != level) {
      _levelNum = level.clamp(1, _levels.length);
      // 设置关卡时，重置砖块管理器
      restart();
    }
  }

  void nextLever() {
    levelNum = _levelNum + 1;
  }

  void restart() {
    world = PlayWorld();
    status = GameStatus.ready;
  }

  List<Level> _levels = [];

  Level get level => _levels[_levelNum - 1];

  Future<void> loadLevels() async {
    String path = 'assets/data/bricks_levels.json';
    String data = await rootBundle.loadString(path);
    List<dynamic> list = json.decode(data) as List;
    _levels = list.map(Level.fromMap).toList();
  }

  @override
  FutureOr<void> onLoad() async {
    sp = await SharedPreferences.getInstance();
    configManager = GameConfigManager(sp);
    configManager.loadConfig(sp);
    am = AudioManager(configManager);
    am.startBgm();
    await loadLevels();
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
      if (status == GameStatus.ready) KeyEventResult.handled;
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

  late BrickManager brickManager = BrickManager();

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

      game.configManager.unlockNextLevel();
      game.configManager.addBlueCrystal();
      // game.blueCrystal += 1;
      game.status = GameStatus.gameOver;
    }
  }

  void died() {
    _life -= 1;
    titleBar.updateLifeCount(_life);
    game.status = GameStatus.ready;

    if (_life == 0) {
      gameOver();
    } else {
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

  void initPosition() {
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
  void onTapDown(TapDownEvent event) {
    play();
  }

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

  @override
  void onDragEnd(DragEndEvent event) {
    super.onDragEnd(event);
    play();
  }
}
