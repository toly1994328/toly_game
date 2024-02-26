import 'dart:math';
import 'dart:ui';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart' hide Image;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toly_game/trex/06/ext/hit_box_show.dart';

import 'heroes/fps_text.dart';
import 'heroes/player.dart';
import 'scene/game_over_scene.dart';
import 'scene/running_scene.dart';
import 'scene/waiting_scene.dart';

enum GameState { waiting, running, gameOver }


class TrexGame extends FlameGame with KeyboardEvents, TapCallbacks, HasCollisionDetection {
  double moveSpeed = 0;
  double kInitSpeed = 320;
  final Random random = Random();

  late final Image spriteImage;
  late SharedPreferences sp;

  GameState state = GameState.waiting;
  late RunningScene runningScene;
  final WaitingScene waitingScene = WaitingScene();
  final GameOverScene gameOverScene = GameOverScene();

  @override
  Future<void> onLoad() async {
    spriteImage = await Flame.images.load('trex/trex.png');
    sp = await SharedPreferences.getInstance();
    add(waitingScene);
    add(FpsText());
  }

  @override
  Color backgroundColor() => const Color(0xffffffff);

  @override
  KeyEventResult onKeyEvent(
      KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    /// 俺任意按键开启游戏
    if (state == GameState.waiting) {
      removeWhere((component) => component is WaitingScene);
      startRunningGame();
      return KeyEventResult.handled;
    }

    if (event is RawKeyUpEvent) {
      if (event.logicalKey == LogicalKeyboardKey.arrowDown) {
        runningScene.state = PlayerState.running;
      }
    }

    if (keysPressed.contains(LogicalKeyboardKey.keyI)) {
      toggleHitBoxTree();
    }

    if (keysPressed.contains(LogicalKeyboardKey.arrowDown)) {
      runningScene.state = PlayerState.down;
    }

    if (keysPressed.contains(LogicalKeyboardKey.space)) {
      if (runningScene.state != PlayerState.crashed) {
        runningScene.state = PlayerState.jumping;
      }
    }
    return KeyEventResult.handled;
  }

  void startRunningGame() {
    runningScene = RunningScene();
    add(runningScene);
    moveSpeed = kInitSpeed;
    runningScene.state = PlayerState.running;
    state = GameState.running;
  }

  @override
  void onTapDown(TapDownEvent event) {
    if (state == GameState.waiting) {
      removeWhere((component) => component is WaitingScene);
      startRunningGame();
      return;
    }

    if (state == GameState.gameOver) {
      removeWhere((component) =>
          component is GameOverScene || component is RunningScene);
      startRunningGame();
      return;
    }

    if (runningScene.state == PlayerState.running) {
      if (event.localPosition.x < size.x / 2) {
        runningScene.state = PlayerState.jumping;
      } else {
        runningScene.state = PlayerState.down;
      }
    }
  }

  @override
  void onTapUp(TapUpEvent event) {
    super.onTapUp(event);
    if (event.localPosition.x > size.x / 2) {
      runningScene.state = PlayerState.running;
    }
  }

  void gameOver() {
    moveSpeed = 0;
    runningScene.state = PlayerState.crashed;
    state = GameState.gameOver;
    add(gameOverScene);
    runningScene.scoreComponent.saveHistory();
  }


}
