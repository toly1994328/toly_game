import 'dart:ui';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart' hide Image;

import 'heroes/help_text.dart';
import 'heroes/player.dart';

class TrexGame extends FlameGame with KeyboardEvents, TapCallbacks {
  late final Image spriteImage;

  late final Player player = Player();
  late final HelpText helpText;

  @override
  Future<void> onLoad() async {
    spriteImage = await Flame.images.load('trex/trex.png');
    add(player);
    String initState = player.current.toString();
    helpText = HelpText(initState);
    add(helpText);
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
      helpText.changeState(player.current.toString());
    }
    if (keysPressed.contains(LogicalKeyboardKey.keyD)) {
      player.toggleDebugMode();
    }
    return KeyEventResult.handled;
  }

  @override
  void onTapDown(TapDownEvent event) {
    player.toggleState();
    helpText.changeState(player.current.toString());
  }
}
