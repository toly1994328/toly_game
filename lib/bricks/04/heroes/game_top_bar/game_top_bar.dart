import 'dart:async';
import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';
import 'package:toly_game/bricks/04/heroes/game_top_bar/level_text.dart';

import '../../bricks_game.dart';
import 'brick_wall.dart';
import 'coin.dart';
import 'home_button.dart';
import 'life.dart';
import 'pause_button.dart';
import 'setting_button.dart';

class GameTopBar extends PositionComponent with HasGameRef<BricksGame> {

  final Coin coin = Coin();
  final Life life = Life(3);
  final HomeButton home = HomeButton();
  final SettingButton setting = SettingButton();
  final PauseButton pause = PauseButton();
  final LevelText levelText = LevelText();

  void updateLifeCount(int count){
    removeWhere((component) => component is Life);
    add(Life(count));
  }

  @override
  FutureOr<void> onLoad() async {
    size = Vector2(kViewPort.width, 320);
    add(BrickWall());
    add(levelText);
    add(coin);
    add(life);
    add(home);
    add(setting);
    add(pause);
    initPosition();
    return super.onLoad();
  }

  void initPosition(){
    final double iconSize = setting.width;
    final double half = (64-iconSize)/2;
    setting..x = width - iconSize - half..y = half;
    pause..x = setting.x-64..y=setting.y;
    home..x = half..y = half;
    coin.x=64;
    levelText..x = width / 2..y = height / 2;
  }
}









