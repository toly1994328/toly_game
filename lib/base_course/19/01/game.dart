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
      addSizeEffectBy();
    }

    if (event.logicalKey == LogicalKeyboardKey.digit9 && isKeyDown) {
      addSizeEffectTo();
    }

    if (event.logicalKey == LogicalKeyboardKey.keyQ && isKeyDown) {
      addOpacityEffectBy();
    }

    if (event.logicalKey == LogicalKeyboardKey.keyW && isKeyDown) {
      addOpacityEffectTo();
    }
    if (event.logicalKey == LogicalKeyboardKey.keyE && isKeyDown) {
      addColorEffect();
    }
    if (event.logicalKey == LogicalKeyboardKey.keyR && isKeyDown) {
      addMoveAlongPathEffect();
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

  void zigzagEffectController(){
    EffectController ctrl = ZigzagEffectController(period: 2);
    Effect effect = MoveByEffect(
      Vector2(50, 0),
      ctrl,
    );
    player.add(effect);
  }

  // 6
  void sineEffectController2(){
    EffectController ctrl = SineEffectController(period: 0.1);
    EffectController ctrl2 = RepeatedEffectController(
    ctrl,5
);
    Effect effect = MoveByEffect(
      Vector2(-2, 0),
      ctrl2,
    );
    player.add(effect);
  }

  //2
  void resetPosition(){
    Effect effect = MoveToEffect(
      size / 2,
      EffectController(duration: 0.5),
    );
    player.add(effect);
  }

  //3
  void addRotateEffectBy(){
    Effect effect = RotateEffect.by(
      15/180*pi,
      EffectController(duration: 0.5),
    );
    player.add(effect);
  }

  //4
  void addRotateEffectTo(){
    Effect effect = RotateEffect.to(
      0,
      EffectController(duration: 0.5),
    );
    player.add(effect);
  }

  //5
  void addScaleEffectBy(){
    Effect effect = ScaleEffect.by(
      Vector2(1.2,1.2),
      EffectController(duration: 0.5),
    );
    player.add(effect);
  }

  //6
  void addScaleEffectTo(){
    Effect effect = ScaleEffect.to(
      Vector2(1,1),
      EffectController(duration: 0.5),
    );
    player.add(effect);
  }

  //7
  void addRemoveEffect(){
    Effect effect = RemoveEffect(
      delay:3
    );
    player.add(effect);
  }

  //8
  void addSizeEffectBy(){
    Effect effect = SizeEffect.by(
      Vector2(5,5*(37/50)),
      EffectController(duration: 0.5),
    );
    player.add(effect);
  }

  //9
  void addSizeEffectTo(){
    Effect effect = SizeEffect.to(
      Vector2(50, 37),
      EffectController(duration: 0.5),
    );
    player.add(effect);
  }

  //q
  void addOpacityEffectBy(){
    Effect effect = OpacityEffect.by(
      -0.1,
      EffectController(duration: 0.5),
    );
    player.add(effect);
  }
  //w
  void addOpacityEffectTo(){
    Effect effect = OpacityEffect.to(
      1,
      EffectController(duration: 0.5),
    );
    player.add(effect);
  }

  //e
  void addColorEffect() {
    final Effect effect = ColorEffect(
      Colors.blue,
      const Offset(0.0, 0.4),
      EffectController(duration: 1),
    );
    player.add(effect);
  }

  //e
  void addMoveAlongPathEffect() {
    final Effect effect = MoveAlongPathEffect(
      path,
      EffectController(duration: 1.5),
    );
    effect.onFinishCallback=(){
      curveMoveCount++;
    };
    player.add(effect);
  }

  Path path = Path()..quadraticBezierTo(50, -50, 100, 0);
  int curveMoveCount = 0;

}
