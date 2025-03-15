
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:trex/trex_game.dart';

class TrexGamePanel extends StatelessWidget {
  const TrexGamePanel({super.key});

  @override
  Widget build(BuildContext context) {
    return GameWidget(game: TrexGame());
  }
}
