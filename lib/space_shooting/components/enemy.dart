import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'bullet.dart';

class Enemy extends SpriteComponent with HasGameRef, CollisionCallbacks {
  double _speed = 250;

  Enemy({
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
    if(other is Bullet){
      removeFromParent();
    }
  }
  @override
  void update(double dt) {
    super.update(dt);
    position.add(Vector2(0, 1) * _speed * dt);
    if(position.y>gameRef.size.y){
      removeFromParent();
    }
  }

}
