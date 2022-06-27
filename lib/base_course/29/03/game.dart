import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'components/background.dart';
import 'components/hero.dart';

class TolyGame extends FlameGame with KeyboardEvents {

  @override
  Future<void> onLoad() async {
    final Vector2 fixSize = Vector2(500, 300,);
    camera.viewport = FixedResolutionViewport(fixSize);
    camera.setRelativeOffset(Anchor.center);
    camera.speed=100;
    add(Background());
    add(HeroMan());
  }

  @override
  KeyEventResult onKeyEvent(
      RawKeyEvent event,
      Set<LogicalKeyboardKey> keysPressed,
      ) {
    final isKeyDown = event is RawKeyDownEvent;

    if (event.logicalKey == LogicalKeyboardKey.keyZ && isKeyDown) {
      camera.zoom += 0.1;
    }

    if (event.logicalKey == LogicalKeyboardKey.keyX && isKeyDown) {
      camera.zoom -= 0.1;
    }

    if (event.logicalKey == LogicalKeyboardKey.arrowRight && isKeyDown) {
      camera.moveTo(Vector2(0, size.y/2+37/2));
    }
    if (event.logicalKey == LogicalKeyboardKey.arrowUp && isKeyDown) {
      camera.moveTo(Vector2(0, size.y/2-37/2));
    }


    return super.onKeyEvent(event, keysPressed);
  }

}




