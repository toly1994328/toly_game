import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:toly_game/base_course/21/04/components/player.dart';
import 'components/anim_bullet.dart';
import 'components/background.dart';
class TolyGame extends FlameGame with TapDetector {

  late SpriteAnimation stoneBullet;
  late Player player;
  @override
  Future<void> onLoad() async {
    Background background = Background();
    add(background);
     player = Player();
     add(player);

    List<Sprite> sprites = [];
    for (int i = 1; i <= 4; i++) {
      sprites.add(await loadSprite('adventurer/skill01/ef0$i.png'));
    }

    stoneBullet =
    SpriteAnimation.spriteList(sprites, stepTime: 0.1);
  }

  void onTap() {
    addBullet();
  }

  // 添加子弹
  void addBullet() {
    AnimBullet bullet = AnimBullet(
      animation: stoneBullet,
      maxRange: 200,
      speed: 200,
    );
    bullet.size = Vector2(470/15,258/15);
    bullet.angle = pi;
    bullet.anchor = Anchor.center;
    bullet.priority = 1;
    priority = 2;
    bullet.position = player.position+Vector2(60, 15);
    add(bullet);
  }

}
