// Copyright 2014 The 张风捷特烈 . All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// Author:      张风捷特烈
// CreateTime:  2024-07-28
// Contact Me:  1981462002@qq.com

import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class RulerValue extends ChangeNotifier {
  Matrix4 _transform = Matrix4.identity();

  Matrix4 get transform => _transform;

  set transform(Matrix4 value) {
    if(value==_transform) return;
    _transform = value;
    notifyListeners();
  }

  double get scale => _transform.getMaxScaleOnAxis();

  Offset get center => _transform.getTranslation().xy.toOffset();
}