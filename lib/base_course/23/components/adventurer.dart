import 'package:flame/components.dart';

class Adventurer extends SpriteAnimationComponent with HasGameRef {
  final Function()? onLastFrame;
  final SpriteAnimation spriteAnimation;

  Adventurer({this.onLastFrame, required this.spriteAnimation,required Vector2 size})
      : super(
          size: size,
          anchor: Anchor.center,
          playing: false,
          animation: spriteAnimation,
        );

  @override
  Future<void> onLoad() async {
    animation!.onComplete = _onLastFrame;
  }

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

  void _onLastFrame() async {
    animation!.currentIndex = 0;
    animation!.update(0);
    onLastFrame?.call();
  }
}
