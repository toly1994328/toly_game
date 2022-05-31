import 'dart:math';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'components/adventurer.dart';

class TolyGame extends FlameGame with KeyboardEvents {
  late final Adventurer player;
  final double step = 10;

  @override
  Future<void> onLoad() async {
    player = Adventurer();
    add(player);
  }

  @override
  KeyEventResult onKeyEvent(
      RawKeyEvent event,
      Set<LogicalKeyboardKey> keysPressed,
      ) {
    final isKeyDown = event is RawKeyDownEvent;
    if (event.logicalKey == LogicalKeyboardKey.keyY && isKeyDown) {
      player.flip(y: true);
    }
    if (event.logicalKey == LogicalKeyboardKey.keyX && isKeyDown) {
      player.flip(x: true);
    }

    if (event.logicalKey == LogicalKeyboardKey.keyJ && isKeyDown) {
      player.shoot();
    }
    if (event.logicalKey == LogicalKeyboardKey.arrowUp
        || event.logicalKey == LogicalKeyboardKey.keyW
            && isKeyDown) {
      player.move(Vector2(0, -step));
    }
    if (event.logicalKey == LogicalKeyboardKey.arrowDown
        || event.logicalKey == LogicalKeyboardKey.keyS
            && isKeyDown) {
      player.move(Vector2(0, step));

    }
    if (event.logicalKey == LogicalKeyboardKey.arrowLeft
        || event.logicalKey == LogicalKeyboardKey.keyA
            && isKeyDown) {
      player.move(Vector2(-step, 0));
    }
    if (event.logicalKey == LogicalKeyboardKey.arrowRight
        || event.logicalKey == LogicalKeyboardKey.keyD
            && isKeyDown) {
      player.move(Vector2(step, 0));
    }
    return super.onKeyEvent(event, keysPressed);
  }

}
