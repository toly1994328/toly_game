import 'dart:ui';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart' hide Image;

import 'heroes/box_component.dart';
import 'heroes/dot_component.dart';
import 'heroes/ground_component.dart';

class GameWorld extends FlameGame with KeyboardEvents, TapCallbacks {

  final TickerTap dotRecord = TickerTap(frequency: 8);
  late BoxComponent box = BoxComponent(dotRecord: dotRecord);
  late DotComponent dot = DotComponent(dotRecord);


  @override
  Future<void> onLoad() async {
    add(GroundComponent());
    add(box);
    add(dot);
  }

  @override
  Color backgroundColor() {
    return const Color(0xffffffff);
  }
  @override
  void onTapDown(TapDownEvent event) {
    box.run();
  }
}
