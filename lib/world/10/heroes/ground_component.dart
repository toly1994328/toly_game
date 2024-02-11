import 'dart:collection';
import 'dart:ui';

import 'package:flame/components.dart';
import 'brick_component.dart';
import 'box_component.dart';

class GroundComponent extends PositionComponent {
  Queue<BrickComponent> bricks = Queue();

  Queue<BrickComponent> createBreaksWhenNeed(double winWidth, double brickWidth) {
    int total = (winWidth / brickWidth).ceil();
    int current = bricks.length;

    /// 窗口尺寸变化时需要额外添加的个数
    int addCount = total - current;
    int lastIndex = bricks.isEmpty ? -1 : bricks.last.index;
    double lastX = bricks.isEmpty ? 0 : bricks.last.x;
    Queue<BrickComponent> addBricks = Queue();
    for (int i = 0; i < addCount; i++) {
      int curIndex = lastIndex + 1 + i;
      BrickComponent brick = BrickComponent(index: curIndex);
      brick.x = lastX + brickWidth * i;
      addBricks.add(brick);
    }
    return addBricks;
  }

  double _gameSpeed = 0;

  void run() {
    _gameSpeed = 200;
  }

  @override
  void update(double dt) {
    super.update(dt);
    double dx = _gameSpeed * dt;
    for (final line in bricks) {
      line.x -= dx;
    }
    _handleBreaks();
  }

  final double groundHeight = 12;

  @override
  void onGameResize(Vector2 size) {

    super.onGameResize(size);
    width = size.x;
    height = groundHeight;
    y = size.y - groundHeight - 40;
    Queue<BrickComponent> addBricks = createBreaksWhenNeed(size.x, 300);
    bricks.addAll(addBricks);
    addAll(addBricks);
  }

  void _handleBreaks() {
    double firstPosX = bricks.first.x + bricks.first.brickSize.x;
    if (firstPosX <= 0) {
      remove(bricks.removeFirst());
    }

    double lastPosX = bricks.last.x + bricks.last.brickSize.x;
    if (lastPosX <= width) {
      BrickComponent brick = BrickComponent(index: bricks.last.index + 1);
      brick.x = lastPosX;
      bricks.add(brick);
      add(brick);
    }
  }
}
