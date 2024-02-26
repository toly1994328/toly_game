
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:toly_game/utils/size_utils.dart';

import 'bricks_game.dart';

main() {
  runApp(GameWidget(game: BricksGame()));
  SizeUtils.fullScreenMobile();
}


