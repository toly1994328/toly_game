import 'dart:collection';
import 'dart:math';

import 'package:snake/src/model/configable.dart';
import 'package:snake/src/logic/game_state_mixin.dart';
import 'package:snake/src/model/player.dart';

import 'game_ctrl_mixin.dart';
import '../model/foods.dart';
import '../model/game_status.dart';
import '../model/snake.dart';

mixin WorldRender on Configable, GameStateMixin {
  void onSnakeChange();

  void onDied(String tips);

  void onFoodChange(FoodNode food);

  void onEatFood(FoodNode food);

  int _timeRecord = 0;

  void tickRender() {
    if (status != GameStatus.playing) return;
    int cur = DateTime.now().millisecondsSinceEpoch;
    bool timeSkip = cur - _timeRecord < speed.time;
    if (timeSkip) return;
    for (int i = 0; i < players.length; i++) {
      Player player = players[i];
      move(player, player.lastDirection);
    }
    _checkPlayerAttack();
    onSnakeChange();
    _timeRecord = cur;
  }

  void move(Player player, Direction direction) {
    Queue<SnakeNode> snakeList = player.snakeList;
    Point<int> oldHead = snakeList.first.position;
    Point<int> newHead = switch (direction) {
      Direction.up => Point(oldHead.x, oldHead.y - 1),
      Direction.down => Point(oldHead.x, oldHead.y + 1),
      Direction.left => Point(oldHead.x - 1, oldHead.y),
      Direction.right => Point(oldHead.x + 1, oldHead.y),
    };
    if (!_checkAlive(snakeList, newHead)) {
      onDied(' [Player: ${player.name}] Loss!');
      return;
    }
    int foodIndex = foodList.indexWhere((e) => e.position == newHead);
    updateSnakeAttr(snakeList);
    if (foodIndex != -1) {
      FoodNode food = foodList.removeAt(foodIndex);
      snakeList.addFirst(SnakeNode(position: newHead));
      snakeList.last.color = food.color;
      onEatFood(food);
      createFoods(1);
    } else {
      snakeList.addFirst(SnakeNode(position: newHead));
      snakeList.removeLast();
    }
  }

  /// 将后元素的属性，赋值给前一元素
  void updateSnakeAttr(
    Queue<SnakeNode> snakeList,
  ) {
    List<SnakeNode> snake = snakeList.toList();
    for (int i = 0; i < snake.length - 1; i++) {
      snake[i].color = snake[i + 1].color;
    }
  }

  bool _checkAlive(Queue<SnakeNode> snakeList, Point<int> head) {
    bool selfLoop = snakeList.skip(1).where((e) => e.position == head).isNotEmpty;
    bool outRange = head.x < 0 || head.y < 0 || head.x >= column || head.y >= row;
    return !(outRange || selfLoop);
  }

  @override
  void reset() {
    super.reset();
    resetPlayer();
    onSnakeChange();
    foodList.clear();
    createFoods(4);
  }

  void resetPlayer() {
    int step = column ~/ (players.length + 1);
    int initY = row ~/ 2;

    for (int i = 0; i < players.length; i++) {
      Point<int> point = Point(step * (i + 1), initY);
      players[i].reset(point);
    }
  }

  void createFoods(int count) {
    Random random = Random();

    Set<Point> exist = {...foodList.map((e) => e.position)};

    for (Player player in players) {
      exist.addAll(player.snakeList.map((e) => e.position));
    }

    Set<Point<int>> foodPositionPool = {};
    for (int i = 0; i < column; i++) {
      for (int j = 0; j < row; j++) {
        foodPositionPool.add((Point(i, j)));
      }
    }
    foodPositionPool = foodPositionPool.difference(exist);
    for (int i = 0; i < count; i++) {
      Point<int> position = foodPositionPool.toList()[random.nextInt(foodPositionPool.length)];
      foodList.add(
        FoodNode(
            color: kColorSupport[random.nextInt(kColorSupport.length)],
            position: position,
            score: 20 + random.nextInt(40)),
      );
      foodPositionPool.remove(position);
    }
    onFoodChange(foodList.first);
  }

  /// 校验玩家间碰撞
  /// 头部是否碰撞到其他玩家
  void _checkPlayerAttack() {
    List<String> lossPlayer = [];
    for (Player player in players) {
      List<Player> others = players.where((e) => e != player).toList();
      SnakeNode head = player.snakeList.first;
      for (Player other in others) {
        if (other.snakeList.map((e) => e.position).contains(head.position)) {
          lossPlayer.add(player.name);
        }
      }
    }
    if(lossPlayer.isNotEmpty){
      onDied('${lossPlayer.join(',')} Loss!');
    }
  }
}
