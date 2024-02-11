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

class TrexGame extends FlameGame with KeyboardEvents, TapCallbacks, HasCollisionDetection  {
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
  KeyEventResult onKeyEvent(
    RawKeyEvent event,
    Set<LogicalKeyboardKey> keysPressed,
  ) {

    if (event is RawKeyUpEvent) {
      if(event.logicalKey==LogicalKeyboardKey.arrowDown){
        player.running();
      }
    }
    if (keysPressed.contains(LogicalKeyboardKey.keyI)) {
      print("======obstacleManager:${obstacleManager.children.length}=====cloudManager:${cloudManager.children.length}========");
    }
    if (keysPressed.contains(LogicalKeyboardKey.arrowDown)) {
      player.down();
    }
    if (keysPressed.contains(LogicalKeyboardKey.keyD)) {
      player.toggleDebugMode();
    }
    if (keysPressed.contains(LogicalKeyboardKey.space)) {
      player.jump();
    }
    return KeyEventResult.handled;
  }



  @override
  void onTapDown(TapDownEvent event) {
    moveSpeed = 320;
    // player.toggleState();
    // ground.run();
  }

  void gameOver() {
    moveSpeed = 0;
    player.current = PlayerState.crashed;
  }
}
