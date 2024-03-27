
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import '../../bricks_game.dart';
import 'home_buttons.dart';
import 'home_title.dart';

class HomePage extends StatefulWidget {
  final BricksGame game;
  const HomePage({super.key, required this.game});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    widget.game.paused = true;
  }

  @override
  void dispose() {
    widget.game.paused = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff263466),
      body: Column(
        children: [
          HomeTitle(game: widget.game),
          Expanded(flex: 4, child: HomeButtons(game: widget.game)),
          const Spacer(flex: 1)
        ],
      ),
    );
  }
}
