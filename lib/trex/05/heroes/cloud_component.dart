import 'dart:math';

import 'package:flame/components.dart';

import '../trex_game.dart';

class CloudManager extends PositionComponent with HasGameReference<TrexGame> {
  final Random random = Random();

  @override
  void update(double dt) {
    super.update(dt);

    if (children.isNotEmpty) {
      final lastCloud = children.last as CloudComponent;
      // 当 lastPosX < 屏幕宽度的一半时，生成一个云朵。
      // 每 [300~500] px 分布一片白云
      // 高度在 [30~70] 之间
      double lastPosX = lastCloud.x + lastCloud.cloudSize.x;
      if (lastPosX < game.size.x / 2 ) {
        addCloud();
      }
    } else {
      addCloud();
    }
  }

  void addCloud() {
    CloudComponent cloud = CloudComponent();
    double offsetX = 300 + (500 - 300) * random.nextDouble();
    cloud.y = 30 + (70 - 30) * random.nextDouble();
    if (children.isEmpty) {
      cloud.x = offsetX;
    } else {
      cloud.x = (children.last as PositionComponent).x + offsetX;
    }
    add(cloud);
  }
}

class CloudComponent extends SpriteComponent with HasGameReference<TrexGame> {
  final Vector2 cloudSize = Vector2(92.0, 28.0);

  @override
  Future<void> onLoad() async {
    sprite = Sprite(
      game.spriteImage,
      srcPosition: Vector2(166.0, 2.0),
      srcSize: cloudSize,
    );
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (isRemoving) return;
    x -= game.moveSpeed * 0.2 * dt;
    if (x + width < 0) {
      removeFromParent();
    }
  }
}
