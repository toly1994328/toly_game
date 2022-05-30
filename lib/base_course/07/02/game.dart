import 'package:flame/effects.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/animation.dart';

import 'components/touch_indicator.dart';
import 'components/adventurer.dart';



class TolyGame extends FlameGame with TapDetector, PanDetector {

  late final Adventurer player;
  @override
  Future<void> onLoad() async {
    player = Adventurer();
    add(player);
  }


  @override
  void onPanDown(DragDownInfo info) {
    Vector2 target = info.eventPosition.global;
    add(TouchIndicator(position: target));
    player.toTarget(target);
  }

  double ds = 0;

  @override
  void onPanUpdate(DragUpdateInfo info) {
    ds += info.delta.global.length;
    if (ds > 10) {
      add(TouchIndicator(position: info.eventPosition.global));
      ds = 0;
    }
  }
}
