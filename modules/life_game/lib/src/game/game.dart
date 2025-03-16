// Copyright 2014 The 张风捷特烈 . All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// Author:      张风捷特烈
// CreateTime:  2024-07-04
// Contact Me:  1981462002@qq.com

import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
import 'dart:ui';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../logic/frame.dart';
import '../logic/frame_evolve.dart';
import '../logic/throttle.dart';
import '../logic/transformable/flame_transformable.dart';
import '../logic/transformable/transformable.dart';
import '../storage/bean/world.dart';
import '../storage/game_life_storage.dart';
import '../storage/persistence/frame/frame_store.dart';
import '../view/action_toolbar.dart';
import 'space.dart';

class LifeGame extends FlameGame<LifeWord>
    with TransformableMixin, TransformGame<LifeWord> {
  LifeGame() : super(world: LifeWord());

  Frame get frame => frameEvolve.frame;
  FrameEvolve frameEvolve = FrameEvolve();

  ValueNotifier<String?> activeFrameNtf = ValueNotifier(null);

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    fit();
  }

  @override
  FutureOr<void> onLoad() async {
    await GameLifeStorage().init();
    List<FramePo> frames = await GameLifeStorage()
        .frameStore
        .query(args: const FrameQueryArgs(pageSize: 1));
    activeFrameNtf.addListener(_onActiveFrameChange);
    if (frames.isNotEmpty) {
      activeFrameNtf.value = frames.first.uuid;
    }
    return super.onLoad();
  }

  void play() {
    if (frameEvolve.status == EvolveStatus.evolving) {
      stop();
    } else {
      start();
    }
  }

  void start() {
    if (frameEvolve.status == EvolveStatus.evolving) {}
    paused = false;
    frameEvolve.status = EvolveStatus.evolving;
  }

  void stop() {
    paused = true;
    frameEvolve.status = EvolveStatus.stopped;
  }

  void clear() {
    paused = false;
    frame.clear();

    world.setFrame(frame);
  }

  void toggleSee() {
    paused = false;
    frameEvolve.handleAction(ToolAction.see);
    world.setFrame(frame);
  }

  void nextFrame() {
    paused = false;
    frameEvolve.evolve(world.setFrame);
  }

  void birth(XY pos, {bool render = true}) {
    frameEvolve.frame.birth(pos);
    if (render) {
      paused = false;
      world.setFrame(frameEvolve.frame);
    }
  }

  void died(XY pos, {bool render = true}) {
    frameEvolve.frame.died(pos);
    if (render) {
      paused = false;
      world.setFrame(frameEvolve.frame);
    }
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (frameEvolve.status == EvolveStatus.stopped) {
      paused = true;
    } else {
      frameEvolve.evolve(world.setFrame);
    }
  }

  void reset() {
    paused = false;
    frameEvolve.reset();
    world.setFrame(frame);
  }

  @override
  bool get enable => frameEvolve.moveMode;

  void fit() async {
    var (x, y) = frameEvolve.frame.size;
    camera.viewfinder.transform.transformMatrix = Matrix4.translationValues(
      size.x / 2 - x * 20 / 2,
      size.y / 2 - y * 20 / 2,
      0,
    );
    onTransformTick();
  }

  @override
  void onTransformTick() {
    world.setFrame(frame);
  }

  void _onActiveFrameChange() async {
    FramePo po = await GameLifeStorage()
        .frameStore
        .queryById(activeFrameNtf.value ?? '');
    String data = po.data;
    List<XY> points = [];
    if (data.isNotEmpty) {
      List<dynamic> src = jsonDecode(data) as List;
      for (int i = 0; i < src.length; i += 2) {
        int x = src[i].toInt();
        int y = src[i + 1].toInt();
        points.add((x, y));
      }
    }
    frameEvolve.frame.setData(points);
    fit();
  }
}

class LifeWord extends World with HasGameRef<LifeGame> {
  Throttled<Frame>? _throttled;
  Throttled<Frame>? _throttledPainter;

  LifeWord() {
    _throttled = throttle(
        duration: const Duration(milliseconds: 100), function: renderFrame);
    _throttledPainter = throttle(
        duration: const Duration(milliseconds: 50), function: renderFrame);
  }

  void setFrame(Frame frame) {
    if (game.frameEvolve.moveMode) {
      _throttled?.call(frame);
    } else {
      _throttledPainter?.call(frame);
    }
  }

  void renderFrame(Frame frame) async {
    removeWhere((e) => true);
    final SpaceManager spaceManager = SpaceManager(frame);
    await add(spaceManager);
    game.paused = false;
  }
}

// extension MatrixExt on Transform2D{
//   set transformMatrix(Matrix4 value){
//     this._transformMatrix.setFrom(value);
//     notifyListeners();
//   }
// }