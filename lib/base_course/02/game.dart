import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/palette.dart';
import 'package:flutter/painting.dart';

import 'component.dart';

class TolyGame extends FlameGame with HasDraggables {
  late final HeroComponent player;
  late final JoystickComponent joystick;

  @override
  Future<void> onLoad() async {
    final knobPaint = BasicPalette.blue.withAlpha(200).paint();
    final backgroundPaint = BasicPalette.blue.withAlpha(100).paint();
    joystick = JoystickComponent(
      knob: CircleComponent(radius: 25, paint: knobPaint),
      background: CircleComponent(radius: 60, paint: backgroundPaint),
      margin: const EdgeInsets.only(left: 40, bottom: 40),
    );
    player = HeroComponent();
    add(player);
    add(joystick);
  }

  @override
  void update(double dt) {
    super.update(dt);
    // print(dt);
    // print(joystick.delta.screenAngle()*180/pi);
    // print(joystick.relativeDelta);

    // 角色移动
    if (!joystick.delta.isZero()) {
      Vector2 ds = joystick.relativeDelta * player.speed * dt;
      player.move(ds);
    }

    // 角色旋转
    // if (!joystick.delta.isZero()) {
    //   player.rotateTo(joystick.delta.screenAngle());
    // }else{
    //   player.rotateTo(0);
    // }

  }
}
