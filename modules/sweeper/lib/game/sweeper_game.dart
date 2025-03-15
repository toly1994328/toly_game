import 'dart:async';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame_ext/flame_ext.dart';
import 'package:flutter/material.dart';
import '../app/res/extra_images.dart';
import 'logic/game_face_logic.dart';
import 'logic/game_hud_logic.dart';
import 'logic/game_state_logic.dart';
import 'model/game_state.dart';
import 'sweeper_world.dart';
import 'config/size_res.dart';

class SweeperGame extends FlameGame<SweeperWorld>
    with GameFaceLogic, GameHudLogic, GameStateLogic {
  SweeperGame() : super(world: SweeperWorld());

  late SizeRes sizeRes = SizeRes(gridXY: mode.size);
  TextureLoader loader = TextureLoader(package: 'sweeper');

  @override
  FutureOr<void> onLoad() async {
    camera.viewfinder.anchor = Anchor.topLeft;
    await loader.loadSvg(extraSvg);
    changeMineCount(mode.mineCount);
    return super.onLoad();
  }

  void changeMode(GameMode mode) {
    // state = GameStateLogic(mode, this);
    this.mode = mode;
    sizeRes = SizeRes(gridXY: mode.size);
    restart();
  }

  @override
  Color backgroundColor() => const Color(0x000E123D);

  void restart() {
    reset();
    world = SweeperWorld();
  }
}
