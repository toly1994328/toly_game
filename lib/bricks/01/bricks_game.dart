import 'dart:async';
import 'package:flame/game.dart';
import 'package:flame_ext/flame_ext.dart';

import 'heroes/ball.dart';
import 'heroes/bricks.dart';
import 'heroes/paddle.dart';

class BricksGame extends FlameGame {
  TextureLoader loader = TextureLoader();
  double get width => size.x;
  double get height => size.y;

  Brick brick = Brick();
  Ball ball = Ball();
  Paddle paddle = Paddle();

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    brick.x = (size.x - brick.width) / 2;
    brick.y = 20;
    ball.y = size.y / 2 - ball.height / 2;
    ball.x = size.x / 2 - ball.width / 2;

    paddle.x = size.x / 2 - paddle.width / 2;
    paddle.y = size.y - paddle.height - 20;
  }

  @override
  FutureOr<void> onLoad() async {
    super.onLoad();
    await loader.load(
      'assets/images/break_bricks/break_bricks.json',
      'break_bricks/break_bricks.png',
    );
    add(paddle);
    add(ball);
    add(brick);
  }
}
