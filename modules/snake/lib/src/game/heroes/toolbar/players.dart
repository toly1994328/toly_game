import 'dart:async';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class PlayerBar extends PositionComponent {
  final String player;
  final Color color;


  PlayerBar(this.player, this.color);

  TextStyle style = TextStyle(
      fontSize: 16, fontFamily: 'BlackOpsOne', package: 'life_game', color: Color(0xff00ffff));
  late TextComponent text = TextComponent(
    text: '$player:',
    textRenderer: TextPaint(style: style),
    // position: Vector2(point.x * side, point.y * side),
    // anchor: Anchor.center,
  );

  RectangleComponent rect = RectangleComponent(size: Vector2(20,20));

  @override
  void onParentResize(Vector2 maxSize) {
    text.position = Vector2(20, (maxSize.y - text.height) / 2);
    rect.position= Vector2(text.width+20+8, (maxSize.y - 20) / 2);

    super.onParentResize(maxSize);
  }

  @override
  FutureOr<void> onLoad() {
    add(text);
    Paint paint =Paint()..color=color;
    rect.paint=paint;
    add(rect);
    size = Vector2(text.width+20+8, 20);
    return super.onLoad();
  }
}
