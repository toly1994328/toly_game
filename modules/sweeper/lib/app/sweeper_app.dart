import 'package:flame/game.dart';

import 'package:flutter/material.dart';
import '../game/sweeper_game.dart';

class SweeperGamePanel extends StatelessWidget {
  const SweeperGamePanel({super.key});

  @override
  Widget build(BuildContext context) {
    return GameWidget(game: SweeperGame());
  }
}
