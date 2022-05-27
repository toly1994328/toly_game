import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';

import 'component.dart';

class TolyGame extends FlameGame with TapDetector {
  late final HeroComponent player;
  late final RectangleHitbox box;

  @override
  Future<void> onLoad() async {
    player = HeroComponent();
    box = RectangleHitbox();
    player.add(box..debugMode = false);
    add(player);
  }

  double _counter = 0;

  @override
  void onTap() {
    _counter++;
    player.rotateTo(_counter * pi / 2);
  }

  @override
  void onTapCancel() {
    box.debugMode = false;
  }

  @override
  void onTapDown(TapDownInfo info) {
    box.debugMode = true;
  }

  @override
  void onTapUp(TapUpInfo info) {
    box.debugMode = false;
  }
}
