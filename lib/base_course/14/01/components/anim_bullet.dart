import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:toly_game/base_course/14/01/components/monster.dart';

import 'hero.dart';

enum BulletType { hero, monster }

class AnimBullet extends SpriteAnimationComponent with CollisionCallbacks {
  double speed = 200;
  final double maxRange;
  final BulletType type;
  final HeroAttr attr;
  final bool isLeft;

  AnimBullet({
    required SpriteAnimation animation,
    required this.maxRange,
    required this.type,
    required this.speed,
    required this.attr,
    this.isLeft = true,
  }) : super(animation: animation);

  @override
  Future<void> onLoad() async {
    switch (type) {
      case BulletType.hero:
        if (!isLeft) angle = pi;
        break;
      case BulletType.monster:
        if (isLeft) angle = pi;
        break;
    }
    addHitbox();
  }

  void addHitbox() {
    ShapeHitbox hitbox = RectangleHitbox();
    hitbox.debugMode = true;
    add(hitbox);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    if (type == BulletType.hero && other is Monster) {
      removeFromParent();
    }
    if (type == BulletType.monster && other is HeroComponent) {
      removeFromParent();
    }
  }

  double _length = 0;

  @override
  void update(double dt) {
    super.update(dt);
    Vector2 ds = Vector2(isLeft ? 1 : -1, 0) * speed * dt;
    _length += ds.length;
    position.add(ds);
    if (_length > maxRange) {
      _length = 0;
      removeFromParent();
    }
  }
}
