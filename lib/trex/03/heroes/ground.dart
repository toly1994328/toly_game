import 'dart:collection';
import 'dart:math';

import 'package:flame/components.dart';
import '../trex_game.dart';

class Ground extends PositionComponent with HasGameRef<TrexGame>{
  static final Vector2 lineSize = Vector2(1200, 24);
  final Queue<SpriteComponent> groundLayers = Queue();

  late final _bumpySprite = Sprite(
    game.spriteImage,
    srcPosition: Vector2(game.spriteImage.width / 2, 104.0),
    srcSize: Vector2(1200, 24),
  );

  late final _softSprite = Sprite(
    game.spriteImage,
    srcPosition: Vector2(2.0, 104.0),
    srcSize: lineSize,
  );

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    final newLines = _generateLines();
    groundLayers.addAll(newLines);
    addAll(newLines);
    y = size.y - 24  - 40;
  }

  @override
  void update(double dt) {
    super.update(dt);
    final increment = 500 * dt;
    for (final line in groundLayers) {
      line.x -= increment;
    }

    final firstLine = groundLayers.first;
    if (firstLine.x <= -firstLine.width) {
      firstLine.x = groundLayers.last.x + groundLayers.last.width;
      groundLayers.remove(firstLine);
      groundLayers.add(firstLine);
    }
  }

  @override
  Future<void> onLoad() async{

    // add(SpriteComponent(
    //   sprite: _bumpySprite,
    //   size: Vector2(1200, 24),
    // ));
  }

  List<SpriteComponent> _generateLines() {
    int a = (game.size.x / lineSize.x).ceil();
    final int number = 1 + a - groundLayers.length;
    final lastX = (groundLayers.lastOrNull?.x ?? 0) +
        (groundLayers.lastOrNull?.width ?? 0);
    return List.generate(max(number, 0),
          (i) => SpriteComponent(
        sprite: (i + groundLayers.length).isEven ? _softSprite : _bumpySprite,
        size: lineSize,
      )..x = lastX + lineSize.x * i,
      growable: false,
    );
  }

}