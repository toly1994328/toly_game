import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'components/ball.dart';
class TolyGame extends FlameGame with TapDetector,DoubleTapDetector{

  int _counter = 0;

  @override
  Future<void> onLoad() async {
    addABall();
  }

  void addABall(){
    Ball ball = Ball(tag: 'tag$_counter');
    add(ball);
    _counter++;
  }

  @override
  void onTap() {
    addABall();
  }

  @override
  void onDoubleTap() {
   List<Ball> balls = children.whereType<Ball>().toList();
   if(balls.isNotEmpty){
     balls.first.removeFromParent();
   }
  }
}