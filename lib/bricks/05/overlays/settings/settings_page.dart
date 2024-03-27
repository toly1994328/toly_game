import 'package:flame/widgets.dart';
import 'package:flame_ext/flame_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../bricks_game.dart';
import '../../config/audio_manager/sound_effect.dart';
import '../../ui_components/game_checked_box.dart';
import 'audiu_setting.dart';
import 'bg_music_setting.dart';

class SettingsPage extends StatefulWidget {
  final BricksGame game;

  const SettingsPage({super.key, required this.game});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  @override
  void initState() {
    super.initState();
    widget.game.paused = true;
  }

  @override
  void dispose() {
    if(!widget.game.overlays.isActive('HomePage')){
      widget.game.paused = false;
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const whiteTextColor = Color.fromRGBO(255, 255, 255, 1.0);

    return Material(
      color: Colors.transparent,
      child: Center(
        child: SizedBox(
          height: 280,
          width: 260,
          child: NineImageWidget(
            opacity: 0.9,
            expandZone: const Rect.fromLTWH(32, 45, 32, 40),
            image: widget.game.loader['Window04.png'].image,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 46,
                  child: NavigationToolbar(
                    middle: Text(
                      '系统设置',
                      style: TextStyle(
                        color: whiteTextColor,
                        fontSize: 14,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 34,right:38,top:4,bottom: 28.0),
                    child: Column(
                      children: [
                        BgMusicSetting(game: widget.game,),
                        const SizedBox(height: 8),
                        SoundEffectSetting(game: widget.game,),
                        const Spacer(),
                        SpriteButton(
                          onPressed: () {
                            widget.game.am.play(SoundEffect.uiClose);
                            widget.game.overlays.remove('Settings');
                          },
                          label: const Text("退出设置",),
                          sprite: widget.game.loader['buttonLong_beige.png'],
                          pressedSprite: widget.game.loader['buttonLong_beige_pressed.png'],
                          height: 49*0.5,
                          width:190*0.5 ,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

