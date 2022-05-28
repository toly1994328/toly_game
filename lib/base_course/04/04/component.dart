import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame/sprite.dart';

class Adventurer extends SpriteAnimationComponent with HasGameRef {
  Adventurer() : super(size: Vector2(50, 37), anchor: Anchor.center);

  @override
  Future<void> onLoad() async {
    List<Sprite> sprites = [];
    for (int i = 0; i <= 8; i++) {
      sprites
          .add(await gameRef.loadSprite('adventurer/adventurer-bow-0$i.png'));
    }
    animation = SpriteAnimation.spriteList(sprites, stepTime: 0.15, loop: true);
    position = gameRef.size / 2;
    animation!.onComplete = _onLastFrame;
  }

  // @override
  // void update(double dt) {
  //   super.update(dt);
  //   // print('====Adventurer==${animation?.currentIndex}========');
  //
  //   if(animation!.currentIndex==8){
  //     playing = false;
  //     animation!.reset();
  //   }
  // }

  void shoot() {
    animation!.reset();
  }

  void flip({
    bool x = false,
    bool y = true,
  }) {
    scale = Vector2(scale.x * (y ? -1 : 1), scale.y * (x ? -1 : 1));
  }

  void move(Vector2 ds) {
    position.add(ds);
  }

  void rotateTo(double deg) {
    angle = deg;
  }

  void _onLastFrame() {
    animation!.currentIndex = 0;
    animation!.update(0);
  }
}

class Monster extends SpriteAnimationComponent {
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
  Future<void> onLoad() async {
    add(RectangleHitbox()..debugMode = true);
  }

  double _speed = 150;

  @override
  void update(double dt) {
    super.update(dt);
    Vector2 ds = Vector2(-1, 0) * _speed * dt;
    move(ds);
    if (position.x + size.x/2 < 0) {
      removeFromParent();
    }
  }

  void move(Vector2 ds) {
    position.add(ds);
  }
}
