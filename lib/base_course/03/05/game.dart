import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/palette.dart';
import 'package:flutter/painting.dart';

import 'component.dart';

class TolyGame extends FlameGame  with HasTappables,HasHoverables {
  late final HeroComponent player;

  @override
  Future<void> onLoad() async {
    player = HeroComponent();
    add(player);
  }

}
