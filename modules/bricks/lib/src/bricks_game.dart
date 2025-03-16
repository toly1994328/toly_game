import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/extensions.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/image_composition.dart';
import 'package:flame/particles.dart';
import 'package:flame/sprite.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flame_ext/flame_ext.dart';
import 'package:flutter/material.dart' hide Image;
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'config/audio_manager/audio_manager.dart';
import 'config/audio_manager/sound_effect.dart';
import 'config/game_config.dart';
import 'config/res_manager.dart';
import 'heroes/ball.dart';

import 'heroes/bricks.dart';
import 'heroes/bullet.dart';
import 'heroes/died_line.dart';
import 'heroes/playground.dart';
import 'heroes/paddle.dart';
import 'heroes/game_top_bar/game_top_bar.dart';
import 'heroes/prop/prop.dart';
import 'heroes/prop/prop_display.dart';
import 'heroes/prop/prop_manager.dart';
import 'model/level.dart';
import 'overlays/shop_page/goods.dart';
import 'overlays/shop_page/goods_mamager.dart';

const Size kViewPort = Size(64 * 9, 64 * 9 * 2400 / 1080);

enum GameStatus { playing, ready, gameOver }

class BricksGame extends FlameGame<PlayWorld>
    with KeyboardEvents, HasCollisionDetection {
  ResManager get resManager => ResManager.instance;

  BricksGame()
      : super(
          camera: CameraComponent.withFixedResolution(
            width: kViewPort.width,
            height: kViewPort.height,
          ),
          world: PlayWorld(),
        );

  PaddleType get paddleType => configManager.config.paddleType;

  void switchPaddle(String src) {
    PaddleType type = PaddleType.values.singleWhere((e) => e.src == src);
    configManager.switchPaddleType(type);
    world.paddle.switchType(src);
  }

  List<PaddleType> get buyPaddles => configManager.config.activePaddles
      .map((e) => PaddleType.values[e])
      .toList();

  List<String> get buyPaddleSrcs => buyPaddles.map((e) => e.src).toList();

  List<Goods> get buyPaddleGoods => goodsManager
      .goods(GoodsType.paddle)
      .where((e) => buyPaddleSrcs.contains(e.src))
      .toList();

  GameStatus status = GameStatus.ready;

  late AudioManager am;

  SharedPreferences get sp => resManager.sp;

  GameConfigManager get configManager => resManager.configManager;

  TextureLoader get loader => resManager.loader;

  GoodsManager get goodsManager => resManager.goodsManager;

  GameConfig get config => configManager.config;

  // int blueCrystal = 10;

  int _levelNum = 1;

  int get levelCount => levels.length;

  final Random _random = Random();

  Random get random => _random;

  // value: 概率 0~1
  bool probability(double value) {
    double rad = random.nextDouble();
    return rad < value;
  }

  set levelNum(int level) {
    if (_levelNum != level) {
      _levelNum = level.clamp(1, levels.length);
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

  List<Level> get levels => resManager.levels;

  Level get level => levels[_levelNum - 1];

  @override
  FutureOr<void> onLoad() async {
    _levelNum = configManager.config.maxUnLockLevel;
    FlameAudio.updatePrefix('packages/bricks/assets/audio/');
    am = AudioManager(configManager);
    am.startBgm();
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

  void getCoin() {
    configManager.addCoin();
    world.titleBar.coin.updateCoin();
  }

  void buy(Goods goods) {
    if (configManager.config.coin < (goods.coin ?? 0)) {
      // Toast.error('当前金币不足!');
      return;
    }

    if (goods.type == GoodsType.paddle) {
      String src = goods.src;
      PaddleType type = PaddleType.values.singleWhere((e) => e.src == src);
      configManager.buyPaddleSuccess(type);
    } else {
      configManager.saveGoodsToPackage(goods);
    }
    configManager.addCoin(count: -(goods.coin ?? 0));
    world.titleBar.coin.updateCoin();
  }

  bool get hasHomePage => overlays.isActive('HomePage');

  void useGoods(Goods goods) async {
    configManager.useGoodsInPackage(goods);

    if (goods.type == GoodsType.rune) {
      //减少道具数
      //击碎砖块
      List<Brick> bricks = world.brickManager.children
          .whereType<Brick>()
          .where((b) => b.src == goods.src)
          .toList();
      for (Brick brick in bricks) {
        world.onBrickWillRemove(brick);
      }
    }

    if (goods.type == GoodsType.function) {
      if (goods.src == 'prop_show_5s.png') {
        world.propManager.priority = 10;
        await Future.delayed(const Duration(seconds: 3));
        world.propManager.priority = 0;
      }

      if (goods.src == 'prop_random.png') {
        int index = random.nextInt(Prop.values.length);
        PropComponent prop = PropComponent(Prop.values[index]);
        prop.position = Vector2(kViewPort.width / 2, 300);
        world.add(prop);
        prop.fall();
      }
    }
  }
}

class PlayWorld extends World
    with
        HasGameRef<BricksGame>,
        DragCallbacks,
        HasCollisionDetection,
        TapCallbacks {
  Paddle paddle = Paddle();

  late BrickManager brickManager = BrickManager();
  BulletManager bulletManager = BulletManager();
  late PropManager propManager = PropManager();

  GameTopBar titleBar = GameTopBar();
  int _life = 3;

  void gameOver() {
    game.status = GameStatus.gameOver;
    game.am.play(SoundEffect.uiClose);
    game.overlays.add('GameOverMenu');
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

  void addLife() {
    _life += 1;
    titleBar.updateLifeCount(_life);
  }

  /// 是否处于 无敌状态
  bool get isInvincible =>
      displays.where((e) => e.prop == Prop.invincible).isNotEmpty;

  /// 是否处于 射击状态
  bool get isShoot => displays.where((e) => e.prop == Prop.shoot).isNotEmpty;

  List<PropDisplay> get displays => children.whereType<PropDisplay>().toList();

  void addPropDisplay(Prop pro) {
    /// 没有道具展示时，添加 PropDisplay
    if (displays.isEmpty) {
      PropDisplay display = PropDisplay(pro);
      display.position = Vector2(360, 86);
      add(display);
      return;
    }

    /// 表示已经存在展示的道具
    List<PropDisplay> targets = displays.where((e) => e.prop == pro).toList();
    if (targets.isNotEmpty) {
      /// 已存当前道具效力, + 生命时间
      displays.first.addOne();
      return;
    } else {
      /// 有没有，则在之后加一个
      PropDisplay display = PropDisplay(pro);
      display.position =
          displays.last.position + Vector2(displays.last.width + 8, 0);
      add(display);
    }
  }

  void died() {
    _life -= 1;
    titleBar.updateLifeCount(_life);
    game.status = GameStatus.ready;

    if (_life == 0) {
      gameOver();
    } else {
      addBall();
    }
  }

  @override
  FutureOr<void> onLoad() async {
    super.onLoad();
    add(Playground());
    add(paddle);
    addBall();
    add(brickManager);
    add(propManager);
    add(bulletManager);
    add(titleBar);
    add(DiedLine());

    initPosition();
    // toggleHitBoxTree();
    add(FpsTextComponent()
      ..y = kViewPort.height - 42
      ..x = 12);
  }

  void initPosition() {
    brickManager.y = titleBar.height;
    propManager.y = titleBar.height;
  }

  @override
  void onTapDown(TapDownEvent event) {
    play();
  }

  void play() {
    if (game.status == GameStatus.ready) {
      List<Ball> balls = children.whereType<Ball>().toList();
      if (balls.isNotEmpty) {
        balls.first.run();
        if (game.paddleType == PaddleType.azure) {
          Future.delayed(const Duration(milliseconds: 200)).then((value) {
            addBall(autoPlay: true);
          });
        }
        game.status = GameStatus.playing;
      }
    }
  }

  @override
  void onDragUpdate(DragUpdateEvent event) {
    super.onDragUpdate(event);
    double dx = event.localDelta.x;
    double max = kViewPort.width - paddle.width / 2;
    paddle.x = (paddle.x + dx).clamp(paddle.width / 2, max);
  }

  @override
  void onDragEnd(DragEndEvent event) {
    super.onDragEnd(event);
    play();
  }

  void addBall({bool autoPlay = false}) {
    Ball ball = Ball();
    ball.anchor = Anchor.bottomCenter;
    add(ball);
    ball.position = paddle.center - Vector2(0, paddle.height / 2 + 4);
    if (autoPlay) {
      ball.run();
    }
  }

  void createCoin(Vector2 position) {
    double probability = 0.20;
    if (game.paddleType == PaddleType.yellow) {
      probability += 0.1;
    }
    if (game.probability(probability)) {
      CoinComponent coin = CoinComponent(position: position);
      add(coin);
    }
  }

  int _breakCount = 0;

  void onBrickWillRemove(Brick brick) {
    _breakCount++;
    if (_breakCount == 10) {
      handlePaddleEffect(brick);
      _breakCount = 0;
    }
    brick.removeFromParent();
    propManager.fallOrNot(brick.id);
    Vector2 brickCenter = brick.absolutePosition + brick.size / 2;
    createCoin(brickCenter);
    game.am.play(SoundEffect.uiSelect);
    showBoomParticle(brickCenter);
  }

  void handlePaddleEffect(Brick brick) async {
    if (game.paddleType == PaddleType.blue) {
      List<Brick> bricks = brickManager.children
          .whereType<Brick>()
          .where((b) => b.column == brick.column)
          .toList();
      for (Brick brick in bricks) {
        onBrickWillRemove(brick);
      }
    }

    if (game.paddleType == PaddleType.red) {
      List<Brick> bricks = brickManager.children
          .whereType<Brick>()
          .where((b) => b.row == brick.row)
          .toList();
      for (Brick brick in bricks) {
        onBrickWillRemove(brick);
      }
    }

    if (game.paddleType == PaddleType.purple) {
      Vector2 position = brick.absolutePosition + brick.size / 2;
      await Future.delayed(const Duration(milliseconds: 100));
      int index = game.random.nextInt(Prop.values.length);
      PropComponent prop = PropComponent(Prop.values[index]);
      prop.position = position;
      add(prop);
      prop.fall();
    }
  }

  void showBoomParticle(Vector2 position) {
    final List<Sprite> spriteList = [];
    for (int i = 1; i <= 14; i++) {
      String name = 'TCSY_000${i.toString().padLeft(2, '0')}.png';
      spriteList.add(game.loader[name]);
    }

    SpriteAnimation sa =
        SpriteAnimation.spriteList(spriteList, stepTime: 0.1, loop: false);

    add(
      ParticleSystemComponent(
          position: position,
          particle: SpriteAnimationParticle(
            lifespan: spriteList.length * 0.05,
            animation: sa,
          )),
    );
  }
}
