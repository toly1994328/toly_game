import 'package:flutter/material.dart';
import 'dart:ui' as ui;

/// create by 张风捷特烈 on 2020/5/1
/// contact me by email 1981462002@qq.com
/// 说明:
@immutable
class WorldGrid {
  final double step;
  final double strokeWidth;
  final Color axisColor;
  final Color gridColor;
  final Color textColor;
  final TextPainter _textPainter = TextPainter(textDirection: TextDirection.ltr);

  WorldGrid({
    this.step = 20,
    this.strokeWidth = .5,
    this.axisColor = Colors.blue,
    this.gridColor = Colors.grey,
    this.textColor = Colors.green,
  });

  final Paint _gridPaint = Paint();

  void paint(Canvas canvas, Size size) {
    _drawGridLine(canvas, size);
    _drawAxis(canvas, size);
    _drawText(canvas, size);
  }

  void _drawAxis(Canvas canvas, Size size) {
    _gridPaint
      ..color = axisColor
      ..strokeWidth = 1.5;
    canvas.drawLine(
        Offset(-size.width / 2, 0), Offset(size.width / 2, 0), _gridPaint);
    canvas.drawLine(
        Offset(0, -size.height / 2), Offset(0, size.height / 2), _gridPaint);
    canvas.drawLine(Offset(0, size.height / 2),
        Offset(0 - 7.0, size.height / 2 - 10), _gridPaint);
    canvas.drawLine(Offset(0, size.height / 2),
        Offset(0 + 7.0, size.height / 2 - 10), _gridPaint);
    canvas.drawLine(
        Offset(size.width / 2, 0), Offset(size.width / 2 - 10, 7), _gridPaint);
    canvas.drawLine(
        Offset(size.width / 2, 0), Offset(size.width / 2 - 10, -7), _gridPaint);
  }

  void _drawGridLine(Canvas canvas, Size size) {
    final Path path = Path();

    _gridPaint
      ..style = PaintingStyle.stroke
      ..strokeWidth = .5
      ..color = gridColor;

    for (int i = 0; i < size.width / 2 / step; i++) {
      path.moveTo(step * i, -size.height / 2);
      path.relativeLineTo(0, size.height);

      path.moveTo(-step * i, -size.height / 2);
      path.relativeLineTo(0, size.height);
    }

    for (int i = 0; i < size.height / 2 / step; i++) {
      path.moveTo(-size.width / 2, step * i);
      path.relativeLineTo(size.width, 0);

      path.moveTo(
        -size.width / 2,
        -step * i,
      );
      path.relativeLineTo(size.width, 0);
    }

    canvas.drawPath(path, _gridPaint);
  }

  void _drawAxisText(
      Canvas canvas,
      String str, {
        Color color = Colors.black,
        bool? x = false,
      }) {
    TextSpan text = TextSpan(
        text: str,
        style: TextStyle(
          fontSize: 11,
          color: color,
        ));

    _textPainter.text = text;
    _textPainter.layout(); // 进行布局
    Size size = _textPainter.size;
    Offset offset = Offset.zero;
    if (x == null) {
      offset = Offset(-size.width * 1.5, size.width * 0.7);
    } else if (x) {
      offset = Offset(-size.width / 2, size.height / 2);
    } else {
      offset = Offset(size.height / 2, -size.height / 2 + 2);
    }
    _textPainter.paint(canvas, offset);
  }

  void _drawText(Canvas canvas, Size size) {
    // y > 0 轴 文字
    canvas.save();
    for (int i = 0; i < size.height / 2 / step; i++) {
      if (step < 30 && i.isOdd || i == 0) {
        canvas.translate(0, step);
        continue;
      } else {
        var str = (i * step).toInt().toString();
        _drawAxisText(canvas, str, color: textColor);
      }
      canvas.translate(0, step);
    }
    canvas.restore();

    // x > 0 轴 文字
    canvas.save();
    for (int i = 0; i < size.width / 2 / step; i++) {
      if (i == 0) {
        _drawAxisText(canvas, "O", color: Colors.black, x: null);
        canvas.translate(step, 0);
        continue;
      }
      if (step < 30 && i.isOdd) {
        canvas.translate(step, 0);
        continue;
      } else {
        var str = (i * step).toInt().toString();
        _drawAxisText(canvas, str, color: textColor, x: true);
      }
      canvas.translate(step, 0);
    }
    canvas.restore();

    // y < 0 轴 文字
    canvas.save();
    for (int i = 0; i < size.height / 2 / step; i++) {
      if (step < 30 && i.isOdd || i == 0) {
        canvas.translate(0, -step);
        continue;
      } else {
        var str = (-i * step).toInt().toString();
        _drawAxisText(canvas, str, color: textColor);
      }

      canvas.translate(0, -step);
    }
    canvas.restore();

    // x < 0 轴 文字
    canvas.save();
    for (int i = 0; i < size.width / 2 / step; i++) {
      if (step < 30 && i.isOdd || i == 0) {
        canvas.translate(-step, 0);
        continue;
      } else {
        var str = (-i * step).toInt().toString();
        _drawAxisText(canvas, str, color: textColor, x: true);
      }
      canvas.translate(-step, 0);
    }
    canvas.restore();
  }
}
