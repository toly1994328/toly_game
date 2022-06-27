import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';

import 'component.dart';

class TolyGame extends FlameGame {

  // @override
  // Color backgroundColor() => const Color(0xffffffff);



  @override
  Future<void> onLoad() async {
    final Vector2 fixSize = Vector2(90, 60,);
    camera.viewport = FixedResolutionViewport(fixSize);
    add(Background());
    add(HeroMan()..position=size/2);
  }

  @override
  void onGameResize(Vector2 gameSize) {
    super.onGameResize(gameSize);
    print(size);
  }

}

class Background extends PositionComponent with HasGameRef{
  @override
  int priority = -1;


  late Paint white;
  late final Rect hugeRect;

  Background() : super(size: Vector2.all(100000));
  @override
  Future<void> onLoad() async {
    white = BasicPalette.white.paint();
    hugeRect = size.toRect();
  }

  @override
  void render(Canvas c) {
    c.drawRect(hugeRect, white);
  }
}


