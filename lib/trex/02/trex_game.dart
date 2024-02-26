import 'dart:ui';
import 'package:flame/events.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart' hide Image;

import 'heroes/cloud_component.dart';
import 'heroes/ground_component.dart';
import 'heroes/help_text.dart';
import 'heroes/obstacle_component.dart';
import 'heroes/player.dart';
import 'heroes/score_component.dart';

class TrexGame extends FlameGame with KeyboardEvents, TapCallbacks {

  late final Image spriteImage;
  late final Player player = Player();
   final ScoreComponent score = ScoreComponent();

  @override
  Future<void> onLoad() async {
    spriteImage = await Flame.images.load('trex/trex.png');
    add(CloudComponent());
    add(GroundComponent());
    add(ObstacleComponent());
    add(player);


    String initState = player.current.toString();
    helpText = HelpText(initState);
    add(helpText);
    add(score);
  }

  late final HelpText helpText;


  @override
  Color backgroundColor() {
    return const Color(0xffffffff);
  }

  @override
  KeyEventResult onKeyEvent(
      KeyEvent event,
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
