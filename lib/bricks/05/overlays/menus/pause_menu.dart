import 'package:flame/widgets.dart';
import 'package:flame_ext/flame_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../bricks_game.dart';
import '../../config/audio_manager/sound_effect.dart';

class PauseMenu extends StatefulWidget {
  final BricksGame game;

  const PauseMenu({super.key, required this.game});

  @override
  State<PauseMenu> createState() => _PauseMenuState();
}

class _PauseMenuState extends State<PauseMenu> {
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
    const whiteTextColor = Color.fromRGBO(255, 255, 255, 1.0);

    return Material(
      color: Colors.transparent,
      child: Center(
        child: SizedBox(
          height: 220,
          width: 280,
          child: NineImageWidget(
            opacity: 0.9,
            expandZone: const Rect.fromLTWH(32, 45, 32, 40),
            image: widget.game.loader['Window04.png'].image,
            child:  Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 46,
                  child: NavigationToolbar(
                    middle: Text(
                      '游戏暂停',
                      style: TextStyle(
                          color: whiteTextColor,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Expanded(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 34,right:38,bottom: 28.0),
                        child: Text(
                          "游戏已暂停,点击按钮可以选择 [继续游戏] 或 [重新开始]。",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    )),
                Padding(
                  padding: const EdgeInsets.only(bottom: 46,right: 24,left: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SpriteButton(
                        onPressed: () {
                          widget.game.am.play(SoundEffect.uiClose);
                          widget.game.overlays.remove('PauseMenu');
                        },
                        label: Text(
                          "继续游戏",
                        ),
                        sprite: widget.game.loader['buttonLong_beige.png'],
                        pressedSprite:
                            widget.game.loader['buttonLong_beige_pressed.png'],
                        height: 49 * 0.5,
                        width: 190 * 0.5,
                      ),
                      SpriteButton(
                        onPressed: () {
                          widget.game.am.play(SoundEffect.uiClose);
                          widget.game.overlays.remove('PauseMenu');
                          widget.game.restart();
                        },
                        label: Text(
                          "重新开始",
                          style: TextStyle(color: Colors.white),
                        ),
                        sprite: widget.game.loader['buttonLong_blue.png'],
                        pressedSprite:
                        widget.game.loader['buttonLong_blue_pressed.png'],
                        height: 49 * 0.5,
                        width: 190 * 0.5,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

