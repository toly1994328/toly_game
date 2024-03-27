import 'package:flutter/material.dart';

import '../../bricks_game.dart';

class ShopPage extends StatelessWidget {
  final BricksGame game;

  const ShopPage({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
            onTap: (){
              print("=====onTap=============");
              game.overlays.remove('ShopPage');
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("ShopPage"),
                Text("道具商店 TODO...")
              ],
            )),
      ),
    );
  }
}
