import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import 'package:flame_ext/flame_ext.dart';

import '../hero.dart';
import '../monster.dart';

class MonsterManager extends PositionComponent with HasGameRef {
  final SpriteSheet bossSpriteSheet;
  final SpriteAnimation bossBullet;
  final SpriteSheet stoneSpriteSheet;
  final SpriteAnimation stoneBullet;

  MonsterManager({
    required this.bossSpriteSheet,
    required this.stoneSpriteSheet,
    required this.bossBullet,
    required this.stoneBullet,
  }):super(anchor: Anchor.center);

  void createStoneMonster(Vector2 position,bool isLeft) {
    List<Sprite> sprites =
        stoneSpriteSheet.getRowSprites(row: 0, start: 5, count: 4);
    SpriteAnimation animation = SpriteAnimation.spriteList(
      sprites,
      stepTime: 1 / 10,
      loop: true,
    );

    Vector2 monsterSize = Vector2(32, 48);

    final HeroAttr heroAttr = HeroAttr(
      life: 200,
      speed: 0,
      attackSpeed: 200,
      attackRange: 400,
      attack: 20,
      crit: 0,
      critDamage: 1,
    );

    Monster monster =  Monster(
      bulletSize:Vector2(470/15,258/15),
      attr: heroAttr,
      bulletSprite: stoneBullet,
      animation: animation,
      size: monsterSize,
      position: position,
    );
    monster.isLeft = isLeft;
    add(monster);
  }

  void createBoss() {
    SpriteAnimation animation = SpriteAnimation.spriteList(
      bossSpriteSheet.getSprites(),
      stepTime: 1 / 24,
      loop: true,
    );
    Vector2 monsterSize = Vector2(64, 64);
    final double pY = gameRef.size.y / 2;
    final double pX = gameRef.size.x - monsterSize.x / 2;

    final HeroAttr heroAttr = HeroAttr(
      life: 4000,
      speed: 100,
      attackSpeed: 200,
      attackRange: 600,
      attack: 100,
      crit: 0.5,
      critDamage: 1.5,
    );

    Monster monster = Monster(
      bulletSize:Vector2(720/4,658/4),
      attr: heroAttr,
      bulletSprite: bossBullet,
      animation: animation,
      size: monsterSize,
      position: Vector2(pX, pY),
    );
    add(monster);
  }

  @override
  Future<void> onLoad() async {
    createBoss();
    int lineCount =3;
    double step = gameRef.size.y/lineCount ;

    for(int i=1;i<=lineCount;i++){
      final double pY = i*step- 30;
      final double pX = gameRef.size.x - 200;
      createStoneMonster(Vector2(pX, pY),false);
    }

    for(int i=1;i<=lineCount;i++){
      final double pY = i*step- 30;
      final double pX = 150;
      createStoneMonster(Vector2(pX, pY),true);
    }
  }
}
