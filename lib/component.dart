import 'package:flame/components.dart';

class HeroComponent extends SpriteComponent {

  HeroComponent() : super(size: Vector2(50,37), anchor: Anchor.center);

  @override
  Future<void> onLoad() async {
    sprite = await Sprite.load('adventurer/adventurer-bow-00.png');
  }

  @override
  void onGameResize(Vector2 gameSize) {
    super.onGameResize(gameSize);
    position = gameSize / 2;
  }
}