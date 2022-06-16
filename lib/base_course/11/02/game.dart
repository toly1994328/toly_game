import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame/sprite.dart';
import 'package:flame_ext/flame_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'components/bullet.dart';
import 'components/hero.dart';
import 'components/monster.dart';
import 'components/touch_indicator.dart';

class TolyGame extends FlameGame with KeyboardEvents, PanDetector {
  late final HeroComponent player;
  late final HeroComponent player1;
  final double step = 10;
  late final Monster monster;
  late final Monster monster2;
  late final Monster monster3;

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

    player = HeroComponent(
      initPosition: size / 2,
      attr: heroAttr,
      spriteAnimation: animation,
      size: Vector2(50, 37),
    );

    add(player);
  }

  void addHero2() async {
    const String src = 'adventurer/Characters-part-2.png';
    await images.load(src);
    var image = images.fromCache(src);

    SpriteSheet sheet = SpriteSheet.fromColumnsAndRows(
      image: image,
      columns: 9,
      rows: 6,
    );

    List<Sprite> sprites = sheet.getRowSprites(row: 0, start: 0, count: 5);
    SpriteAnimation animation = SpriteAnimation.spriteList(
      sprites,
      stepTime: 1 / 10,
      loop: true,
    );

    final HeroAttr heroAttr = HeroAttr(
      life: 2000,
      speed: 100,
      attackSpeed: 200,
      attackRange: 200,
      attack: 100,
      crit: 0.75,
      critDamage: 1.5,
    );

    player1 = HeroComponent(
      initPosition: size / 2 - Vector2(100,0),
      attr: heroAttr,
      spriteAnimation: animation,
      size: Vector2(32, 48),
    );

    add(player1);
  }

  @override
  Future<void> onLoad() async {
    addHero();
    addHero2();
    const String src = 'adventurer/animatronic.png';
    await images.load(src);
    var image = images.fromCache(src);
    SpriteSheet sheet = SpriteSheet.fromColumnsAndRows(
      image: image,
      columns: 13,
      rows: 6,
    );

    SpriteAnimation animation = SpriteAnimation.spriteList(
      sheet.getSprites(),
      stepTime: 1 / 24,
      loop: true,
    );

    Vector2 monsterSize = Vector2(64, 64);
    final double pY = size.y / 2;
    final double pX = size.x - monsterSize.x / 2;
    monster = Monster(
        animation: animation, size: monsterSize, position: Vector2(pX, pY));
    add(monster);
    monster2 = await createMonster(
        Vector2(size.x - monsterSize.x / 2 - 200, size.y / 4));
    add(monster2);

    monster3 =
        await createMonster(Vector2(monsterSize.x / 2 + 50, size.y / 4));
    add(monster3);
  }

  Future<Monster> createMonster(Vector2 pos) async {
    const String src = 'adventurer/Characters-part-2.png';
    await images.load(src);
    var image = images.fromCache(src);

    SpriteSheet sheet = SpriteSheet.fromColumnsAndRows(
      image: image,
      columns: 9,
      rows: 6,
    );

    List<Sprite> sprites = sheet.getRowSprites(row: 0, start: 5, count: 4);
    SpriteAnimation animation = SpriteAnimation.spriteList(
      sprites,
      stepTime: 1 / 10,
      loop: true,
    );

    Vector2 monsterSize = Vector2(32, 48);

    return Monster(
        animation: animation, life: 200, size: monsterSize, position: pos);
  }

  @override
  void update(double dt) {
    super.update(dt);
    final Iterable<Bullet> bullets = children.whereType<Bullet>();
    for (Bullet bullet in bullets) {
      if (bullet.isRemoving) {
        continue;
      }
      if (monster.containsPoint(bullet.absoluteCenter)) {
        bullet.removeFromParent();
        monster.loss(player.attr);
        break;
      }
      if (monster2.containsPoint(bullet.absoluteCenter)) {
        bullet.removeFromParent();
        monster2.loss(player.attr);
        break;
      }
      if (monster3.containsPoint(bullet.absoluteCenter)) {
        bullet.removeFromParent();
        monster3.loss(player.attr);
        break;
      }
    }
  }

  @override
  void onPanEnd(DragEndInfo info) {
    if (_lastPointerPos != null) {
      player.toTarget(_lastPointerPos!);
      _lastPointerPos = null;
    }
  }

  @override
  void onPanStart(DragStartInfo info) {}

  @override
  void onPanDown(DragDownInfo info) {
    Vector2 target = info.eventPosition.global;
    _lastPointerPos = null;
    add(TouchIndicator(position: target));
    player.toTarget(target);
  }

  double ds = 0;
  Vector2? _lastPointerPos;

  @override
  void onPanUpdate(DragUpdateInfo info) {
    ds += info.delta.global.length;
    if (ds > 10) {
      _lastPointerPos = info.eventPosition.global;
      add(TouchIndicator(position: info.eventPosition.global));
      ds = 0;
    }
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
