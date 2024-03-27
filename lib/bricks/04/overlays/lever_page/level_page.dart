import 'package:flutter/material.dart';

import '../../bricks_game.dart';

class LevelPage extends StatelessWidget {
  final BricksGame game;

  const LevelPage({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
            onTap: (){
              print("=====onTap=============");
              game.overlays.remove('LevelPage');
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("LevelPage"),
                Text("关卡界面 TODO...")
              ],
            )),
      ),
    );
  }
}
