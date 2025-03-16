import 'package:flame/events.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum DirectionType{
  arrow,
  wasd
}

enum Direction {
  up,
  down,
  left,
  right;

  Direction get opposite {
    return switch (this) {
      up => down,
      down => up,
      left => right,
      right => left,
    };
  }
}

abstract class GameOperation {
  void onDirectionChange(Direction direction,DirectionType type);

  void onSpaceCtrl();

  void onSpeedUp();
}

mixin DirectionCtrlMixin on KeyboardEvents implements GameOperation {

  @override
  KeyEventResult onKeyEvent(KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    if (event is KeyDownEvent) {
      Direction? direction = calcDirection(keysPressed);
      if(direction!=null){
        onDirectionChange(direction,DirectionType.arrow);
      }

      Direction? direction2 = calcDirection2(keysPressed);
      if(direction2!=null){
        onDirectionChange(direction2,DirectionType.wasd);
      }

      if(keysPressed.contains(LogicalKeyboardKey.space)){
        onSpaceCtrl();
      }

      if(keysPressed.contains(LogicalKeyboardKey.keyF)){
        onSpeedUp();
      }
    }
    return super.onKeyEvent(event, keysPressed);
  }

  Direction? calcDirection(Set<LogicalKeyboardKey> keysPressed) {
    final isArrowDown = keysPressed.contains(LogicalKeyboardKey.arrowDown);
    if (isArrowDown) return Direction.down;

    final isArrowLeft = keysPressed.contains(LogicalKeyboardKey.arrowLeft);
    if (isArrowLeft) return Direction.left;

    final isArrowUp = keysPressed.contains(LogicalKeyboardKey.arrowUp);
    if (isArrowUp) return Direction.up;

    final isArrowRight = keysPressed.contains(LogicalKeyboardKey.arrowRight);
    if (isArrowRight) return Direction.right;
    return null;
  }

  Direction? calcDirection2(Set<LogicalKeyboardKey> keysPressed) {
    final isArrowDown = keysPressed.contains(LogicalKeyboardKey.keyS);
    if (isArrowDown) return Direction.down;

    final isArrowLeft = keysPressed.contains(LogicalKeyboardKey.keyA);
    if (isArrowLeft) return Direction.left;

    final isArrowUp = keysPressed.contains(LogicalKeyboardKey.keyW);
    if (isArrowUp) return Direction.up;

    final isArrowRight = keysPressed.contains(LogicalKeyboardKey.keyD);
    if (isArrowRight) return Direction.right;
    return null;
  }

}
