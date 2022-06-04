import 'dart:math';

import 'package:flame/components.dart';

class Bullet extends SpriteComponent {
  double speed = 200;
  final double maxRange;

  final bool isLeft;

  Bullet({
    required Sprite sprite,
    required this.maxRange,
    required this.speed,
    this.isLeft = true,
  }) : super(
          sprite: sprite,
        );

  @override
  Future<void> onLoad() async {
    if (!isLeft) {
      angle = pi;
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
