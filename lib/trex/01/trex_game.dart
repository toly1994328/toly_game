import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart' hide Image;


import 'heroes/player.dart';

class TrexGame extends FlameGame  with KeyboardEvents, TapCallbacks{

  late final Image spriteImage;

  late final player = Player();

  @override
  Future<void> onLoad() async{

    spriteImage = await Flame.images.load('trex/trex.png');
    add(player);

  }

  @override
  Color backgroundColor() {
    return const Color(0xffffffff);
  }

  @override
  KeyEventResult onKeyEvent(
      RawKeyEvent event,
      Set<LogicalKeyboardKey> keysPressed,
      ) {
    if (keysPressed.contains(LogicalKeyboardKey.keyA)) {
      // onAction();
      player.toggleState();
    }
    if (keysPressed.contains(LogicalKeyboardKey.keyD)) {
      // onAction();
      player.toggleDebugMode();
    }
    return KeyEventResult.handled;
  }

  @override
  void onTapDown(TapDownEvent event) {
    player.toggleState();
  }
}