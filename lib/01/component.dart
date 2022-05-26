import 'package:flame/components.dart';

class HeroComponent extends SpriteAnimationComponent {

  HeroComponent() : super(size: Vector2(50,37), anchor: Anchor.center);

  @override
  Future<void> onLoad() async {
    List<Sprite> sprites = [];
    for(int i=0;i<=8;i++){
      sprites.add(await Sprite.load('adventurer/adventurer-bow-0$i.png'));
    }
    animation = SpriteAnimation.spriteList(sprites, stepTime: 0.15);
  }

  @override
  void onGameResize(Vector2 gameSize) {
    super.onGameResize(gameSize);
    position = gameSize / 2;
  }
}