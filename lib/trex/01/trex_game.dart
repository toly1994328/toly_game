import 'dart:ui';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';

import 'heroes/cloud_component.dart';
import 'heroes/ground_component.dart';
import 'heroes/obstacle_component.dart';

class TrexGame extends FlameGame {
  late final Image spriteImage;



  @override
  Future<void> onLoad() async {
    spriteImage = await Flame.images.load('trex/trex.png');
    add(CloudComponent());
    add(GroundComponent());
    add(ObstacleComponent());
  }

  @override
  Color backgroundColor() {
    return const Color(0xffffffff);
  }

}
