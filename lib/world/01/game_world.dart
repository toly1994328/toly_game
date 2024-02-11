import 'dart:ui';
import 'package:flame/game.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart' hide Image;

import 'heroes/box_component.dart';
import 'heroes/ground_component.dart';

class GameWorld extends FlameGame{

  @override
  Future<void> onLoad() async {
    add(GroundComponent());
    add(BoxComponent());
  }

  @override
  Color backgroundColor() {
    return const Color(0xffffffff);
  }

}
