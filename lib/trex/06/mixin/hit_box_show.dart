import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

extension HitBoxShow on Component {
  void toggleHitBoxShow() {
    if (this is RectangleHitbox) {
      debugMode = !debugMode;
      debugColor = Colors.orange;
    }
  }

  void toggleHitBoxTree() {
    ComponentSet children = this.children;
    for (int i = 0; i < children.length; i++) {
      Component c = children.elementAt(i);
      if (c.children.isEmpty) {
        c.toggleHitBoxShow();
      } else {
        c.toggleHitBoxTree();
      }
    }
  }
}
