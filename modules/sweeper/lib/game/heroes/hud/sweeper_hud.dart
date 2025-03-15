import 'dart:async';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import '../../config/color_res.dart';
import '../../sweeper_game.dart';
import 'face_button.dart';
import 'led_screen.dart';

class SweeperHud extends PositionComponent with HasGameRef<SweeperGame> {
  StreamSubscription<int>? _mineSubscription;
  StreamSubscription<int>? _timerSubscription;

  @override
  void onMount() {
    super.onMount();
    _mineSubscription = game.mineCountStream.listen(_onMineCountChange);
    _timerSubscription = game.timeCtrlStream.listen(_onTimerChange);
  }

  void _onMineCountChange(int event) {
    leftScreen.value = event;
  }

  void _onTimerChange(int event) {
    rightScreen.value = event;
  }

  @override
  void onRemove() {
    _mineSubscription?.cancel();
    _timerSubscription?.cancel();
    super.onRemove();
  }

  @override
  FutureOr<void> onLoad() {
    size = game.sizeRes.hudSize;
    _addLedScreen();
    double faceY = (height - game.sizeRes.faceSize.y) / 2;
    double faceX = (width - game.sizeRes.faceSize.x) / 2;
    add(FaceButton()..position = Vector2(faceX, faceY));

    leftScreen.value = game.ledMineCount;

    return super.onLoad();
  }

  late LedScreen leftScreen;
  late LedScreen rightScreen;

  void _addLedScreen() {
    double ledWidth = game.sizeRes.ledWidth;
    double ledSpace = game.sizeRes.ledSpace;
    leftScreen = LedScreen(ledSpace: ledSpace, ledWidth: ledWidth);
    double ledY = (height - leftScreen.screenSize.y) / 2;
    double ledX = ledWidth / 2;
    leftScreen.position = Vector2(ledX, ledY);
    add(leftScreen);

    rightScreen = LedScreen(ledSpace: ledSpace, ledWidth: ledWidth, count: 3);
    ledX = width - ledWidth / 2 - rightScreen.screenSize.x;
    rightScreen.position = Vector2(ledX, ledY);
    add(rightScreen);
  }

  @override
  void render(Canvas canvas) {
    canvas.drawRect(
      Offset.zero & Size(width, height),
      Paint()..color = ColorRes.background,
    );
    super.render(canvas);
  }
}
