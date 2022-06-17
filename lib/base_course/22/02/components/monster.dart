import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'anim_bullet.dart';
import '../mixins/liveable.dart';
import 'hero.dart';

class Monster extends SpriteAnimationComponent with CollisionCallbacks,Liveable,HasGameRef{
  SpriteAnimation bulletSprite;
  HeroAttr attr;
  bool isLeft = false;
  final Vector2 bulletSize;

  late Timer _timer;

  Monster({
    required SpriteAnimation animation,
    required this.bulletSize,
    required Vector2 size,
    required Vector2 position,
    required this.bulletSprite,
    required this.attr,
  }) : super(
          animation: animation,
          size: size,
          position: position,
          anchor: Anchor.center,
        );

  @override
  void onDied() {
    removeFromParent();
  }

  @override
  void onMount() {
    super.onMount();
    _timer.start();
  }

  @override
  void update(double dt) {
    super.update(dt);
    _timer.update(dt);
  }

  @override
  void onRemove() {
    super.onRemove();
    _timer.stop();
  }

  // 添加子弹
  void addBullet() {
    AnimBullet bullet = AnimBullet(
      attr: attr,
      type: BulletType.monster,
      animation: bulletSprite,
      maxRange: attr.attackRange,
      speed: attr.attackSpeed,
      isLeft: isLeft,
    );
    bullet.size = bulletSize;
    bullet.anchor = Anchor.center;
    bullet.priority = 1;
    priority = 2;
    bullet.position = position - Vector2(0, size.y/2);
    gameRef.add(bullet);
  }

  @override
  Future<void> onLoad() async {
    _timer = Timer(3, onTick: addBullet, repeat: true);
    initPaint(lifePoint: attr.life);
    addHitbox();
  }

  void addHitbox(){
    ShapeHitbox hitbox = RectangleHitbox();
    hitbox.debugMode = true;
    add(hitbox);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    if (other is AnimBullet&&other.type==BulletType.hero) {
        loss(other.attr);
    }
  }

  void move(Vector2 ds) {
    position.add(ds);
  }
}
