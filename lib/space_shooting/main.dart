import 'package:flame/game.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';

import 'scene/game.dart';



main() {
  runApp(GameWidget(game: SpaceShooting()));
  // FlameAudio.play('background.mp3');
}


