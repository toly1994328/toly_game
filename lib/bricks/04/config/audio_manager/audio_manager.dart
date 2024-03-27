import 'package:flame_audio/flame_audio.dart';

import 'sound_effect.dart';

class AudioManager {
  bool enableSoundEffect = true;
  bool enableBgMusic = true;

  final String _bgMusicPath = 'break_bricks/background.mp3';

  void startBgm() async{
    FlameAudio.bgm.initialize();
    FlameAudio.bgm.play(_bgMusicPath, volume: 0.8);
  }

  void play(SoundEffect type) {
    if (!enableSoundEffect) {
      return;
    }
    FlameAudio.play(type.path);
  }

  void toggleBgMusic() {
    if (enableBgMusic) {
      FlameAudio.bgm.stop();
      enableBgMusic = false;
    } else {
      FlameAudio.bgm.play(_bgMusicPath, volume: 0.8);
      enableBgMusic = true;
    }
  }

  void toggleSoundEffect() {
    enableSoundEffect = !enableSoundEffect;
  }
}
