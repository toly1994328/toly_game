import 'dart:async';
import 'dart:ui';

import 'package:flame/camera.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import 'heroes/sweeper_layout.dart';

class SweeperWorld extends World {


  @override
  FutureOr<void> onLoad() {
    // add(Line());
    SweeperLayout layout = SweeperLayout();
    add(layout);

    // add(Cell(0));
    // add(Cell(1)..x=36);
    ;
    // add(CircleComponent(radius: 60,));

    return super.onLoad();
  }

  @override
  void render(Canvas canvas) {
    // print("=========================");

    // canvas.drawRect(Rect.fromLTWH(0, 0, kViewPort.width, kViewPort.height), Paint());
    // _worldGrid.paint(canvas, kViewPort);
  }
}
