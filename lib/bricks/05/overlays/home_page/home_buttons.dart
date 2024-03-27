import 'package:flame/widgets.dart';
import 'package:flutter/material.dart';

import '../../bricks_game.dart';
import '../../config/audio_manager/sound_effect.dart';

class HomeButtons extends StatelessWidget {
  final BricksGame game;

  const HomeButtons({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    const TextStyle style = TextStyle(color: Color(0xFFFFFFFF), fontWeight: FontWeight.bold);
    double height = 36;
    double width = 36 * 241 / 55;
    return Center(
      child: Wrap(
        spacing: 16,
        direction: Axis.vertical,
        children: [
          SpriteButton(
            onPressed: () {
              game.am.play(SoundEffect.uiClick);
              game.restart();
              game.overlays.remove('HomePage');
            },
            label: const Text('开始游戏', style: style),
            sprite: game.loader['Btn_V15.png'],
            pressedSprite: game.loader['Btn_V16.png'],
            height: height,
            width: width,
          ),
          SpriteButton(
            onPressed: () {
              game.am.play(SoundEffect.uiClick);
              game.overlays.add('ShopPage');
            },
            label: const Text('道具商店', style: style),
            sprite: game.loader['Btn_V14.png'],
            pressedSprite: game.loader['Btn_V17.png'],
            height: height,
            width: width,
          ),
          SpriteButton(
            onPressed: () {
              game.am.play(SoundEffect.uiClick);
              game.overlays.add('LevelPage');
            },
            label: const Text('关卡选择', style: style),
            sprite: game.loader['Btn_V13.png'],
            pressedSprite: game.loader['Btn_V18.png'],
            height: height,
            width: width,
          ),
          SpriteButton(
            onPressed: () {
              game.am.play(SoundEffect.uiOpen);
              game.overlays.add('Settings');
            },
            label: const Text('系统设置', style: style),
            sprite: game.loader['Btn_V03.png'],
            pressedSprite: game.loader['Btn_V04.png'],
            height: height,
            width: width,
          ),
        ],
      ),
    );
  }
}
