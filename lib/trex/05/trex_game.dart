import 'dart:ui';
import 'package:flame/events.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart' hide Image;

import 'heroes/cloud_component.dart';
import 'heroes/ground_component.dart';
import 'heroes/obstacle_component.dart';
import 'heroes/player.dart';
import 'heroes/score_component.dart';

class TrexGame extends FlameGame
    with KeyboardEvents, TapCallbacks, HasCollisionDetection {
  double moveSpeed = 0;

  late final Image spriteImage;
  late final Player player = Player();
  final ScoreComponent score = ScoreComponent();
  final GroundComponent ground = GroundComponent();
  final CloudManager cloudManager = CloudManager();
  final ObstacleManager obstacleManager = ObstacleManager();

  @override
  Future<void> onLoad() async {
    spriteImage = await Flame.images.load('trex/trex.png');
    add(cloudManager);
    add(ground);
    add(obstacleManager);
    add(player);
    add(score);
  }

  @override
  Color backgroundColor() {
    return const Color(0xffffffff);
  }

  @override
  KeyEventResult onKeyEvent(KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    if (event is KeyUpEvent) {
      if (event.logicalKey == LogicalKeyboardKey.arrowDown) {
        player.state = PlayerState.running;
      }
    }
    if (keysPressed.contains(LogicalKeyboardKey.arrowDown)) {
      player.state = PlayerState.down;
    }
    if (keysPressed.contains(LogicalKeyboardKey.space)) {
      player.state = PlayerState.jumping;
    }
    return KeyEventResult.handled;
  }

  @override
  void onTapDown(TapDownEvent event) {
    if (player.current == PlayerState.waiting) {
      moveSpeed = 320;
      player.state = PlayerState.running;
    }
    if (player.current == PlayerState.running) {
      if (event.localPosition.x < size.x / 2) {
        player.state = PlayerState.jumping;
      } else {
        player.state = PlayerState.down;
      }
    }
  }

  @override
  void onTapUp(TapUpEvent event) {
    super.onTapUp(event);
    if (event.localPosition.x < size.x / 2) {
    } else {
      player.state = PlayerState.running;
    }
  }

  void gameOver() {
    moveSpeed = 0;
    player.current = PlayerState.crashed;
  }
}
