import 'package:flame/components.dart';

import '../trex_game.dart';

class GroundComponent extends SpriteComponent with HasGameReference<TrexGame>{

  final double groundHeight = 24;

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    y = size.y / 2 + groundHeight/2;
  }

  @override
  Future<void> onLoad() async {
    sprite = Sprite(
      game.spriteImage,
      srcPosition: Vector2(2, 104.0),
      srcSize: Vector2(2400, groundHeight),
    );
  }
}