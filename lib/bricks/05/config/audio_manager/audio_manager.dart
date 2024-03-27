import 'package:flame_audio/flame_audio.dart';

import '../game_config.dart';
import 'sound_effect.dart';

class AudioManager {
  final GameConfigManager manager;

  AudioManager(this.manager);

  bool get enableSoundEffect => manager.config.enableSoundEffect;
  bool get enableBgMusic => manager.config.enableBgMusic;

  final String _bgMusicPath = 'break_bricks/background.mp3';

  void startBgm() async{
    // FlameAudio.bgm.initialize();
    // FlameAudio.bgm.play(_bgMusicPath, volume: 0.8);
  }

  void play(SoundEffect type) {
    if (!enableSoundEffect) {
      return;
    }
    // FlameAudio.play(type.path);
  }

  void toggleBgMusic() {
    if (enableBgMusic) {
      FlameAudio.bgm.stop();
      manager.changeEnableBgMusic(false);
    } else {
      FlameAudio.bgm.play(_bgMusicPath, volume: 0.8);
      manager.changeEnableBgMusic(true);
    }
  }

  void toggleSoundEffect() {
    manager.changeEnableSoundEffect(!enableSoundEffect);
  }
}
