import 'package:flame/components.dart';
import '../trex_game.dart';

class RoadComponent extends SpriteComponent with HasGameRef<TrexGame> {
  final Vector2 roadSize = Vector2(1200, 24);
  int index;

  RoadComponent({this.index = 0});

  late final _leftRoad = Sprite(game.spriteImage,
      srcPosition: Vector2(2.0, 104.0), srcSize: roadSize);

  late final _rightRoad = Sprite(game.spriteImage,
      srcPosition: Vector2(game.spriteImage.width / 2, 104.0),
      srcSize: roadSize);

  void updateInfo(int value, double posX) {
    index = value;
    x = posX;
    sprite = index % 2 == 0 ? _leftRoad : _rightRoad;
  }

  @override
  Future<void> onLoad() async {
    super.onLoad();
    sprite = index % 2 == 0 ? _leftRoad : _rightRoad;
  }
}
