import 'package:flame/game.dart';

import 'component.dart';

class TolyGame extends FlameGame {
  @override
  Future<void> onLoad() async {
    await add(HeroComponent());
  }
}