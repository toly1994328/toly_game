import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

import '../../bricks_game.dart';


class BrickWall extends PositionComponent with HasGameRef<BricksGame> {
  final int column;
  final int row;

  BrickWall({this.column = 9, this.row = 5});

  @override
  FutureOr<void> onLoad() {
    addAll(_createBricks());
    width = 64.0 * column;
    height = 64.0 * row;
    add(RectangleHitbox());
    return super.onLoad();
  }

  List<SpriteComponent> _createBricks() {
    Sprite sprite = game.loader['texture_metal1.png'];

    List<SpriteComponent> bricks = [];
    for (int i = 0; i < row; i++) {
      for (int j = 0; j < column; j++) {
        if ((i == 0 || i == row - 1) || (j == 0 || j == column - 1)) {
          SpriteComponent brick = SpriteComponent(sprite: sprite);
          brick.x = 64.0 * j;
          brick.y = 64.0 * i;
          bricks.add(brick);
        }
      }
    }
    return bricks;
  }
}