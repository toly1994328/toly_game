import 'package:flame/game.dart';
import 'package:flame/input.dart';

import 'touch_indicator.dart';

class TolyGame extends FlameGame with TapDetector, PanDetector {

  @override
  void onPanDown(DragDownInfo info) {
    add(TouchIndicator(position: info.eventPosition.global));
  }

  double ds = 0;
  @override
  void onPanUpdate(DragUpdateInfo info) {
    // add(TouchIndicator(position: info.eventPosition.global));
    ds += info.delta.global.length;
    if (ds > 10) {
      add(TouchIndicator(position: info.eventPosition.global));
      ds = 0;
    }
  }
}
