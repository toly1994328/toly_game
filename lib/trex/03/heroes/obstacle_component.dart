import 'package:flame/components.dart';

import '../trex_game.dart';

class ObstacleComponent extends SpriteComponent
    with HasGameReference<TrexGame> {

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    y = size.y  - 70.0 - 40;
    x = size.x / 2 - width / 2;
  }

  @override
  Future<void> onLoad() async {
    sprite = Sprite(
      game.spriteImage,
      srcPosition: Vector2(446.0, 2.0),
      srcSize: Vector2(34.0, 70.0),
    );
  }
}
