import 'dart:async';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:snake/snake.dart';
import 'package:snake/src/logic/game_state_mixin.dart';

import 'score.dart';
import 'speed.dart';
import 'time.dart';

class Hud extends PositionComponent with HasGameRef<SnakeGame> {
  StreamSubscription<GameEvent>? _subscription ;
  @override
  void onGameResize(Vector2 size) {
    this.size = Vector2(size.x, 46);
    super.onGameResize(size);
  }

  ScoreHud score = ScoreHud();
  SpeedHud speed = SpeedHud();
  TimeHud time = TimeHud();

  @override
  FutureOr<void> onLoad() {
    size = Vector2(game.size.x, 46);
    add(score);
    add(speed);
    add(time);
    return super.onLoad();
  }

  @override
  void onMount() {
    _subscription = game.stream.listen(_onHudChange);
    super.onMount();
  }


  @override
  void onRemove() {
    _subscription?.cancel();
  }

  void _onHudChange(GameEvent event) {
    if(event is ScoreChangeEvent){
      score.setScore(event.score);
    }
    if(event is SpeedChangeEvent){
      speed.setSpeed(event.speed);
    }
    if(event is TimeChangeEvent){
      time.setScore(event.duration);
    }
  }
}
