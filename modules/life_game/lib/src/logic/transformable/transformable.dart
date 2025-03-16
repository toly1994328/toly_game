import 'dart:ui';

import 'package:flame/game.dart';

abstract class Transformable {
  void scale(double scale, Offset origin);

  void translation(Offset delta);

  Matrix4 get transform;

  void onMatrixChange(Matrix4 m4);
}

mixin TransformableMixin implements Transformable {

  @override
  void scale(double scale, Offset origin) {
    Matrix4 m4 = transform.clone();
    Offset center = transform.globalToLocal(origin);

    Matrix4 scaleM = Matrix4.diagonal3Values(scale, scale, 0);
    Matrix4 moveM = Matrix4.translationValues(center.dx, center.dy, 0);
    Matrix4 backM = Matrix4.translationValues(-center.dx, -center.dy, 0);
    m4.multiply(moveM);
    m4.multiply(scaleM);
    m4.multiply(backM);
    if (m4.getMaxScaleOnAxis() < 0.3) return;
    onMatrixChange(m4);
  }

  @override
  void translation(Offset delta) {
    Matrix4 m4 = transform;
    Matrix4 opM = Matrix4.translationValues(delta.dx, delta.dy, 0);
    opM.multiply(m4);
    onMatrixChange(opM);
  }
}

extension Matrix4Point on Matrix4{
  Offset globalToLocal(Offset point) {
    final m = storage;
    var det = m[0] * m[5] - m[1] * m[4];
    if (det != 0) {
      det = 1 / det;
    }
    final x = ((point.dx - m[12]) * m[5] - (point.dy - m[13]) * m[4]) * det;
    final y = ((point.dy - m[13]) * m[0] - (point.dx - m[12]) * m[1]) * det;
    return  Offset(x, y);
  }
}
