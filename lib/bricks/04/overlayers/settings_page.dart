import 'package:flame/widgets.dart';
import 'package:flutter/material.dart';

import '../bricks_game.dart';

class SettingsPage extends StatelessWidget {
  final BricksGame game;
  const SettingsPage({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    const blackTextColor = Color.fromRGBO(0, 0, 0, 1.0);
    const whiteTextColor = Color.fromRGBO(255, 255, 255, 1.0);

    return Material(
      color: Colors.transparent,
      child: Center(
        child: Container(
          // padding: const EdgeInsets.all(8.0),
          height: 270,
          width: 240,
          // decoration: const BoxDecoration(
          //   color: blackTextColor,
          //   borderRadius: BorderRadius.all(
          //     Radius.circular(20),
          //   ),
          // ),
          child: NineTileBoxWidget.asset(
            path: 'break_bricks/Window04.png',
            tileSize: 0,
            destTileSize: 0,
            padding: EdgeInsets.zero,
            child:  Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                AppBar(
                  centerTitle: true,
                  toolbarHeight: 32,
                  backgroundColor: Colors.transparent,
                  title: Text('系统设置',style: TextStyle(
                    color: whiteTextColor,
                    fontSize: 14,
                  ),
                  ),
                  actions: [
                    Padding(
                      padding: const EdgeInsets.only(right:12.0),
                      child: SpriteButton(
                        onPressed: () {
                          game.overlays.remove('Settings');
                        },
                        label:SizedBox(),
                        sprite: game.loader['BtnExitNoOpacity.png'],
                        pressedSprite: game.loader['BtnExitOpacity.png'],
                        height: 18,
                        width: 18,
                      ),
                    ),
                  ],
                ),
                // Padding(
                //   padding: const EdgeInsets.only(top: 8.0),
                //   child: Row(
                //     children: [
                //       const Text(
                //         '系统设置',
                //         style: TextStyle(
                //           color: whiteTextColor,
                //           fontSize: 14,
                //         ),
                //       ),
                //
                //     ],
                //   ),
                // ),
                const SizedBox(height: 40),
                SizedBox(
                  width: 200,
                  height: 75,
                  // child: ElevatedButton(
                  //   onPressed: () {
                  //     game.overlays.remove('Settings');
                  //   },
                  //   style: ElevatedButton.styleFrom(
                  //     backgroundColor: whiteTextColor,
                  //   ),
                  //   child: const Text(
                  //     'Play',
                  //     style: TextStyle(
                  //       fontSize: 40.0,
                  //       color: blackTextColor,
                  //     ),
                  //   ),
                  // ),
                ),
                const SizedBox(height: 20),
            //     const Text(
            //       '''Use WASD or Arrow Keys for movement.
            // Space bar to jump.
            // Collect as many stars as you can and avoid enemies!''',
            //       textAlign: TextAlign.center,
            //       style: TextStyle(
            //         color: whiteTextColor,
            //         fontSize: 14,
            //       ),
            //     ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
