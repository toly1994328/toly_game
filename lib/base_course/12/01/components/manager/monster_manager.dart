import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import 'package:flame_ext/flame_ext.dart';

import '../monster.dart';

class MonsterManager extends PositionComponent with HasGameRef {
  final SpriteSheet bossSpriteSheet;
  final SpriteSheet stoneSpriteSheet;

  MonsterManager({
    required this.bossSpriteSheet,
    required this.stoneSpriteSheet,
  }):super(anchor: Anchor.center);

  void createStoneMonster(Vector2 position) {
    List<Sprite> sprites =
        stoneSpriteSheet.getRowSprites(row: 0, start: 5, count: 4);
    SpriteAnimation animation = SpriteAnimation.spriteList(
      sprites,
      stepTime: 1 / 10,
      loop: true,
    );

    Vector2 monsterSize = Vector2(32, 48);

    Monster monster =  Monster(
      animation: animation,
      life: 200,
      size: monsterSize,
      position: position,
    );
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

    Monster monster = Monster(
      life: 4000,
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
      createStoneMonster(Vector2(pX, pY));
    }

    for(int i=1;i<=lineCount;i++){
      final double pY = i*step- 30;
      final double pX = 150;
      createStoneMonster(Vector2(pX, pY));
    }
  }
}
