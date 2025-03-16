import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/material.dart';
import 'package:snake/src/logic/game_state_mixin.dart';

import '../../../model/game_status.dart';

class PlayerStatusBar extends PositionComponent {
  TextStyle style = TextStyle(
      fontSize: 16, fontFamily: 'BlackOpsOne', package: 'life_game', color: Color(0xff00ffff));
  late TextComponent text = TextComponent(
    text: 'Ready',
    textRenderer: TextPaint(style: style),
  );
  late TextComponent textInfo = TextComponent(
    text: '点击空格键开启',
    textRenderer: TextPaint(style: style.copyWith(fontSize: 12)),
  );
  RectangleComponent rect = RectangleComponent(size: Vector2(20,20));

  void setStatus(GameStatus status) {
    text.text = status.label;
  }


  @override
  void onParentResize(Vector2 maxSize) {
    text.position =  Vector2((maxSize.x-text.width)/2,(maxSize.y-text.height)/2);
    rect.position= Vector2(text.width+20+8, (maxSize.y - 20) / 2);
    super.onParentResize(maxSize);
  }

  @override
  FutureOr<void> onLoad() {
    add(text);
    Paint paint =Paint()..color=Colors.blue;
    rect.paint=paint;
    return super.onLoad();
  }
}
