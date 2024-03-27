import 'package:flutter/material.dart';

import '../../bricks_game.dart';
import '../../config/audio_manager/sound_effect.dart';
import '../../ui_components/game_checked_box.dart';

class SoundEffectSetting extends StatefulWidget {
  final BricksGame game;

  const SoundEffectSetting({super.key, required this.game});

  @override
  State<SoundEffectSetting> createState() => _SoundEffectSettingState();
}

class _SoundEffectSettingState extends State<SoundEffectSetting> {


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        setState(() {
          widget.game.am.play(SoundEffect.uiSelect);
          widget.game.am.toggleSoundEffect();
        });
      },
      child: Row(
        children: [
          Text(
            "游戏音效",
            style: TextStyle(color: Colors.white,fontSize: 14),
          ),
          Spacer(),
          GameCheckedBox(
            value: widget.game.am.enableSoundEffect,
            active: widget.game.loader['blue_boxCheckmark.png'],
            inactive: widget.game.loader['grey_box.png'],
          )
        ],
      ),
    );
  }
}