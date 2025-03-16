import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';


import '../../bricks_game.dart';

enum Prop {
  addBall('prop_add_a_ball.png',-1),
  shoot('prop_shoot.png',2),
  life('prop_life.png',-1),
  invincible('prop_invincible.png',3),
  expand('prop_length.png',5),
  ;

  final String src;
  final double time;

  const Prop(this.src,this.time);
}

class PropComponent extends SpriteComponent with HasGameRef<BricksGame> {
  final Prop prop;

  PropComponent(this.prop);

  @override
  FutureOr<void> onLoad() {
    fallSpeed = 0;
    sprite = game.loader[prop.src];
    add(RectangleHitbox());
    return super.onLoad();
  }

  @override
  void update(double dt) {
    if (fallSpeed == 0 || isRemoving) return;
    y += dt * fallSpeed;
    if (absolutePosition.y > kViewPort.height) {
      removeFromParent();
    }
    super.update(dt);
  }

  double fallSpeed = 0;

  void fall() {
    fallSpeed = 200;
  }
}

class CoinComponent extends SpriteComponent with HasGameRef<BricksGame> {

  CoinComponent({super.position});
  double fallSpeed = 150;

  @override
  FutureOr<void> onLoad() {
    sprite = game.loader['coin.png'];
    anchor = Anchor.center;
    size = Vector2(24, 24);
    add(RectangleHitbox());
    return super.onLoad();
  }

  @override
  void update(double dt) {
    if (fallSpeed == 0 || isRemoving) return;
    y += dt * fallSpeed;
    if (absolutePosition.y > kViewPort.height) {
      removeFromParent();
    }
    super.update(dt);
  }

}