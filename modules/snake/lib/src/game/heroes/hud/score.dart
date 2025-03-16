import 'dart:async';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class ScoreHud extends PositionComponent {

  TextStyle style = const TextStyle(
    fontSize: 16,
    fontFamily: 'BlackOpsOne',
    package: 'life_game',
    color: Color(0xff00ffff),
  );
  late TextComponent text = TextComponent(
    text: 'Score: 0',
    textRenderer: TextPaint(style: style),
  );

  void setScore(int value) {
    text.text = 'Score: $value';
  }

  @override
  void onParentResize(Vector2 maxSize) {
    text.position = Vector2(20, (maxSize.y - text.height) / 2);
    super.onParentResize(maxSize);
  }

  @override
  FutureOr<void> onLoad() {
    add(text);
    return super.onLoad();
  }
}
