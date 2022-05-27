import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';

class HeroComponent extends SpriteAnimationComponent with HasGameRef, Tappable,Hoverable {

  HeroComponent() : super(size: Vector2(50,37), anchor: Anchor.center);

  late final RectangleHitbox box;
  double _counter = 0;

  @override
  Future<void> onLoad() async {
    List<Sprite> sprites = [];
    for(int i=0;i<=8;i++){
      sprites.add(await gameRef.loadSprite('adventurer/adventurer-bow-0$i.png'));
    }
    animation = SpriteAnimation.spriteList(sprites, stepTime: 0.15);
    position = gameRef.size / 2;
    box = RectangleHitbox()..debugMode = false;
    add(box);
  }

  @override
  bool onTapUp(TapUpInfo info) {
    box.debugMode = true;
    return true;
  }


  @override
  bool onTapDown(TapDownInfo info) {
    box.debugMode = true;
    box.debugColor = Colors.red;
    _counter++;
    rotateTo(_counter * pi / 2);
    return true;
  }

  @override
  bool onTapCancel() {
    box.debugMode = false;
    return true;
  }

  void rotateTo(double deg){
    angle = deg;
  }


  @override
  bool onHoverEnter(PointerHoverInfo info) {
    box.debugMode = true;
    box.debugColor = Colors.greenAccent;
    return true;
  }

  @override
  bool onHoverLeave(PointerHoverInfo info) {
    box.debugMode = false;
    return true;
  }

  // void move(Vector2 ds){
  //   position.add(ds);
  // }
  //
  // void rotateTo(double deg){
  //   angle = deg;
  // }

}
