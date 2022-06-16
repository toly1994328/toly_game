
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

enum BulletType { hero, monster }

class AnimBullet extends SpriteAnimationComponent with CollisionCallbacks {
  double speed = 200;
  final double maxRange;

  AnimBullet({
    required SpriteAnimation animation,
    required this.maxRange,
    required this.speed,
  }) : super(animation: animation);


  double _length = 0;

  @override
  void update(double dt) {
    super.update(dt);
    Vector2 ds = Vector2(1 ,0) * speed * dt;
    _length += ds.length;
    position.add(ds);
    if (_length > maxRange) {
      _length = 0;
      removeFromParent();
    }
  }
}
