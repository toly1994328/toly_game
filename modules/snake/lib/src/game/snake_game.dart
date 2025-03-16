import 'dart:async';
import 'dart:ui';

import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:snake/src/game/heroes/hud/hud.dart';
import 'package:snake/src/model/configable.dart';
import 'package:snake/src/logic/game_render.dart';
import 'package:snake/src/model/player.dart';
import '../logic/game_state_mixin.dart';
import '../model/foods.dart';
import '../model/game_status.dart';
import 'heroes/ground.dart';
import 'heroes/toolbar/tool_bar.dart';
import '../logic/game_ctrl_mixin.dart';


class SnakeGamePanel extends StatelessWidget {
  const SnakeGamePanel({super.key});

  @override
  Widget build(BuildContext context) {
    return GameWidget(game:  SnakeGame());
  }

}

class SnakeGame extends FlameGame
    with KeyboardEvents, DirectionCtrlMixin, Configable, GameStateMixin, WorldRender
    implements GameOperation {

  Ground ground = Ground();

  @override
  FutureOr<void> onLoad() {
    _initPlayer();
    add(Hud());
    add(ground);
    add(ToolBar());
    reset();
    return super.onLoad();
  }

  void _initPlayer() {
    players.clear();
    players.add(Player(name: 'toly', color: Colors.blue));
    players.add(Player(name: 'ls', color: Colors.lightGreen));
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (status != GameStatus.playing) {
      paused = true;
    }
    tickFrameUpdate(dt);
    tickRender();
  }

  @override
  void onSnakeChange() {
    ground.updateSnake();
  }

  @override
  void onFoodChange(FoodNode food) {
    ground.updateFoods();
  }

  @override
  void onSpaceCtrl() {
    if (status == GameStatus.playing) {
      status = GameStatus.paused;
      Future.delayed(const Duration(milliseconds: 0)).then((_) => paused = false);
    } else {
      if (status == GameStatus.died) {
        reset();
      }
      status = GameStatus.playing;
      paused = false;
    }
  }

  @override
  void onDied(String tips) {
    status = GameStatus.died;
    // $message.warning(message: '游戏结束!$tips', offset: Offset(0, 36));
  }

  @override
  void onEatFood(FoodNode food) {
    addScore(food.score);
  }

  @override
  void onSpeedUp() {
    int level = speed.level;
    setSpeed(level + 1);
  }

  @override
  void onDirectionChange(Direction direction, DirectionType type) {
    if (players.length < 2) return;
    if (type == DirectionType.wasd) {
      bool allow = players[0].checkDirection(direction);
      if(allow) tickRender();
    }
    if (type == DirectionType.arrow) {
      bool allow = players[1].checkDirection(direction);
      if(allow) tickRender();
    }
  }
}
