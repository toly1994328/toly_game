import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import '../bricks_game.dart';

class BrickManager extends PositionComponent {
  final int column;
  final int row;

  BrickManager({
    this.column = 9,
    this.row = 6
  });

  @override
  FutureOr<void> onLoad() {
    addAll(_createBricks());
    width = 64.0 * column;
    return super.onLoad();
  }

  List<Brick> _createBricks() {
    List<Brick> bricks = [];
    for (int i = 0; i < row; i++) {
      for (int j = 0; j < column; j++) {
        Brick brick = Brick(j+row*i);
        brick.x = 64.0 * j;
        brick.y = 32.0 *i;
        bricks.add(brick);
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
}
