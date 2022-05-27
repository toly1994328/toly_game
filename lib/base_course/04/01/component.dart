import 'dart:ui';

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
    animation = SpriteAnimation.spriteList(sprites, stepTime: 0.15);
    position = gameRef.size / 2;
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
}

class Monster extends SpriteComponent with HasGameRef {
  Monster()
      : super(
            size: Vector2(32, 48),
            anchor: Anchor.center,
            scale: Vector2(0.8, 0.8));

  double _speed = 200;

  @override
  Future<void> onLoad() async {
    const String src = 'adventurer/Characters-part-2.png';
    await gameRef.images.load(src);
    Image image = gameRef.images.fromCache(src);
    SpriteSheet sheet =
        SpriteSheet.fromColumnsAndRows(image: image, columns: 9, rows: 6);
    sprite = sheet.getSprite(3, 0);
    size = Vector2(64, 64);
    position = gameRef.size / 2 + Vector2(60, 0);
  }



  @override
  void update(double dt) {
    super.update(dt);
    // position.add(Vector2(0, 1) * _speed * dt);
    // if(position.y>gameRef.size.y){
    //   removeFromParent();
    // }
  }

  void move(Vector2 ds) {
    position.add(ds);
  }

  void flip({
    bool x = false,
    bool y = true,
  }) {
    scale = Vector2(scale.x * (y ? -1 : 1), scale.y * (x ? -1 : 1));
  }
}
