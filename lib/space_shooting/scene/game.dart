import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame/sprite.dart';
import 'package:toly_game/space_shooting/components/bullet.dart';

import 'package:toly_game/space_shooting/components/enemy.dart';
import 'package:toly_game/space_shooting/manager/enemy_manager.dart';

import '../components/ship.dart';

class SpaceShooting extends FlameGame with TapDetector,PanDetector,HasCollisionDetection  {
  late final Ship ship;
  final double step = 10;
  late final EnemyManager _enemyManager;

  late final SpriteSheet _sheet;
  late final Sprite bulletSprite;

  @override
  Future<void> onLoad() async {
    const String src = 'space_shooting/simpleSpace_tilesheet@2.png';
    await images.load(src);

    Image image = images.fromCache(src);
    _sheet = SpriteSheet.fromColumnsAndRows(image: image, columns: 8, rows: 6);
    ship = Ship(sprite: _sheet.getSpriteById(6));
    bulletSprite = _sheet.getSpriteById(28);

    add(ship);
    _enemyManager = EnemyManager(sheet: _sheet);
    add(_enemyManager);
  }

  @override
  void onTapDown(TapDownInfo info) {
    Bullet bullet = Bullet(sprite: bulletSprite);
    bullet.size = Vector2(64, 64);
    bullet.anchor = Anchor.center;
    bullet.position = ship.position.clone();
    add(bullet);
  }
  @override
  void onPanUpdate(DragUpdateInfo info) {
    ship.move(info.delta.global);
  }
}
