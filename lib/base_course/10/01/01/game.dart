import 'package:flame/game.dart';
import 'components/ball.dart';
class TolyGame extends FlameGame{


  @override
  Future<void> onLoad() async {
    Ball ball = Ball();
    add(ball);
  }
}