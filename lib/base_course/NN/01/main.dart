import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'package:toly_game/base_course/NN/01/ship.dart';

main() {
  runApp(GameWidget(game: SpaceShootGame()));
  // FlameAudio.play('background.mp3');
}

class SpaceShootGame extends FlameGame with HasKeyboardHandlerComponents{

  @override
  Future<void> onLoad() async{
    add(Ship());
  }
}