import 'dart:math';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flutter/material.dart';

class Ground extends Component {
  static const double size = 1500;
  static const Rect bounds = Rect.fromLTWH(-size, -size, 2 * size, 2 * size);

  static final Paint _paintBorder = Paint()
    ..color = Colors.white12
    ..strokeWidth = 10
    ..style = PaintingStyle.stroke;
  static final Paint _paintBg = Paint()..color = const Color(0xFF333333);

  static final _rng = Random();

  late final List<Paint> _paintPool;
  late final List<Rect> _rectPool;

  Ground() : super(priority: 0) {
    _paintPool = List<Paint>.generate(
      (size / 50).ceil(),
          (_) => PaintExtension.random(rng: _rng)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2,
      growable: false,
    );
    _rectPool = List<Rect>.generate(
      (size / 50).ceil(),
          (i) => Rect.fromCircle(center: Offset.zero, radius: size - i * 50),
      growable: false,
    );
  }

  @override
  void render(Canvas canvas) {
    canvas.drawRect(bounds, _paintBg);
    canvas.drawRect(bounds, _paintBorder);
    for (var i = 0; i < (size / 50).ceil(); i++) {
      canvas.drawCircle(Offset.zero, size - i * 50, _paintPool[i]);
      canvas.drawRect(_rectPool[i], _paintBorder);
    }
  }

  static double genCoord() {
    return -size + _rng.nextDouble() * (2 * size);
  }
}
