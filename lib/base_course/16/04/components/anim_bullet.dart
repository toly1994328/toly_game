import 'dart:math';
import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/particles.dart';
import 'monster.dart';

import 'hero.dart';

enum BulletType { hero, monster }

class AnimBullet extends SpriteAnimationComponent with CollisionCallbacks,HasGameRef {
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
    // hitbox.debugMode = true;
    add(hitbox);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    if (type == BulletType.hero && other is Monster) {
      removeFromParent();
      createParticle(position+Vector2(size.x/2,0));
    }
    if (type == BulletType.monster && other is HeroComponent) {
      removeFromParent();
    }
  }

  Color randomColor(){
    return Color.fromARGB(255, _random.nextInt(255),  _random.nextInt(255),  _random.nextInt(255));
  }

  final Random _random = Random();

  Vector2 randomVector() {
    Vector2 base = Vector2.random(_random); //  (0, 0) ~ (1, 1)
    Vector2 fix = Vector2(-0.5,-0.5);
    base = base + fix; //  (-0.5, -0.5) ~ (0.5, 0.5)
    return base * 200;
  }

  void createParticle(Vector2 position) {
    CircleParticle circleParticle = CircleParticle(
      radius: 1,
      paint: Paint()..color = randomColor(),
    );

    Particle particle = Particle.generate(
      count: 20,
      lifespan: 0.3,
      generator: (i) =>
          AcceleratedParticle(
              child: circleParticle,
              acceleration: randomVector(),
              speed: randomVector(),
              position: position),
    );

    final ParticleSystemComponent psc =
    ParticleSystemComponent(particle: particle);
    gameRef.add(psc);
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
