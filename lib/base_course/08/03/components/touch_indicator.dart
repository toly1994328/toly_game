import 'package:flame/components.dart';

class TouchIndicator extends SpriteAnimationComponent {

  TouchIndicator({required Vector2 position})
      : super(
          size: Vector2(30, 30),
          anchor: Anchor.center,
          position: position,
        );

  @override
  Future<void> onLoad() async {
    List<Sprite> sprites = [];
    for(int i=1;i<=10;i++){
      sprites.add(await Sprite.load('touch/star_${'$i'.padLeft(2,'0')}.png'));
    }
    removeOnFinish = true;
    animation = SpriteAnimation.spriteList(sprites, stepTime: 1/15,loop: false);
  }

}