
import 'package:flutter/material.dart';


import '../../bricks_game.dart';
import 'level_item.dart';

class LevelPage extends StatelessWidget {
  final BricksGame game;

  const LevelPage({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage('assets/images/break_bricks/bg_gallery.png'))),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          centerTitle: true,
          leading: BackButton(onPressed: back),
          title: const Text('选择关卡'),
        ),
        body: GridView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3),
          itemBuilder: (_, index) => LevelItem(
            onTapItem: onSelectLevel,
            level: index + 1,
            locked: index + 1 > game.config.maxUnLockLevel,
          ),
          itemCount: game.levelCount,
        ),
      ),
    );
  }

  void onSelectLevel(int level) {
    game.overlays.remove("LevelPage");
    game.levelNum = level;
    game.overlays.remove("HomePage");
  }

  void back() {
    game.overlays.remove("LevelPage");
  }
}


