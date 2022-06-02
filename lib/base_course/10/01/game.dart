import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'components/ball.dart';
class TolyGame extends FlameGame with TapDetector,DoubleTapDetector{


  @override
  Future<void> onLoad() async {
    Ball ball = Ball();
    add(ball);
  }

}