import 'dart:math';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame/sprite.dart';
import 'package:flame_ext/flame_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'components/adventurer.dart';
import 'components/bullet.dart';
import 'components/monster.dart';
import 'components/touch_indicator.dart';

class TolyGame extends FlameGame with KeyboardEvents,PanDetector {
  late final Adventurer player;
  final double step = 10;
  late final Monster monster;
  late final Monster monster2;

  @override
  Future<void> onLoad() async {
    player = Adventurer();
    add(player);

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
    final double pY = size.y/2;
    final double pX = size.x-monsterSize.x/2;
    monster = Monster(
        animation: animation, size: monsterSize, position: Vector2(pX, pY));
    add(monster);
    monster2 = await createMonster2();
    add(monster2);
  }

  Future<Monster> createMonster2() async{
    const String src = 'adventurer/Characters-part-2.png';
    await images.load(src);
    var image = images.fromCache(src);

    SpriteSheet sheet = SpriteSheet.fromColumnsAndRows(
      image: image,
      columns: 9,
      rows: 6,
    );

    List<Sprite> sprites = sheet.getRowSprites(row: 0,start:5,count: 4);
    SpriteAnimation animation = SpriteAnimation.spriteList(
      sprites,
      stepTime: 1 / 10,
      loop: true,
    );

    Vector2 monsterSize = Vector2(32, 48);
    final double pY = size.y/4;
    final double pX = size.x - monsterSize.x / 2-200;

    return Monster(animation: animation, life:200,size: monsterSize, position: Vector2(pX, pY));
  }

  // @override
  // void render(Canvas canvas) {
  //   super.render(canvas);
  //   final Iterable<Bullet> bullets = children.whereType<Bullet>();
  //     if(bullets.isNotEmpty){
  //       canvas.drawCircle(bullets.first.absoluteCenter.toOffset(),5,
  //           Paint()
  //             ..style = PaintingStyle.stroke
  //             ..strokeWidth=1
  //             ..color = Colors.blue);
  //     }
  // }

  @override
  void update(double dt){
    super.update(dt);
    final Iterable<Bullet> bullets = children.whereType<Bullet>();
    for(Bullet bullet in bullets){
      if(bullet.isRemoving){
        continue;
      }
      if(monster.containsPoint(bullet.absoluteCenter)){
        bullet.removeFromParent();
        monster.loss(50);
        break;
      }
      if(monster2.containsPoint(bullet.absoluteCenter)){
        bullet.removeFromParent();
        monster2.loss(50);
        break;
      }
    }
  }


  @override
  void onPanEnd(DragEndInfo info) {
    if(_lastPointerPos!=null){
      player.toTarget(_lastPointerPos!);
      _lastPointerPos = null;
    }
  }

  @override
  void onPanStart(DragStartInfo info) {
    _lastPointerPos=info.eventPosition.global;
  }

  @override
  void onPanDown(DragDownInfo info) {
    Vector2 target = info.eventPosition.global;
    add(TouchIndicator(position: target));
    player.toTarget(target);
  }

  double ds = 0;
  Vector2? _lastPointerPos;

  @override
  void onPanUpdate(DragUpdateInfo info) {
    _lastPointerPos = info.eventPosition.global;
    ds += info.delta.global.length;
    if (ds > 10) {
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
    if (event.logicalKey == LogicalKeyboardKey.keyY && isKeyDown) {
      player.flip(y: true);
    }
    if (event.logicalKey == LogicalKeyboardKey.keyX && isKeyDown) {
      player.flip(x: true);
    }

    if (event.logicalKey == LogicalKeyboardKey.keyJ && isKeyDown) {
      player.shoot();
    }
    if (event.logicalKey == LogicalKeyboardKey.arrowUp
        || event.logicalKey == LogicalKeyboardKey.keyW
            && isKeyDown) {
      player.move(Vector2(0, -step));
    }
    if (event.logicalKey == LogicalKeyboardKey.arrowDown
        || event.logicalKey == LogicalKeyboardKey.keyS
            && isKeyDown) {
      player.move(Vector2(0, step));

    }
    if (event.logicalKey == LogicalKeyboardKey.arrowLeft
        || event.logicalKey == LogicalKeyboardKey.keyA
            && isKeyDown) {
      player.move(Vector2(-step, 0));
    }
    if (event.logicalKey == LogicalKeyboardKey.arrowRight
        || event.logicalKey == LogicalKeyboardKey.keyD
            && isKeyDown) {
      player.move(Vector2(step, 0));
    }
    return super.onKeyEvent(event, keysPressed);
  }

}
