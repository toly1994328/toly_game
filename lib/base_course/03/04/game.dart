import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';

import 'component.dart';

class TolyGame extends FlameGame with PanDetector {
  late final HeroComponent player;
  late final RectangleHitbox box;

  @override
  Future<void> onLoad() async {
    player = HeroComponent();
    box = RectangleHitbox();
    player.add(box..debugMode = false);
    add(player);
  }

  @override
  void onPanDown(DragDownInfo info) {
    box.debugMode = true;
  }

  @override
  void onPanStart(DragStartInfo info) {

  }

  @override
  void onPanUpdate(DragUpdateInfo info) {
    player.move(info.delta.global);
  }

  @override
  void onPanEnd(DragEndInfo info) {
    box.debugMode = false;
  }

  @override
  void onPanCancel() {
    box.debugMode = false;
  }
}
