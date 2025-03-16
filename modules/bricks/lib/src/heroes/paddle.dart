import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';

import '../bricks_game.dart';
import 'prop/prop.dart';

enum PaddleType{
  pink('Paddle_C_Red_96x28.png','Paddle_C_Red_192x28.png'),
  blue('Paddle_C_Blue_96x28.png','Paddle_C_Blue_192x28.png'),
  purple('Paddle_B_Purple_96x28.png','Paddle_B_Purple_192x28.png'),
  yellow('Paddle_B_Yellow_96x28.png','Paddle_B_Yellow_192x28.png'),
  red('Paddle_A_Red_96x28.png','Paddle_A_Red_192x28.png'),
  azure('Paddle_A_Blue_96x28.png','Paddle_A_Blue_192x28.png'),
  ;
  final String src;
  final String expandSrc;

  const PaddleType(this.src,this.expandSrc);
}

class Paddle extends SpriteComponent with HasGameRef<BricksGame> , CollisionCallbacks {

  void expand(){
    String src = game.paddleType.expandSrc;
    sprite = game.loader[src];
  }

  void expandEnd(){
    String src = game.paddleType.src;
    sprite = game.loader[src];
  }

  void switchType(String src) {
    sprite = game.loader[src];
  }


  @override
  FutureOr<void> onLoad() {
    sprite = game.loader[game.paddleType.src];
    add(RectangleHitbox());
    anchor =Anchor.center;
    y = kViewPort.height - 160;
    x = kViewPort.width / 2;
    return super.onLoad();
  }

  void moveBy(double dx) {
    game.world.play();
    double newX = position.x + dx;
    if (newX < width/2) {
      x = width/2;
      return;
    }
    if (newX > game.size.x - width/2) {
      x = game.size.x - width/2;
      return;
    }
    add(MoveToEffect(
      Vector2(newX, position.y),
      EffectController(duration: 0.1),
    ));
  }

  @override
  void onCollisionStart(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);
    if(other is CoinComponent){
      game.getCoin();
      other.removeFromParent();
    }
    if(other is PropComponent){
      onGetProp(other.prop);
      other.removeFromParent();
    }

  }

  void onGetProp(Prop prop){
    if(prop==Prop.addBall){
      game.world.addBall(autoPlay: true);
      return;
    }
    if(prop==Prop.life){
      game.world.addLife();
      return;
    }
    if(prop==Prop.shoot){
      game.world.bulletManager.startShoot();
    }
    if(prop==Prop.expand){
      expand();
    }
    game.world.addPropDisplay(prop);
  }

}
