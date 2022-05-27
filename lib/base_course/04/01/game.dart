import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:toly_game/base_course/04/01/component.dart';

import 'component.dart';

class TolyGame extends FlameGame with KeyboardEvents {
  late final Adventurer player;
  late final Monster monster;
  final double step = 10;


  // @override
  // void render(Canvas canvas) {
  //   canvas.drawRect(Offset.zero&size.toSize(), Paint()..color=Colors.white);
  //   super.render(canvas);
  // }

  @override
  Future<void> onLoad() async {
    player = Adventurer();
    monster = Monster();
    add(player);
    add(monster);
  }

  // @override
  // KeyEventResult onKeyEvent(
  //   RawKeyEvent event,
  //   Set<LogicalKeyboardKey> keysPressed,
  // ) {
  //   print(event.runtimeType);
  //   final isKeyDown = event is RawKeyDownEvent;
  //   if (event.logicalKey == LogicalKeyboardKey.keyY && isKeyDown) {
  //   }
  //   if (event.logicalKey == LogicalKeyboardKey.keyX && isKeyDown) {
  //     player.flip(x: true);
  //   }
  //   return super.onKeyEvent(event, keysPressed);
  // }

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
