// Copyright 2014 The 张风捷特烈 . All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// Author:      张风捷特烈
// CreateTime:  2024-07-27
// Contact Me:  1981462002@qq.com

import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class Ruler extends PositionComponent {
  @override
  void onGameResize(Vector2 size) {
    this.size = Vector2(size.x, 40);
    super.onGameResize(size);
  }

  @override
  void render(Canvas canvas) {
    canvas.drawRect(Offset.zero&size.toSize(), Paint()..color=Colors.white);
  }
}
