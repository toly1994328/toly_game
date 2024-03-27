
import 'dart:async';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class LevelText extends PositionComponent{

  final TextComponent levelText = TextComponent(
    text: "第一关",
    anchor: Anchor.center,
    textRenderer:
    TextPaint(style: const TextStyle(color: Colors.white, fontSize: 42)),
  );

  @override
  FutureOr<void> onLoad() {

    add(levelText);
    return super.onLoad();
  }
}