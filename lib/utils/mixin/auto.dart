import 'package:flame/game.dart';
import 'package:flutter/material.dart';

mixin AutoPauseMixin on State {
  Game get game;

  @override
  void initState() {
    super.initState();
    game.paused = true;
  }
}

mixin AutoResumeMixin on State {
  Game get game;

  @override
  void dispose() {
    game.paused = false;
    super.dispose();
  }
}