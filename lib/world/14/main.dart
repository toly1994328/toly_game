import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/flame.dart';

import 'package:flame/game.dart';
import 'package:flutter/material.dart' hide Image;
import 'package:flutter/services.dart';
import 'package:toly_game/trex/06/heroes/fps_text.dart';

import 'help_text.dart';
import 'world_grid.dart';

const Size kViewPort = Size(480, 320);

main() {
  runApp(GameWidget(game: MainGame()));
}

class MainGame extends FlameGame<PlayWord> with KeyboardEvents {
  MainGame()
      : super(
          world: PlayWord(),
          camera: CameraComponent.withFixedResolution(
              width: kViewPort.width, height: kViewPort.height),
        );

  late final Image spriteImage;
  @override
  Future<void> onLoad() async {
    spriteImage = await Flame.images.load('demos/c17_mini_rmbg.png');
    add(FpsText(color: Colors.white));
    add(HelpText());


  }



  @override
  KeyEventResult onKeyEvent(
      KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    super.onKeyEvent(event, keysPressed);
    if (event is KeyDownEvent || event is KeyRepeatEvent) {
      switch (event.logicalKey) {
        case LogicalKeyboardKey.arrowDown:
          camera.viewfinder.position -= Vector2(0, 10);
          // camera.moveBy(Vector2(0, -10));
        case LogicalKeyboardKey.arrowUp:
          camera.viewfinder.position += Vector2(0, 10);
          // camera.moveBy(Vector2(0, 10));
        case LogicalKeyboardKey.arrowLeft:
          // camera.moveBy(Vector2(10, 0));
          camera.viewfinder.position += Vector2(10, 0);
        case LogicalKeyboardKey.arrowRight:
          camera.viewfinder.position += Vector2(-10, 0);
        case LogicalKeyboardKey.bracketLeft:
          camera.viewfinder.zoom += 0.1;
        case LogicalKeyboardKey.bracketRight:
          double newZoom = camera.viewfinder.zoom-0.1;
          camera.viewfinder.zoom = max(0.1, newZoom);
        case LogicalKeyboardKey.keyR:
          camera.viewfinder.zoom = 1;
          camera.viewfinder.position=Vector2(0, 0);
          camera.viewfinder.angle=0;
        case LogicalKeyboardKey.keyT:
          camera.viewfinder.angle-= 2*(pi/180);
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

    add(Hero()..anchor = Anchor.center);

    return super.onLoad();
  }

  final WorldGrid _worldGrid = WorldGrid(
    axisColor: Colors.red,
    textColor: Colors.white,
    gridColor: const Color(0xff4AFFFF),
  );

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    canvas.drawRect(Rect.fromLTWH(-kViewPort.width / 2, -kViewPort.height / 2, kViewPort.width, kViewPort.height), Paint());
    _worldGrid.paint(canvas, kViewPort);
  }
}

class Hero extends SpriteComponent with HasGameRef<MainGame> {
  @override
  FutureOr<void> onLoad() {
    sprite = Sprite(game.spriteImage);
    // debugMode = true;
    // debugColor = Colors.white;
    return super.onLoad();
  }
}
