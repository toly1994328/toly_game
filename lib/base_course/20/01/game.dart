import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'components/adventurer.dart';
import 'components/text_info_component.dart';

class TolyGame extends FlameGame with KeyboardEvents {
  late final Adventurer player;
  final double step = 10;

  @override
  Future<void> onLoad() async {
    player = Adventurer();
    Component textInfo = TextInfoComponent(
      position: Vector2(10,10)
    );
    add(textInfo);
    // player.add(RectangleHitbox()..debugMode=true);
    add(player);
  }

  @override
  KeyEventResult onKeyEvent(
    RawKeyEvent event,
    Set<LogicalKeyboardKey> keysPressed,
  ) {
    final isKeyDown = event is RawKeyDownEvent;

    if (event.logicalKey == LogicalKeyboardKey.digit1 && isKeyDown) {
      linearEffectController();
    }    if (event.logicalKey == LogicalKeyboardKey.digit2 && isKeyDown) {
      curvedEffectController();
    }
    if (event.logicalKey == LogicalKeyboardKey.digit0 && isKeyDown) {
      resetPosition();
    }
    if (event.logicalKey == LogicalKeyboardKey.digit3 && isKeyDown) {
      reverseLinearEffectController();
    }
    if (event.logicalKey == LogicalKeyboardKey.digit4 && isKeyDown) {
      reverseCurvedEffectController();
    }

    if (event.logicalKey == LogicalKeyboardKey.digit5 && isKeyDown) {
      sineEffectController();
    }
    if (event.logicalKey == LogicalKeyboardKey.digit6 && isKeyDown) {
      noiseEffectController();
    }

    if (event.logicalKey == LogicalKeyboardKey.digit7 && isKeyDown) {
      zigzagEffectController();
    }

    if (event.logicalKey == LogicalKeyboardKey.digit8 && isKeyDown) {
      delayedEffectController();
    }

    if (event.logicalKey == LogicalKeyboardKey.digit9 && isKeyDown) {
      repeatedEffectController();
    }

    if (event.logicalKey == LogicalKeyboardKey.keyQ && isKeyDown) {
      infiniteEffectController();
    }

    if (event.logicalKey == LogicalKeyboardKey.keyW && isKeyDown) {
      randomEffectController();
    }
    if (event.logicalKey == LogicalKeyboardKey.keyE && isKeyDown) {
      speedEffectController();
    }
    if (event.logicalKey == LogicalKeyboardKey.keyR && isKeyDown) {
      sequenceEffectController();
    }

    return super.onKeyEvent(event, keysPressed);
  }
  //1
  void linearEffectController(){
    EffectController ctrl = LinearEffectController(2);
    Effect effect = MoveByEffect(
      Vector2(0, -100),
      ctrl,
    );
    player.add(effect);
  }

  //2
  void curvedEffectController(){
    EffectController ctrl = CurvedEffectController(2,Curves.ease);
    Effect effect = MoveByEffect(
      Vector2(0, -100),
      ctrl,
    );
    player.add(effect);
  }

  //3
  void reverseLinearEffectController(){
    EffectController ctrl = ReverseLinearEffectController(2);
    Effect effect = MoveByEffect(
      Vector2(0, -100),
      ctrl,
    );
    player.add(effect);
  }

  //4
  void reverseCurvedEffectController(){
    EffectController ctrl = ReverseCurvedEffectController(2,Curves.ease);
    Effect effect = MoveByEffect(
      Vector2(0, -100),
      ctrl,
    );
    player.add(effect);
  }

  // 5
  void sineEffectController(){
    EffectController ctrl = SineEffectController(period: 2);

    Effect effect = MoveByEffect(
      Vector2(0, -100),
      ctrl,
    );
    player.add(effect);
  }

  //6
  void noiseEffectController(){
    EffectController ctrl = NoiseEffectController(frequency: 30,duration: 1);
    Effect effect = MoveByEffect(
      Vector2(4, 0),
      ctrl,
    );
    player.add(effect);
  }

  //7
  void zigzagEffectController(){
    EffectController ctrl = ZigzagEffectController(period: 2);
    Effect effect = MoveByEffect(
      Vector2(50, 0),
      ctrl,
    );
    player.add(effect);
  }

  //8
  void delayedEffectController(){
    EffectController child = CurvedEffectController(2,Curves.ease);
    EffectController ctrl = DelayedEffectController(child,delay: 2);
    Effect effect = MoveByEffect(
      Vector2(0, -100),
      ctrl,
    );
    player.add(effect);
  }

  // 9
  void repeatedEffectController(){
    EffectController child = SineEffectController(period: 0.1);
    EffectController ctrl2 = RepeatedEffectController(child,5);
    Effect effect = MoveByEffect(
      Vector2(-2, 0),
      ctrl2,
    );
    player.add(effect);
  }

  // q
  void infiniteEffectController(){
    EffectController child = SineEffectController(period: 0.1);
    EffectController ctrl2 = InfiniteEffectController(child);
    Effect effect = MoveByEffect(
      Vector2(-2, 0),
      ctrl2,
    );
    player.add(effect);
  }

  // w
  void randomEffectController(){
    DurationEffectController child = LinearEffectController(2);
    EffectController ctrl = RandomEffectController.uniform(child,max: 3,min: 1);
    Effect effect = MoveByEffect(
      Vector2(0, -100),
      ctrl,
    );
    player.add(effect);
  }



  // e
  void speedEffectController(){
    DurationEffectController child = LinearEffectController(2);
    EffectController ctrl = SpeedEffectController(child,speed: 10);
    Effect effect = MoveByEffect(
      Vector2(0, -100),
      ctrl,
    );
    player.add(effect);
  }

  // r
  void sequenceEffectController(){
    DurationEffectController child1 = LinearEffectController(2);
    EffectController child2 = ZigzagEffectController(period: 2);
    EffectController child3 = CurvedEffectController(2,Curves.ease);
    EffectController ctrl = SequenceEffectController([
      child1,child2,child3
    ]);

    Effect effect = MoveByEffect(
      Vector2(0, -100),
      ctrl,
    );
    player.add(effect);
  }

  //0
  void resetPosition(){
    player.removeAll(player.children.whereType<Effect>());
    Effect effect = MoveToEffect(
      size / 2,
      EffectController(duration: 0.5),
    );
    player.add(effect);
  }

}
