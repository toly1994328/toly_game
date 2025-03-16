import 'dart:async';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class Settings extends PositionComponent{

  TextStyle style =
  TextStyle(fontSize: 16, fontFamily: 'BlackOpsOne', package: 'life_game', color: Color(0xff00ffff));
  late TextComponent text = TextComponent(
    text: 'Settings',
    textRenderer: TextPaint(style: style),
    // position: Vector2(point.x * side, point.y * side),
    // anchor: Anchor.center,
  );
  void setScore(int value) {
    text.text = 'Time: $value';
  }

  @override
  void onParentResize(Vector2 maxSize) {
    text.position =  Vector2((maxSize.x-text.width-20),(maxSize.y-text.height)/2);

    super.onParentResize(maxSize);
  }

  @override
  FutureOr<void> onLoad() {
    add(text);
    return super.onLoad();
  }
}


