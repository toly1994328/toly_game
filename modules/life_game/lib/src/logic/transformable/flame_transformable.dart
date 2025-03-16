// Copyright 2014 The 张风捷特烈 . All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// Author:      张风捷特烈
// CreateTime:  2024-07-23
// Contact Me:  1981462002@qq.com

import 'dart:ui';

import 'package:flame/camera.dart';
import 'package:flame/game.dart';

import 'transformable.dart';


mixin TransformGame<T extends World> on TransformableMixin, FlameGame<T> implements Transformable {
  bool get enable;

  @override
  void scale(double scale, Offset origin) {
    if (!enable || scale < 0.3) return;
    super.scale(scale, origin);
    paused = false;
  }

  @override
  void translation(Offset delta) {
    if (!enable) return;
    super.translation(delta);
    paused = false;
  }

  @override
  Matrix4 get transform => camera.viewfinder.transform.transformMatrix;

  void onTransformTick();



  @override
  void onMatrixChange(Matrix4 m4) {
    camera.viewfinder.transform.transformMatrix = m4;
    // 限制触发 onTransformTick 的频率
    onTransformTick();
  }
}
