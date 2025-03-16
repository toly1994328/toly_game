// Copyright 2014 The 张风捷特烈 . All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// Author:      张风捷特烈
// CreateTime:  2024-07-04
// Contact Me:  1981462002@qq.com

import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import '../logic/frame.dart';
import '../view/ruler/area_range.dart';
import 'game.dart';

class SpaceManager extends PositionComponent with HasGameRef<LifeGame>{
  final double side;
  final Frame frame;

  SpaceManager(this.frame, {this.side = 20});


  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);

    double x = game.size.x;
    double y = game.size.y;
    Matrix4 m4 = game.camera.viewfinder.transform.transformMatrix;
    Range2d range2d = Range2d(x: Area(0, x), y: Area(0, y));
    double s = m4.getMaxScaleOnAxis();
    Offset c = m4.getTranslation().xy.toOffset();
    Range range = range2d.range(side, c, s);
    bool see = game.frameEvolve.seeWorld;

    for (int x = range.min.$1; x < range.max.$1; x++) {
      for (int y = range.min.$2; y < range.max.$2; y++) {
        XY point = (x, y);
        bool alive = frame.spaces[point] ?? false;
        int? value = frame.spaceValueMap[point];
        if(value!=null){
          add(Space(point, alive: alive, value: value, see: see));
        }
      }
    }
    print(children.length);
  }
}



class Space extends PositionComponent {
  final XY p;
  final double side;
  bool alive;
  int value;
  bool see;

  Space(
    this.p, {
    this.side = 20,
    this.alive = true,
    this.value = 0,
    this.see = false,
  }) : super(
          size: Vector2(side, side),
        );

  @override
  FutureOr<void> onLoad() {
    if (see) {
      TextStyle style =
          TextStyle(fontSize: 16, fontFamily: 'BlackOpsOne', package: 'life_game', color: color);
      TextComponent text = TextComponent(
        text: '$value',
        textRenderer: TextPaint(style: style),
        position: Vector2(p.$1 * side, p.$2 * side),
        anchor: Anchor.center,
      );
      add(text);
      text.position = text.position + size / 2;
    }

    return super.onLoad();
  }

  @override
  void render(Canvas canvas) {
    if (!alive) return;
    Paint paint = Paint()..color = Colors.white;
    canvas.drawRect(Rect.fromLTWH(p.$1 * side, p.$2 * side, width, height), paint);
  }

  Color? get color {
    if (alive && (value < 2 || value > 3)) {
      return Colors.red;
    }
    if (!alive && (value <= 2 || value > 3)) {
      return Colors.grey;
    }
    return Colors.green;
  }
}
