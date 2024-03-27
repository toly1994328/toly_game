import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import '../bricks_game.dart';

class BrickManager extends PositionComponent with HasGameRef<BricksGame>{

  @override
  FutureOr<void> onLoad() {
    addAll(_createBricks());
    width = 64.0 * 9;
    return super.onLoad();
  }

  List<Brick> _createBricks() {
    List<List<int>> tiles = game.level.tiles;
    List<Brick> bricks = [];
    for (int i = 0; i < tiles.length; i++) {
      List<int> rows = tiles[i];
      for (int j = 0; j < rows.length; j++) {
        if (rows[j] == 1) {
          Brick brick = Brick(j + tiles.length * i);
          brick.x = 64.0 * j;
          brick.y = 32.0 * i;
          bricks.add(brick);
        }
      }
    }
    return bricks;
  }
}

class Brick extends SpriteComponent with HasGameRef<BricksGame> {
  final int index;

  Brick(this.index);

  @override
  FutureOr<void> onLoad() {
    sprite = game.loader['Colored_Blue-64x32.png'];
    add(RectangleHitbox());
    return super.onLoad();
  }

  @override
  void onRemove() {
    super.onRemove();
    game.world.checkSuccess();
  }
}
