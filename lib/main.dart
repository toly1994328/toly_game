import 'package:flame/game.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';

import '02/game.dart';

main() {
  runApp(GameWidget(game: TolyGame()));
  // FlameAudio.play('background.mp3');
}


