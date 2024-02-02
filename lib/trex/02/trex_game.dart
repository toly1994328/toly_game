import 'dart:ui';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart' hide Image;

import 'heroes/ground.dart';
import 'heroes/help_text.dart';
import 'heroes/player.dart';

class TrexGame extends FlameGame with KeyboardEvents, TapCallbacks {
  late final Image spriteImage;

  late final Player player = Player();
  // late final HelpText helpText;
  late final Ground ground;

  double moveSpeed = 0;
  double kDefaultMoveSpeed = 600;



  @override
  Future<void> onLoad() async {
    spriteImage = await Flame.images.load('trex/trex.png');
    add(player);
    String initState = player.current.toString();
    // helpText = HelpText(initState);
    // add(helpText);

    ground = Ground();
    add(ground);
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
      player.toggleState();
      onPlayerStateChange();
      // helpText.changeState(player.current.toString());
    }
    if (keysPressed.contains(LogicalKeyboardKey.keyP)) {
      player.toggleRun();
      onPlayerStateChange();
      // helpText.changeState(player.current.toString());
    }
    if (keysPressed.contains(LogicalKeyboardKey.keyD)) {
      player.toggleDebugMode();
    }
    return KeyEventResult.handled;
  }

  void onPlayerStateChange(){
    if (player.active) {
      moveSpeed = kDefaultMoveSpeed;
      paused = false;
    }else{
      moveSpeed = 0;
      paused = true;
    }
  }

  @override
  void onTapDown(TapDownEvent event) {
    player.toggleState();
    onPlayerStateChange();

    // helpText.changeState(player.current.toString());
  }
}
