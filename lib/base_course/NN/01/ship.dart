import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/services.dart';

class Ship extends SpriteComponent with HasGameRef, KeyboardHandler {
  Ship() : super(size: Vector2(64, 64), anchor: Anchor.center);

  final maxCount = 48;
  int _currentIndex = 0;
  late final SpriteSheet sheet;

  @override
  Future<void> onLoad() async {
    const String src = 'space_shooting/simpleSpace_tilesheet@2.png';
    await gameRef.images.load(src);
    Image image = gameRef.images.fromCache(src);
    sheet = SpriteSheet.fromColumnsAndRows(image: image, columns: 8, rows: 6);
    sprite = sheet.getSpriteById(0);
    add(RectangleHitbox()..debugMode = true);
    position = gameRef.size / 2;
  }

  void next() {
    _currentIndex == _currentIndex++;
    print(_currentIndex);
    sprite = sheet.getSpriteById(_currentIndex%maxCount);
  }

  void prev() {
    _currentIndex == _currentIndex--;
    sprite = sheet.getSpriteById(_currentIndex% maxCount);
  }

  void move(Vector2 ds) {
    position.add(ds);
  }

  void rotateTo(double deg) {
    angle = deg;
  }

  @override
  bool onKeyEvent(RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    final isKeyDown = event is RawKeyDownEvent;
    if ((event.logicalKey == LogicalKeyboardKey.arrowLeft ||
        event.logicalKey == LogicalKeyboardKey.keyA) && isKeyDown) {
      prev();
    }
    if ((event.logicalKey == LogicalKeyboardKey.arrowRight ||
        event.logicalKey == LogicalKeyboardKey.keyD) && isKeyDown) {
      next();
    }
    return true;
  }
}
