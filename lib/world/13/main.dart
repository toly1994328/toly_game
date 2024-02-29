import 'dart:async';
import 'dart:ui';

import 'package:flame/camera.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/flame.dart';

import 'package:flame/game.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart' hide Image;
import 'package:flutter/services.dart';
import 'package:toly_game/trex/06/heroes/fps_text.dart';

main() {
  runApp(GameWidget(game: MainGame()));
}

class MainGame extends FlameGame<PlayWord> with KeyboardEvents {
  MainGame()
      : super(
          world: PlayWord(),
          camera: CameraComponent.withFixedResolution(width: 320, height: 480),
        );

  late final Image spriteImage;
  @override
  Future<void> onLoad() async {
    spriteImage = await Flame.images.load('demos/c17_mini_rmbg.png');
    add(FpsText(color: Colors.white));
  }

  @override
  KeyEventResult onKeyEvent(KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    super.onKeyEvent(event, keysPressed);
    if (event is KeyDownEvent || event is KeyRepeatEvent) {
      switch (event.logicalKey) {
        case LogicalKeyboardKey.arrowDown:
          camera.viewfinder.zoom-=0.1;
        case LogicalKeyboardKey.arrowUp:
          camera.viewfinder.zoom+=0.1;
        case LogicalKeyboardKey.arrowLeft:
          camera.moveBy(Vector2(10, 0));
        case LogicalKeyboardKey.arrowRight:
          camera.moveBy(Vector2(-10, 0));
      }
    }

    return KeyEventResult.handled;
  }

  @override
  Color backgroundColor() => const Color(0xff5EC8F8);
}

class PlayWord extends World {

  @override
  FutureOr<void> onLoad() {
    add(Hero()..anchor=Anchor.center);
    return super.onLoad();
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    canvas.drawRect(const Rect.fromLTWH(-160, -240, 320, 480), Paint());
  }
}

class Hero extends SpriteComponent with HasGameRef<MainGame> {
  @override
  FutureOr<void> onLoad() {
    sprite = Sprite(game.spriteImage);
    debugMode = true;
    debugColor = Colors.white;
    return super.onLoad();
  }
}

class Playground extends RectangleComponent {
  Playground() : super(paint: Paint()..color = const Color(0xff000000));

  @override
  FutureOr<void> onLoad() async {
    super.onLoad();
    size = Vector2(320, 480);
    anchor = Anchor.center;
  }
}
