import 'package:flame/components.dart';
import 'package:flame/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../bricks_game.dart';
import 'home_page/coin_widget.dart';

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
    widget.game.paused=true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff263466),
      body: Center(
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 12.0,top:  12),
                  child: CoinWidget(),
                )
              ],
            ),
            Expanded(
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 32.0),
                child: Column(
                  children: [
                    Text(
                      "Bricks",
                      style: TextStyle(fontSize: 24, color: Colors.white),
                    ),
                    Text(
                      "经典打砖块",
                      style: TextStyle(fontSize: 24, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
            //
            SpriteButton(
              onPressed: () {
                widget.game.paused=false;
                widget.game.overlays.remove('HomePage');
              },
              label: const Text('开始游戏',
                  style: const TextStyle(color: const Color(0xFFFFFFFF),fontWeight: FontWeight.bold)),
              sprite: widget.game.loader['Btn_V15.png'],
              pressedSprite: widget.game.loader['Btn_V16.png'],
              height: 55 / 1.5,
              width: 241 / 1.5,
            ),
            const SizedBox(
              height: 12,
            ),
            SpriteButton(
              onPressed: () {
                widget.game.overlays.remove('HomePage');
              },
              label: const Text('道具商店',
                  style: const TextStyle(color: const Color(0xFFFFFFFF),fontWeight: FontWeight.bold)),
              sprite: widget.game.loader['Btn_V14.png'],
              pressedSprite: widget.game.loader['Btn_V17.png'],
              height: 55 / 1.5,
              width: 241 / 1.5,
            ),

            const SizedBox(
              height: 12,
            ),
            SpriteButton(
              onPressed: () {
                widget.game.overlays.remove('HomePage');
              },
              label: const Text('关卡选择',
                  style: const TextStyle(color: const Color(0xFFFFFFFF),fontWeight: FontWeight.bold)),
              sprite: widget.game.loader['Btn_V13.png'],
              pressedSprite: widget.game.loader['Btn_V18.png'],
              height: 55 / 1.5,
              width: 241 / 1.5,
            ),
            const SizedBox(
              height: 12,
            ),
            SpriteButton(
              onPressed: () {
                widget.game.overlays.add('Settings');
              },
              label: const Text('系统设置', style: const TextStyle(color: const Color(0xFFFFFFFF),fontWeight: FontWeight.bold)),
              sprite: widget.game.loader['Btn_V03.png'],
              pressedSprite: widget.game.loader['Btn_V04.png'],
              height: 55 / 1.5,
              width: 241 / 1.5,
            ),
Spacer()
            // ElevatedButton(onPressed: (){
            //   game.overlays.remove('HomePage');
            // }, child: Text("开始游戏"))
          ],
        ),
      ),
    );
  }
}
