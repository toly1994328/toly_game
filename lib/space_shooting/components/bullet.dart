import 'package:flame/components.dart';

class Bullet extends SpriteComponent{
  double _speed = 350;

  Bullet({
    required Sprite sprite,
  }) : super(sprite: sprite);

  @override
  void update(double dt) {
    super.update(dt);
    position.add(Vector2(1, 0) * _speed * dt);
    if(position.y<0){
      removeFromParent();
    }
  }
}