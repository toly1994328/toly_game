import 'dart:ui';
import 'package:flame/events.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'heroes/line.dart';
import 'heroes/player.dart';
import 'heroes/polygon.dart';

class GameWorld extends FlameGame with PanDetector, HasCollisionDetection {
  late Line line;
  late Polygon circle;
  late final Image spriteImage;
  PlayerComponent player = PlayerComponent();
  @override
  Future<void> onLoad() async {
    spriteImage = await Flame.images.load('trex/trex.png');

    circle = Polygon(radius: 40, position: size / 2);
    line = Line();
    add(circle);
    add(player);
    add(line);
    add(Polygon(radius: 60, position: size / 2 + Vector2(140, 0)));
  }

  @override
  Color backgroundColor() {
    return const Color(0xffffffff);
  }

  @override
  void onPanUpdate(DragUpdateInfo info) {
    line.position += info.delta.global;
  }
}
