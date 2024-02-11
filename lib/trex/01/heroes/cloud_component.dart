import 'package:flame/components.dart';

import '../trex_game.dart';

class CloudComponent extends SpriteComponent with HasGameReference<TrexGame>{
  @override
  Future<void> onLoad() async {
    sprite = Sprite(
      game.spriteImage,
      srcPosition: Vector2(166.0, 2.0),
      srcSize: Vector2(92.0, 28.0),
    );
  }
}