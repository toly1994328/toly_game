import 'package:flame/components.dart';

class Enemy extends SpriteComponent with HasGameRef {
  double _speed = 250;

  Enemy({
    required Sprite sprite,
  }) : super(sprite: sprite);

  // @override
  // Future<void> onLoad() async {
  //   super.onLoad();
  //   size = Vector2(64, 64);
  //   anchor = Anchor.center;
  //   position = gameRef.size / 2;
  // }

  @override
  void update(double dt) {
    super.update(dt);
    position.add(Vector2(0, 1) * _speed * dt);
    if(position.y>gameRef.size.y){
      removeFromParent();
    }
  }

}
