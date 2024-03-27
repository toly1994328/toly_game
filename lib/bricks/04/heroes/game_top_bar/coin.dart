import 'dart:async';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import '../../bricks_game.dart';

class Coin extends PositionComponent with HasGameRef<BricksGame> {
  final TextComponent leverText = TextComponent(
    text: "1024",
    textRenderer:
    TextPaint(style: const TextStyle(color: Colors.white, fontSize: 24)),
  );

  @override
  FutureOr<void> onLoad() async {
    SpriteAnimation animation = await SpriteAnimation.load(
        'break_bricks/MonedaD.png',
        SpriteAnimationData.sequenced(
            amount: 4, stepTime: 0.15, textureSize: Vector2(16, 16)));
    var coin = SpriteAnimationComponent(animation: animation)
      ..size = Vector2(32, 32);
    add(coin);
    add(leverText);
    coin.y = (60 - coin.height) / 2;
    coin.x = (64-coin.width)/2;
    leverText.x =  64+(64-leverText.width)/2;
    leverText.y = (60 - leverText.height) / 2;
    width = coin.width+leverText.width;
    return super.onLoad();
  }
}