import 'package:flame/game.dart';
import 'package:flame/widgets.dart';
import 'package:flame_ext/flame_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../bricks_game.dart';
import '../../config/audio_manager/sound_effect.dart';
import '../../ui_components/game_checked_box.dart';

class GameSuccessMenu extends StatefulWidget {
  final BricksGame game;

  const GameSuccessMenu({super.key, required this.game});

  @override
  State<GameSuccessMenu> createState() => _GameSuccessMenuState();
}

class _GameSuccessMenuState extends State<GameSuccessMenu> {
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
        child: Container(
          // padding: const EdgeInsets.all(8.0),
          height: 300,
          width: 280,
          child: NineImageWidget(
            opacity: 0.9,
            expandZone: const Rect.fromLTWH(32, 45, 32, 40),
            image: widget.game.loader['Window04.png'].image,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 46,
                  child: NavigationToolbar(
                    middle: Text(
                      '恭喜通关',
                      style: TextStyle(
                          color: whiteTextColor,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.only(left: 34, right: 38),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "恭喜你击碎关卡中所有砖块,您将获得一颗绿水晶。",
                        style: TextStyle(color: Colors.white),
                      ),
                      const SizedBox(height: 24),
                      // SpriteWidget(sprite: widget.game.loader['flatDark13.png']),
                      SizedBox(
                        width: 42,
                        height: 42,
                        child: SpriteAnimationWidget.asset(
                          playing: true,
                          // anchor: Anchor.center,
                          path: 'break_bricks/spr_coin_strip4.png',
                          data: SpriteAnimationData.sequenced(
                              amount: 4,
                              stepTime: 0.15,
                              textureSize: Vector2(16, 16)),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        "已有 ${widget.game.config.blueCrystal} 个",
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ],
                  ),
                )),
                Padding(
                  padding:
                      const EdgeInsets.only(bottom: 46, right: 24, left: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SpriteButton(
                        onPressed: toNextLevel,
                        label: Text("下一关卡"),
                        sprite: widget.game.loader['buttonLong_beige.png'],
                        pressedSprite:
                            widget.game.loader['buttonLong_beige_pressed.png'],
                        height: 49 * 0.5,
                        width: 190 * 0.5,
                      ),
                      SpriteButton(
                        onPressed: () {
                          widget.game.am.play(SoundEffect.uiClose);
                          widget.game.overlays.remove('GameSuccessMenu');
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

  void toNextLevel(){
    widget.game.am.play(SoundEffect.uiClose);
    widget.game.overlays.remove('GameSuccessMenu');
    widget.game.nextLever();
  }
}
