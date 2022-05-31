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
  void onPanEnd(DragEndInfo info) {
    if(_lastPointerPos!=null){
      player.toTarget(_lastPointerPos!);
      _lastPointerPos = null;
    }
  }

  @override
  void onPanStart(DragStartInfo info) {
    _lastPointerPos=info.eventPosition.global;
  }

  @override
  void onPanDown(DragDownInfo info) {
    Vector2 target = info.eventPosition.global;
    add(TouchIndicator(position: target));
    player.toTarget(target);
  }

  double ds = 0;
  Vector2? _lastPointerPos;

  @override
  void onPanUpdate(DragUpdateInfo info) {
    _lastPointerPos = info.eventPosition.global;
    ds += info.delta.global.length;
    if (ds > 10) {
      add(TouchIndicator(position: info.eventPosition.global));
      ds = 0;
    }
  }
}
