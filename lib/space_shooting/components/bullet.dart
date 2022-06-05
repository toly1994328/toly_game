import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:toly_game/space_shooting/components/enemy.dart';

class Bullet extends SpriteComponent with CollisionCallbacks{
  double _speed = 350;

  Bullet({
    required Sprite sprite,
  }) : super(sprite: sprite);

  @override
  void onMount(){
    super.onMount();
    final ShapeHitbox hitbox = CircleHitbox();
    hitbox.debugMode = true;
    add(hitbox);
  }


  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    if(other is Enemy){
      removeFromParent();
    }
  }

  @override
  void update(double dt) {
    super.update(dt);
    position.add(Vector2(0, -1) * _speed * dt);
    if(position.y<0){
      removeFromParent();
    }
  }
}