import 'dart:math';

import 'package:flame/components.dart';
import 'hero.dart';

enum BulletType{
  hero,
  monster
}

class AnimBullet extends SpriteAnimationComponent {
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
  }) : super(animation : animation);

  @override
  Future<void> onLoad() async {
    switch(type){
      case BulletType.hero:
        if (!isLeft) angle = pi;
        break;
      case BulletType.monster:
        if (isLeft) angle = pi;
        break;
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
