import 'package:flutter/material.dart';

import '../../bricks_game.dart';
import '../../config/audio_manager/sound_effect.dart';
import '../../ui_components/game_checked_box.dart';

class BgMusicSetting extends StatefulWidget {
  final BricksGame game;

  const BgMusicSetting({super.key, required this.game});

  @override
  State<BgMusicSetting> createState() => _BgMusicSettingState();
}

class _BgMusicSettingState extends State<BgMusicSetting> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        widget.game.am.play(SoundEffect.uiSelect);
        widget.game.am.toggleBgMusic();
        setState(() {
        });
      },
      child: Row(
        children: [
          Text(
            "背景音乐",
            style: TextStyle(color: Colors.white,fontSize: 14),
          ),
          Spacer(),
          GameCheckedBox(
            value: widget.game.am.enableBgMusic,
            active: widget.game.loader['blue_boxCheckmark.png'],
            inactive: widget.game.loader['grey_box.png'],
          )
        ],
      ),
    );
  }
}
