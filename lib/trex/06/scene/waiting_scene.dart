import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/text.dart';
import 'package:flutter/material.dart';
import '../trex_game.dart';

class WaitingScene extends PositionComponent with HasGameReference<TrexGame> {

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    y = (size.y - text.height + sprite.height) / 2;
    x = (size.x - text.width) / 2;
    width = size.x;
    height = size.y;
  }

  late TextComponent text = TextComponent(
    text: '按任意键或点击屏幕开始',
    textRenderer: TextPaint(style: const TextStyle(fontSize: 24, color: Colors.black)),
  );

  late SpriteComponent sprite = SpriteComponent(
    sprite: Sprite(
      game.spriteImage,
      srcPosition: Vector2(76.0, 6.0),
      srcSize: Vector2(88.0, 90.0),
  ));

  @override
  FutureOr<void> onLoad() {
    add(text);
    add(sprite);
    sprite.y -= sprite.height + 10;
    return super.onLoad();
  }
}
