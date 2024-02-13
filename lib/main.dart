import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import 'trex/06/trex_game.dart';
import 'utils/size_utils.dart';

main() {
  runApp(GameWidget(game: TrexGame()));
  SizeUtils.fullScreenMobile();
}


