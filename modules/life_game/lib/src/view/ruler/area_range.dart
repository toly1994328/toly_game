// Copyright 2014 The 张风捷特烈 . All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// Author:      张风捷特烈
// CreateTime:  2024-07-28
// Contact Me:  1981462002@qq.com

import 'package:flutter/painting.dart';

import '../../logic/frame.dart';

typedef Scales = ({List<Scale> x, List<Scale> y});

class Range2d {
  final Area x;
  final Area y;

  Range2d({required this.x, required this.y});

  (double, double) transform(Area area, double c, double s) {
    double len = area.b - area.a;
    double lenL = c - area.a;
    double lenR = area.b - c;
    return (
      c - len / s * (lenL / len) - c,
      c + len / s * (lenR / len) - c,
    );
  }

  Range range(double side, Offset c, double s) {
    var (startX, endX) = transform(x, c.dx, s);
    var (startY, endY) = transform(y, c.dy, s);
    return (
      min: (startX ~/ side - 1, startY ~/ side - 1),
      max: (endX ~/ side + 1, endY ~/ side + 1),
    );
  }

  Scales scales(double side, Offset c, double s) {
    Range zone = range(side, c, s);
    List<Scale> boxesX = [];
    List<Scale> boxesY = [];
    for (int i = zone.min.$1; i < zone.max.$1; i++) {
      boxesX.add(Scale(i, side * s, Axis.horizontal));
    }
    for (int i = zone.min.$2; i < zone.max.$2; i++) {
      boxesY.add(Scale(i, side * s, Axis.vertical));
    }
    return (x: boxesX, y: boxesY);
  }
}

class Area {
  final double a;
  final double b;

  Area(this.a, this.b);

  @override
  String toString() {
    return 'Area[${a.toStringAsFixed(1)} ~ ${b.toStringAsFixed(1)}]';
  }
}

class Scale {
  final int value;
  final Axis axis;
  final double side;

  Scale(this.value, this.side, this.axis);

  void paintText(TextPainter painter, Canvas canvas, double extend) {
    painter.text = TextSpan(text: '$value', style: const TextStyle(fontSize: 8));
    painter.layout();
    Offset offset = switch (axis) {
      Axis.horizontal => Offset(
          value * side + side / 2 - painter.size.width / 2,
          extend / 2 - painter.size.height / 2,
        ),
      Axis.vertical => Offset(
          extend / 2 - painter.size.width / 2,
          value * side + side / 2 - painter.size.height / 2,
        ),
    };
    painter.paint(canvas, offset);
  }

  void link(Path path, double extend) {
    if (axis == Axis.horizontal) {
      path
        ..moveTo(value * side, 0)
        ..relativeLineTo(0, extend);
    } else {
      path
        ..moveTo(0, value * side)
        ..relativeLineTo(extend, 0);
    }
  }

  @override
  String toString() {
    return 'Scale{value: $value}';
  }
}
