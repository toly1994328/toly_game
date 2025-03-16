import 'dart:async';

import 'package:flame/components.dart';
import '../bricks.dart';

import '../paddle.dart';
import 'prop.dart';
import '../../bricks_game.dart';

class PropManager extends PositionComponent with HasGameRef<BricksGame> {
  final Map<int, PropComponent> propMap = {};

  void fallOrNot(int breakId) {
    PropComponent? prop = propMap[breakId];
    if (prop != null) {
      prop.fall();
      propMap.remove(breakId);
    }
  }

  @override
  FutureOr<void> onLoad() {
    final BrickManager brickManager = game.world.brickManager;
    List<Brick> bricks = brickManager.children.whereType<Brick>().toList();
    List<Prop> propPool = Prop.values.toList();
    for (Brick brick in bricks) {
      double probability = 0.2;
      if (game.paddleType == PaddleType.pink) {
        probability += 0.05;
      }
      bool hit = game.probability(probability);
      if (hit) {
        int index = game.random.nextInt(propPool.length);
        Prop active = propPool[index];
        PropComponent prop = PropComponent(active);
        prop
          ..anchor = Anchor.center
          ..position = brick.center;

        // if(brick.id==92){
        add(prop);
        propMap[brick.id] = prop;
        // }

        if (active == Prop.life) {
          propPool.remove(Prop.life);
        }
      }
    }
    return super.onLoad();
  }
}
