import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame_svg/flame_svg.dart';


import '../../model/types.dart';
import '../../sweeper_game.dart';

class FaceButton extends SvgComponent
    with HasGameRef<SweeperGame>, TapCallbacks {
  @override
  FutureOr<void> onLoad() {
    size = game.sizeRes.faceSize;
    svg = game.loader.findSvg('face.svg');
    return super.onLoad();
  }

  StreamSubscription<FaceType>? _subscription;

  @override
  void onMount() {
    super.onMount();
    _subscription = game.faceStream.listen(_onFaceChange);
  }

  @override
  void onRemove() {
    _subscription?.cancel();
    super.onRemove();
  }

  void pressed() {
    svg = game.loader.findSvg('face_pressed.svg');
  }

  @override
  void onTapDown(TapDownEvent event) {
    super.onTapDown(event);
    pressed();
  }

  @override
  void onTapUp(TapUpEvent event) {
    super.onTapUp(event);
    reset();

  }

  @override
  void onTapCancel(TapCancelEvent event) {
    super.onTapCancel(event);
    reset();
  }

  void active() {
    svg = game.loader.findSvg('face_active.svg');
  }

  void reset() {
    svg = game.loader.findSvg('face.svg');
    game.restart();
  }

  void _onFaceChange(FaceType value) {
    svg = game.loader.findSvg(value.key);
  }
}
