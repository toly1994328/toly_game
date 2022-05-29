import 'dart:ui';

import 'package:flame/components.dart';
import 'mixins/liveable.dart';

class Monster extends SpriteAnimationComponent with Liveable {
  Monster({
    required SpriteAnimation animation,
    required Vector2 size,
    required Vector2 position,
  }) : super(
          animation: animation,
          size: size,
          position: position,
          anchor: Anchor.center,
        );

  @override
  void onDied() {
    removeFromParent();
  }

  @override
  Future<void> onLoad() async {
    initPaint(lifePoint: 400);
  }

  void move(Vector2 ds) {
    position.add(ds);
  }
}
