import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';

import '../../bricks_game.dart';
import '../../config/audio_manager/sound_effect.dart';

class PauseButton extends SpriteComponent
    with HasGameRef<BricksGame>, TapCallbacks {
  @override
  FutureOr<void> onLoad() {
    sprite = game.loader['flatDark15.png'];
    return super.onLoad();
  }

  @override
  void onTapDown(TapDownEvent event) {
    game.paused = true;
    game.am.play(SoundEffect.uiClose);
    game.overlays.add('PauseMenu');
  }
}