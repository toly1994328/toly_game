// Copyright 2014 The 张风捷特烈 . All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// Author:      张风捷特烈
// CreateTime:  2024-07-28
// Contact Me:  1981462002@qq.com
import 'package:flutter/material.dart';

import 'area_range.dart';
import 'ruler_value.dart';

class RulerPainter extends CustomPainter {
  final RulerValue value;

  RulerPainter(this.value) : super(repaint: value);

  final TextPainter _textPainter = TextPainter(textDirection: TextDirection.ltr);

  final Paint _storkPaint = Paint()
    ..style = PaintingStyle.stroke
    ..color = Colors.white;

  final Paint _gridPaint = Paint()
    ..style = PaintingStyle.stroke
    ..color = Colors.grey
    ..strokeWidth = 0.5;

  final Paint _bgPainter = Paint()..color = const Color(0xff2a2a2a);

  @override
  void paint(Canvas canvas, Size size) {
    double side = 20;
    double scaleExtend = 20;
    double s = value.scale;
    Offset c = value.center;
    Range2d range = Range2d(x: Area(0, size.width), y: Area(0, size.height));
    Scales scales = range.scales(side, c, s);
    drawGrid(canvas, size, c, scales, scaleExtend);
    drawScale(canvas, size, c, scales, scaleExtend);

    AxisPainter axis = AxisPainter(size);
    axis.paint(canvas, _textPainter, c);
  }

  void drawScale(Canvas canvas, Size size, Offset c, Scales scales, double extend) {
    canvas.drawRect(Offset.zero & Size(size.width, 20), _bgPainter);
    canvas.save();
    canvas.translate(c.dx, 0);
    paintScales(canvas, scales.x, extend);
    canvas.restore();

    canvas.drawRect(Offset.zero & Size(20, size.height), _bgPainter);
    canvas.save();
    canvas.translate(0, c.dy);
    paintScales(canvas, scales.y, extend);
    canvas.restore();
  }

  void drawGrid(Canvas canvas, Size size, Offset c, Scales scales, double extend) {
    canvas.save();
    canvas.translate(c.dx, 0);
    paintGrid(canvas, scales.x, extend, size.height);
    canvas.restore();

    canvas.save();
    canvas.translate(0, c.dy);
    paintGrid(canvas, scales.y, extend, size.width);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;

  void paintScales(Canvas canvas, List<Scale> boxes, double extend) {
    Path path = Path();
    for (int i = 0; i < boxes.length; i++) {
      Scale box = boxes[i];
      box.link(path, extend);
      box.paintText(_textPainter, canvas, extend);
    }
    canvas.drawPath(path, _storkPaint);
  }

  void paintGrid(Canvas canvas, List<Scale> boxes, double width, double extend) {
    Path gridPath = Path();
    for (int i = 0; i < boxes.length; i++) {
      Scale box = boxes[i];
      box.link(gridPath, extend);
    }
    canvas.drawPath(gridPath, _gridPaint);
  }
}

class AxisPainter {
  final Size size;

  AxisPainter(this.size);

  void paint(Canvas canvas, TextPainter painter, Offset offset) {
    _drawText(canvas, painter);
    drawAxis(canvas, offset);
  }

  void drawAxis(Canvas canvas, Offset offset) {
    Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..color = Colors.cyanAccent;

    canvas.drawLine(Offset(offset.dx, 0), Offset(offset.dx, size.height), paint);
    canvas.drawLine(Offset(0, offset.dy), Offset(size.width, offset.dy), paint);
  }

  void _drawText(Canvas canvas, TextPainter painter) {
    Paint paint = Paint()..style = PaintingStyle.stroke;
    paint.color = const Color(0xffa0a0a0);
    canvas.drawRect(const Rect.fromLTWH(0, 0, 20, 20), Paint()..color = Colors.black);
    canvas.drawLine(Offset.zero, const Offset(20, 20), paint);
    paint.color = const Color(0xff2a2a2a);
    canvas.drawLine(const Offset(0, 20), const Offset(20, 20), paint);
    canvas.drawLine(const Offset(20, 0), const Offset(20, 20), paint);

    const TextStyle style = TextStyle(fontSize: 10, height: 1, color: Color(0xffa0a0a0));
    painter.text = const TextSpan(text: 'x', style: style);
    painter.layout();
    painter.paint(canvas, Offset(20 - painter.width - 4, 2));

    painter.text = const TextSpan(text: 'y', style: style);
    painter.layout();
    painter.paint(canvas, Offset(4, 20 - painter.height - 2));
  }
}
