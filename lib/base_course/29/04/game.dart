import 'package:flame/game.dart';
import 'package:flame/input.dart';


import 'components/ember.dart';
import 'components/ground.dart';
import 'components/rock.dart';

class TolyGame extends FlameGame
    with HasCollisionDetection, HasTappables, HasKeyboardHandlerComponents {

  late MovableEmber ember;

  @override
  Future<void> onLoad() async {
    final Vector2 fixSize = Vector2(500, 500,);
    camera.viewport = FixedResolutionViewport(fixSize);
    add(Ground());

    add(ember = MovableEmber());
    camera.speed = 1;
    camera.followComponent(ember, worldBounds: Ground.bounds);

    for (var i = 0; i < 30; i++) {
      add(Rock(Vector2(Ground.genCoord(), Ground.genCoord())));
    }
  }
}



