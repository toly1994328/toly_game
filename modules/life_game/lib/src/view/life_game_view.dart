// Copyright 2014 The 张风捷特烈 . All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// Author:      张风捷特烈
// CreateTime:  2024-07-05
// Contact Me:  1981462002@qq.com

import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:life_game/src/view/toggle_panel/toggle_panel.dart';
import 'package:tolyui/tolyui.dart';
import 'package:uuid/uuid.dart';

import '../game/game.dart';
import '../logic/frame_evolve.dart';
import '../logic/throttle.dart';
import '../logic/transformable/transformable.dart';
import '../model/evolve.dart';
import '../storage/bean/world.dart';
import '../storage/game_life_storage.dart';
import 'action_toolbar.dart';
import 'ruler/ruler_painter.dart';
import 'ruler/ruler_value.dart';
import 'status_bar.dart';
import 'toggle_panel/edit_frame_panel.dart';
import 'toggle_panel/menu_tools_wrapper.dart';

class LifeGameView extends StatefulWidget {
  const LifeGameView({super.key});

  @override
  State<LifeGameView> createState() => _LifeGameViewState();
}

class _LifeGameViewState extends State<LifeGameView> {
  final LifeGame game = LifeGame();
  late ValueNotifier<EvolveStatus> _statusNtf;
  late ValueNotifier<int> _generationNtf;
  late ValueNotifier<EvolveSpeed> _speedNtf;
  final RulerValue rulerValue = RulerValue();

  // MainGame game = MainGame();
  FramePo? editData;
  late ValueNotifier<List<ToolAction>> _actionStateNtf;
  late Throttled<String> _updateThrottled;

  @override
  void initState() {
    _statusNtf = ValueNotifier(game.frameEvolve.status);
    _generationNtf = ValueNotifier(game.frameEvolve.generationCount);
    _speedNtf = ValueNotifier(game.frameEvolve.speed);
    _actionStateNtf = ValueNotifier(game.frameEvolve.actions);

    game.frameEvolve.addListener(_onEvolveChange);
    game.camera.viewfinder.transform.addListener(_onTransformChange);
    _updateThrottled = throttle<String>(
      duration: const Duration(milliseconds: 500),
      function: updateFrameData,
    );
    super.initState();
  }

  void updateFrameData(String data) {
    String activeId = game.activeFrameNtf.value ?? '';
    print("========updateFrameData===${activeId}================");
    GameLifeStorage().frameStore.updateData(activeId, data);
  }

  @override
  void dispose() {
    super.dispose();
    _speedNtf.dispose();
    _statusNtf.dispose();
    _generationNtf.dispose();
    _actionStateNtf.dispose();
    game.frameEvolve.removeListener(_onEvolveChange);
    game.camera.viewfinder.transform.removeListener(_onTransformChange);
  }

  void _onEvolveChange() {
    EvolveStatus newStatus = game.frameEvolve.status;
    if (_statusNtf.value != newStatus) {
      _statusNtf.value = newStatus;
    }

    int newGenerationCount = game.frameEvolve.generationCount;
    if (_generationNtf.value != newGenerationCount) {
      _generationNtf.value = newGenerationCount;
    }

    EvolveSpeed newSpeed = game.frameEvolve.speed;
    if (_speedNtf.value != newSpeed) {
      _speedNtf.value = newSpeed;
    }

    List<ToolAction> newActions = game.frameEvolve.actions;
    if (_actionStateNtf.value != newActions) {
      _actionStateNtf.value = newActions;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Row(
            children: [
              ActionToolbar(
                status: _statusNtf,
                actions: _actionStateNtf,
                onAction: _onAction,
              ),
              TogglePanel(
                actions: _actionStateNtf,
                onSubmit: _onSubmit,
                editData: editData,
                onMenuAction: (MenuAction action, FramePo? item) async {
                  switch (action) {
                    case MenuAction.delete:
                      if (item?.uuid == game.activeFrameNtf.value) {}
                      await GameLifeStorage().frameStore.deleteById(item?.uuid);
                      break;
                    case MenuAction.edit:
                      editData = item;
                      setState(() {

                      });
                      game.frameEvolve.handleAction(ToolAction.save);
                      break;
                    case MenuAction.enter:
                      game.activeFrameNtf.value = item?.uuid;
                      break;
                    case MenuAction.newFrame:
                      FramePo frame = FramePo.insert();
                      await GameLifeStorage().frameStore.insert(frame);
                      game.activeFrameNtf.value = frame.uuid;
                      break;
                    case MenuAction.copyFrame:
                      if (item == null) return false;
                      String uuid = const Uuid().v4();
                      int time = DateTime.now().millisecondsSinceEpoch;
                      FramePo po = await GameLifeStorage().frameStore.queryById(item.uuid);
                      FramePo frame = FramePo(
                          uuid: uuid,
                          title: '[副本]' + po.title,
                          description: '[副本]' + po.description,
                          data: po.data,
                          createAt: time,
                          updateAt: time);
                      await GameLifeStorage().frameStore.insert(frame);
                      game.activeFrameNtf.value = frame.uuid;
                      break;
                  }
                  return true;
                },
                activeFrame: game.activeFrameNtf,
              ),
              Expanded(
                child: TransformWrapper(
                  onPaint: _onPaint,
                  rulerValue: rulerValue,
                  transformable: game,
                  child: GameWidget(game: game),
                ),
              ),
            ],
          ),
        ),
        Divider(
          height: 1 / View.of(context).devicePixelRatio,
        ),
        StatusBar(
          generation: _generationNtf,
          onSpeedChange: (EvolveSpeed value) {
            game.frameEvolve.speed = value;
          },
          speed: _speedNtf,
        ),
      ],
    );
  }

  void _onAction(ToolAction value) {
    switch (value) {
      case ToolAction.next:
        game.nextFrame();
        break;
      case ToolAction.play:
        game.play();
        break;
      case ToolAction.see:
        game.toggleSee();
        break;
      case ToolAction.reset:
        game.reset();
        break;
      case ToolAction.clear:
        game.clear();
        updateFrameData('[]');
        break;
      case ToolAction.paint:
      case ToolAction.move:
      case ToolAction.eraser:
      case ToolAction.save:
      case ToolAction.list:
        game.frameEvolve.handleAction(value);
        if(value==ToolAction.list){
          editData=null;
          setState(() {

          });
        }
        break;
      case ToolAction.zero:
        game.fit();
    }
  }

  void _onTransformChange() {
    rulerValue.transform = game.camera.viewfinder.transform.transformMatrix.clone();
  }

  void _onPaint(Offset position) {
    if (game.frameEvolve.moveMode) return;
    Vector2 v2 = game.camera.viewfinder.globalToLocal(Vector2(position.dx, position.dy));
    (int, int) pos = ((v2.x / 20).floor(), (v2.y / 20).floor());

    if (game.frameEvolve.paintMode) {
      game.birth(pos, render: true);
    }
    if (game.frameEvolve.deleteMode) {
      game.died(pos, render: true);
    }
    _updateThrottled(game.frame.store);
  }

  Future<bool> _onSubmit(SubmitType type, FramePayload? payload) async {
    switch(type){
      case SubmitType.add:
        if(payload==null) return false;
        String uuid = const Uuid().v4();
        String data = game.frame.store;
        String title = payload.title;
        String description = payload.description;
        int createAt = DateTime.now().millisecondsSinceEpoch;
        await GameLifeStorage().frameStore.insert(FramePo(
          uuid: uuid,
          data: data,
          title: title,
          description: description,
          createAt: createAt,
          updateAt: createAt,
        ));
        $message.success(message: '保存数据成功!');
        break;
      case SubmitType.update:
        if(payload==null) return false;
        await GameLifeStorage().frameStore.updateInfo(editData?.uuid??'', payload);
        $message.success(message: '修改数据成功!');
        break;
      case SubmitType.cancel:
        break;
    }

    game.frameEvolve.handleAction(ToolAction.list);
    return true;
  }
}

class TransformWrapper extends StatefulWidget {
  final Widget child;
  final Transformable transformable;
  final RulerValue rulerValue;
  final ValueChanged<Offset> onPaint;

  const TransformWrapper(
      {super.key,
      required this.child,
      required this.transformable,
      required this.rulerValue,
      required this.onPaint});

  @override
  State<TransformWrapper> createState() => _TransformWrapperState();
}

class _TransformWrapperState extends State<TransformWrapper> {
  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: Listener(
        onPointerDown: _onPointerDown,
        onPointerSignal: _onPointerSignal,
        onPointerMove: _onPointerMove,
        child: Stack(
          fit: StackFit.passthrough,
          children: [
            widget.child,
            CustomPaint(
              painter: RulerPainter(widget.rulerValue),
              child: const Center(),
            )
          ],
        ),
      ),
    );
  }

  void _onPointerSignal(PointerSignalEvent event) {
    if (event is PointerScrollEvent) {
      bool larger = event.scrollDelta.dy < 0;
      double newZoom = larger ? 1 + 0.05 : 1 - 0.05;
      if (newZoom < 0.01 || newZoom > 20) return;
      widget.transformable.scale(newZoom, event.localPosition);
    }
  }

  Offset laseMove = Offset.zero;

  void _onPointerMove(PointerMoveEvent event) {
    widget.transformable.translation(event.delta);
    laseMove = event.localPosition;
    widget.onPaint(event.localPosition);
  }

  void _onPointerDown(PointerDownEvent event) {
    widget.onPaint(event.localPosition);
  }
}
