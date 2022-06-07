import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'components/anim_bullet.dart';
import 'components/hero.dart';
import 'components/line.dart';
import 'components/manager/monster_manager.dart';
import 'components/monster.dart';
import 'components/touch_indicator.dart';

class TolyGame extends FlameGame with HasCollisionDetection,KeyboardEvents, PanDetector {
  late final HeroComponent player;
  final double step = 10;

  void addHero() async {
    List<Sprite> sprites = [];
    for (int i = 0; i <= 8; i++) {
      sprites.add(await loadSprite('adventurer/adventurer-bow-0$i.png'));
    }
    SpriteAnimation animation =
        SpriteAnimation.spriteList(sprites, stepTime: 0.1, loop: false);

    final HeroAttr heroAttr = HeroAttr(
      life: 3000,
      speed: 100,
      attackSpeed: 200,
      attackRange: 200,
      attack: 50,
      crit: 0.75,
      critDamage: 1.5,
    );

    Sprite bulletSprite = await loadSprite('adventurer/weapon_arrow.png');
    SpriteAnimation bulletAnimation = SpriteAnimation.spriteList([bulletSprite], stepTime: 0.1, loop: false);

    player = HeroComponent(
      initPosition: size / 2,
      bulletAnimation: bulletAnimation,
      attr: heroAttr,
      spriteAnimation: animation,
      size: Vector2(50, 37),
    );
    add(player);
  }

  late MonsterManager monsterManager;
  late Line line;

  @override
  Future<void> onLoad() async {
    addHero();
    line = Line(lineWidth: 120,position: size/2-Vector2(140,0));
    add(line);
  }

  @override
  void onPanEnd(DragEndInfo info) {
    if (_lastPointerPos != null) {
      player.toTarget(_lastPointerPos!);
      _lastPointerPos = null;
    }
  }

  @override
  void onPanStart(DragStartInfo info) {

  }

  @override
  void onPanDown(DragDownInfo info) {
    // Vector2 target = info.eventPosition.global;
    // _lastPointerPos = null;
    // add(TouchIndicator(position: target));
    // player.toTarget(target);
  }

  double ds = 0;
  Vector2? _lastPointerPos;

  @override
  void onPanUpdate(DragUpdateInfo info) {
    line.position+=info.delta.global;

    // ds += info.delta.global.length;
    // if (ds > 10) {
    //   _lastPointerPos = info.eventPosition.global;
    //   add(TouchIndicator(position: info.eventPosition.global));
    //   ds = 0;
    // }
  }

  @override
  KeyEventResult onKeyEvent(
    RawKeyEvent event,
    Set<LogicalKeyboardKey> keysPressed,
  ) {
    final isKeyDown = event is RawKeyDownEvent;

    if (event.logicalKey == LogicalKeyboardKey.keyJ && isKeyDown) {
      player.shoot();
    }
    if (event.logicalKey == LogicalKeyboardKey.arrowUp ||
        event.logicalKey == LogicalKeyboardKey.keyW && isKeyDown) {
      player.move(Vector2(0, -step));
    }
    if (event.logicalKey == LogicalKeyboardKey.arrowDown ||
        event.logicalKey == LogicalKeyboardKey.keyS && isKeyDown) {
      player.move(Vector2(0, step));
    }
    if (event.logicalKey == LogicalKeyboardKey.arrowLeft ||
        event.logicalKey == LogicalKeyboardKey.keyA && isKeyDown) {
      player.move(Vector2(-step, 0));
      if (player.isLeft) {
        player.flip();
      }
    }
    if (event.logicalKey == LogicalKeyboardKey.arrowRight ||
        event.logicalKey == LogicalKeyboardKey.keyD && isKeyDown) {
      player.move(Vector2(step, 0));
      if (!player.isLeft) {
        player.flip();
      }
    }
    return super.onKeyEvent(event, keysPressed);
  }
}
