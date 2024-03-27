import 'dart:async';

import 'package:flame/components.dart';

import '../../bricks_game.dart';

class Life extends PositionComponent with HasGameRef<BricksGame> {
  final int lifeCount;

  Life(this.lifeCount);

  late Sprite life = game.loader['tile_0044.png'];
  late Sprite lifeOutline = game.loader['tile_0046.png'];

  @override
  FutureOr<void> onLoad() async {
    addAll(createLife());
    position = Vector2(64, 64) + Vector2(8, 8);
    return super.onLoad();
  }

  List<SpriteComponent> createLife() {
    List<SpriteComponent> result = [];
    for (int i = 0; i < 3; i++) {
      SpriteComponent s1 = SpriteComponent(sprite: life)
        ..size = Vector2(36, 36);
      SpriteComponent s2 = SpriteComponent(sprite: lifeOutline)
        ..size = Vector2(36, 36);
      s1.x = 36.0 * i;
      s2.x = 36.0 * i;
      if (i < lifeCount) {
        result.add(s1);
      } else {
        result.add(s2);
      }
    }
    return result;
  }
}
