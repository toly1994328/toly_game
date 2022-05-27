import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import 'package:toly_game/space_shooting/components/enemy.dart';

class EnemyManager extends PositionComponent with HasGameRef{
  final SpriteSheet sheet;
  late Timer _timer;
  final Random _random = Random();

  EnemyManager({required this.sheet}) : super() {
    _timer = Timer(1, onTick: _createEnemy, repeat: true);
  }

  void _createEnemy() {
    // Vector2 size = Vector2(64, 64);
    final double randomX = _random.nextDouble()*gameRef.size.x;
    // final double randomY = _random.nextDouble()*gameRef.size.y;

    Enemy enemy = Enemy(sprite: sheet.getSpriteById(12));
    enemy.size = Vector2(64, 64);
    enemy.position = Vector2(randomX,0);
    enemy.angle = pi;
    enemy.anchor = Anchor.center;

    add(enemy);
  }

  @override
  void onMount() {
    super.onMount();
    _timer.start();
  }

  @override
  void update(double dt) {
    super.update(dt);
    _timer.update(dt);
  }

  @override
  void onRemove() {
    super.onRemove();
    _timer.stop();
  }
}
