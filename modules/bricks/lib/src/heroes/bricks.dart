import 'dart:async';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import '../bricks_game.dart';

class BrickManager extends PositionComponent with HasGameRef<BricksGame> {
  static const List<String> kPureBricks = [
    "Colored_Blue-64x32.png",
    "Colored_Green-64x32.png",
    "Colored_Yellow-64x32.png",
    "Colored_Purple-64x32.png",
    "Colored_Orange-64x32.png",
  ];

  static const List<String> kWallBricks = [
    "Colored_Blue_Block-64x32.png",
    "Colored_Green_Block-64x32.png",
    "Colored_Yellow_Block-64x32.png",
    "Colored_Purple_Block-64x32.png",
    "Colored_Orange_Block-64x32.png",
  ];

  static const List<String> kTexturedBricks = [
    "Textured_Brick_03-64x32.png",
    "Textured_Brick_02-64x32.png",
    "Textured_Stone_02-64x32.png",
    "Textured_Stone_03-64x32.png",
    "Textured_Brick_04-64x32.png",
  ];

  static const List<List<String>> kTypeBrickList = [
    kPureBricks,
    kWallBricks,
    kTexturedBricks
  ];



  @override
  FutureOr<void> onLoad() {
    priority = 1;
    addAll(_createBricks());
    width = 64.0 * 9;
    return super.onLoad();
  }

  List<Brick> _createBricks() {
    int type = game.random.nextInt(kTypeBrickList.length);
    List<String> srcPool = kTypeBrickList[type];
    List<List<int>> tiles = game.level.tiles;
    List<Brick> bricks = [];
    for (int i = 0; i < tiles.length; i++) {
      List<int> rows = tiles[i];
      for (int j = 0; j < rows.length; j++) {
        if (rows[j] == 1) {
          int index = game.random.nextInt(srcPool.length);
          String src = srcPool[index];
          Brick brick = Brick(j + tiles.length * i, src,i,j);
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
  final int id;
  final int row;
  final int column;
  final String src;

  Brick(this.id, this.src, this.row, this.column);

  @override
  FutureOr<void> onLoad() {
    // priority = 10;
    sprite = game.loader[src];
    add(RectangleHitbox());
    return super.onLoad();
  }

  @override
  void onRemove() {
    super.onRemove();
    game.world.checkSuccess();
  }
}
