
import 'dart:async';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import '../../bricks_game.dart';

class LevelText extends PositionComponent with HasGameRef<BricksGame>{

  late TextComponent levelText = TextComponent(
    text: "第 ${game.level.id} 关",
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