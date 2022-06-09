import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame/particles.dart';

class TolyGame extends FlameGame with TapDetector, PanDetector {
  late List<Sprite> sprites;

  @override
  Future<void> onLoad() async {
    sprites = [];
    for (int i = 1; i <= 10; i++) {
      sprites.add(await Sprite.load('touch/star_${'$i'.padLeft(2, '0')}.png'));
    }
  }

  @override
  void onPanDown(DragDownInfo info) {
    createIndicator(info.eventPosition.global);
  }

  double ds = 0;

  @override
  void onPanUpdate(DragUpdateInfo info) {
    // add(TouchIndicator(position: info.eventPosition.global));
    ds += info.delta.global.length;
    if (ds > 10) {
      createIndicator(info.eventPosition.global);
      ds = 0;
    }
  }

  void createIndicator(Vector2 position) {
    SpriteAnimation indicator = SpriteAnimation.spriteList(
      sprites,
      stepTime: 1 / 15,
      loop: false,
    );
    // 创建 Particle 对象
    Particle particle = SpriteAnimationParticle(
      animation: indicator,
      size: Vector2(30, 30),
    );

    // 创建 ParticleSystemComponent 构件
    final ParticleSystemComponent psc = ParticleSystemComponent(
      particle: particle,
      position: position,
      anchor: Anchor.center,
    );
    // 添加 ParticleSystemComponent 构件
    add(psc);
  }
}
