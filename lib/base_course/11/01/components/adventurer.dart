import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame/sprite.dart';

import '../mixins/liveable.dart';
import 'bullet.dart';

class Adventurer extends SpriteAnimationComponent with HasGameRef,Liveable {
  Adventurer()
      : super(size: Vector2(50, 37), anchor: Anchor.center, playing: false);

  @override
  Future<void> onLoad() async {
    List<Sprite> sprites = [];
    for (int i = 0; i <= 8; i++) {
      sprites
          .add(await gameRef.loadSprite('adventurer/adventurer-bow-0$i.png'));
    }

    animation = SpriteAnimation.spriteList(sprites, stepTime: 0.1, loop: false);
    position = gameRef.size / 2;
    animation!.onComplete = _onLastFrame;
    bulletSprite = await gameRef.loadSprite('adventurer/weapon_arrow.png');
    initPaint(lifePoint: 3000);

  }

  // @override
  // void render(Canvas canvas) {
  //   super.render(canvas);
  //   canvas.drawRect(
  //       Rect.fromPoints(Offset(size.x/2,0), Offset(size.x/2+200+32/2,size.y)),
  //       // Rect.fromCenter(
  //       //     center: Offset(size.x / 2, size.y / 2), width: (200+size.x/2)*2, height: size.y),
  //       Paint()
  //         ..style = PaintingStyle.stroke
  //         ..strokeWidth=1
  //         ..color = Colors.blue);
  // }

  void shoot() {
    playing = true;
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

  late Sprite bulletSprite;

  void _onLastFrame() async {
    animation!.currentIndex = 0;
    animation!.update(0);
    // 添加子弹
    Bullet bullet = Bullet(sprite: bulletSprite, maxRange: 200);
    bullet.size = Vector2(32, 32);
    bullet.anchor = Anchor.center;
    bullet.priority = 1;
    priority = 2;
    bullet.position = position - Vector2(0, -3);
    gameRef.add(bullet);
  }

  final double _speed = 100;

  void toTarget(Vector2 target) {
    removeAll(children.whereType<MoveEffect>());
    double timeMs = (target - position).length / _speed;
    add(
      MoveEffect.to(
        target,
        EffectController(
          duration: timeMs,
        ),
      ),
    );
  }
}
