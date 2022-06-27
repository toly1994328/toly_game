import 'dart:ui';

import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import 'component.dart';
class TolyGame extends FlameGame {
  @override
  Future<void> onLoad() async {
    add(HeroMan()..position=size/2);
  }

  @override
  void onGameResize(Vector2 gameSize) {
    super.onGameResize(gameSize);
    print(size);
  }
}
