import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/text.dart';
import 'package:flutter/material.dart';
import '../trex_game.dart';

class GameOverScene extends PositionComponent with HasGameReference<TrexGame> {
  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    y = (size.y - spriteText.height - spriteButton.height) / 2;
    x = (size.x - spriteText.width) / 2;
  }

  late SpriteComponent spriteText = SpriteComponent(
      sprite: Sprite(
        game.spriteImage,
        srcPosition: Vector2(954.0, 30.0),
        srcSize: Vector2(384.0, 32.0),
      ));

  late SpriteComponent spriteButton = SpriteComponent(
      sprite: Sprite(
    game.spriteImage,
    srcPosition: Vector2(4.0, 4.0),
    srcSize: Vector2(72.0, 62.0),
  ));

  @override
  FutureOr<void> onLoad() {
    add(spriteButton);
    add(spriteText);
    spriteButton.y += spriteText.height + 20;
    spriteButton.x += (spriteText.width-spriteButton.width)/2;
    return super.onLoad();
  }
}
