import 'dart:async';

import 'package:flame/components.dart';
import '../trex_game.dart';
import '../heroes/player.dart';
import '../heroes/score_component.dart';
import '../heroes/ground_component.dart';
import '../heroes/cloud_component.dart';
import '../heroes/obstacle_component.dart';

class RunningScene extends PositionComponent with HasGameReference<TrexGame> {
  final Player player = Player();
  final ScoreComponent scoreComponent = ScoreComponent();
  final GroundComponent ground = GroundComponent();
  final CloudManager cloudManager = CloudManager();
  final ObstacleManager obstacleManager = ObstacleManager();

  @override
  FutureOr<void> onLoad() {
    add(cloudManager);
    add(ground);
    add(obstacleManager);
    add(player);
    add(scoreComponent);
    return super.onLoad();
  }

  set state(PlayerState newState) {
    player.state = newState;
  }

  int get score => scoreComponent.score;

  PlayerState get state => player.current ?? PlayerState.waiting;
}
