import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/sprite.dart';
import 'package:flame_ext/flame_ext.dart';

class Player extends SpriteAnimationComponent with HasGameRef {

  Player() : super(size: Vector2(320, 160), anchor: Anchor.center);

  @override
  Future<void> onLoad() async {
    const String src = 'parallax/airplane.png';
    await gameRef.images.load(src);
    var image = gameRef.images.fromCache(src);
    SpriteSheet bossSheet = SpriteSheet.fromColumnsAndRows(
      image: image,
      columns: 4,
      rows: 1,
    );

    List<Sprite> sprites = bossSheet.getSprites();
    animation = SpriteAnimation.spriteList(
      sprites,
      stepTime: 1 / 10,
      loop: true,
    );
    position = gameRef.size / 2;
  }



}
