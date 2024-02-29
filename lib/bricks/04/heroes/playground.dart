import 'dart:async';
import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

import '../bricks_game.dart';

class Playground extends RectangleComponent with HasGameReference<BricksGame> {
  Playground() : super(
    paint: Paint()..color = const Color(0xff000000),
    children: [RectangleHitbox()],
  );


  @override
  FutureOr<void> onLoad() async {
    super.onLoad();
    size = Vector2(kViewPort.width, kViewPort.height);
  }
}
