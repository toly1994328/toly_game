import 'dart:ui';
import 'package:flame/events.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'heroes/line.dart';
import 'heroes/player.dart';

class GameWorld extends FlameGame with PanDetector, HasCollisionDetection {
  late Line line;
  late final Image spriteImage;
  PlayerComponent player = PlayerComponent();

  @override
  Future<void> onLoad() async {
    spriteImage = await Flame.images.load('trex/trex.png');
    line = Line();
    add(player);
    add(line);
  }

  @override
  Color backgroundColor() => const Color(0xffffffff);

  @override
  void onPanUpdate(DragUpdateInfo info) {
    line.position += info.delta.global;
  }
}
