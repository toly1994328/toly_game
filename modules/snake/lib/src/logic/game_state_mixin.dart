import 'dart:async';
import 'dart:collection';

import 'package:snake/src/model/player.dart';

import '../model/foods.dart';
import '../model/game_status.dart';
import '../model/snake.dart';
import 'game_render.dart';
import '../model/speed.dart';

sealed class GameEvent {}

class ScoreChangeEvent extends GameEvent {
  final int score;

  ScoreChangeEvent(this.score);
}

class TimeChangeEvent extends GameEvent {
  final int duration;

  TimeChangeEvent(this.duration);
}

class SpeedChangeEvent extends GameEvent {
  final int speed;

  SpeedChangeEvent(this.speed);
}


class StatusChangeEvent extends GameEvent {
  final GameStatus status;

  StatusChangeEvent(this.status);
}


mixin GameStateMixin {

  List<Player> players = [];
  // Queue<SnakeNode> snakeList = Queue();

  List<FoodNode> foodList = [];

  final StreamController<GameEvent> _controller = StreamController.broadcast();
  Stream<GameEvent> get stream => _controller.stream;

  int _score = 0;

  int get score => _score;

  set score(int value) {
    _score = value;
    setSpeed((value~/100)+1);
    emit(ScoreChangeEvent(_score));
  }

  GameStatus _status = GameStatus.ready;

  GameStatus get status => _status;

  set status(GameStatus value) {
    _status = value;
    emit(StatusChangeEvent(value));
  }

  Speed _speed = Speed.initial;

  Speed get speed => _speed;

  void setSpeed(int level) {
    if(speed.level==level) return;
    var (min: min, max: max) = Speed.limit;
    int newSpeed = level.clamp(min, max);
    _speed = Speed.kSupports.firstWhere((e) => e.level == newSpeed);
    emit(SpeedChangeEvent(_speed.level));
  }

  void addScore(int value) {
    score += value;
  }

  double _duration = 0;

  void tickFrameUpdate(double dt) {
    int second = _duration.floor();
    _duration += dt;
    int newSecond = _duration.floor();
    if (newSecond != second) {
      emit(TimeChangeEvent(newSecond));
    }
  }

  void reset() {
    setSpeed(1);
    emit(TimeChangeEvent(0));
    score = 0;
    _duration=0;
  }

  void emit(GameEvent event) {
    _controller.add(event);
  }

  void dispose() {
    _controller.close();
  }
}
