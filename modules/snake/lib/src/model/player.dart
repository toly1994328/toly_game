import 'dart:collection';
import 'dart:math';
import 'dart:ui';

import 'package:snake/src/model/snake.dart';

import '../logic/game_ctrl_mixin.dart';

class Player {
  final String name;
  final Color color;

  Player({
    required this.name,
    required this.color,
  });

  Queue<SnakeNode> snakeList = Queue();

  Direction lastDirection = Direction.up;

  void reset(Point<int> point,{int count = 3}){
    snakeList.clear();
    lastDirection = Direction.up;
    for (int i = 0; i < count; i++) {
      Point<int> position = Point<int>(point.x, point.y+ i);
      snakeList.add(SnakeNode(position: position));
    }
  }

  bool checkDirection(Direction direction) {
    bool allow = lastDirection.opposite != direction;
    if (allow) {
      lastDirection = direction;
    }
    return allow;
  }
}
