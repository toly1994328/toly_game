import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

extension HitBoxShow on Component {

  void toggleHitBoxTree({Color color = Colors.orange}) {
    ComponentSet children = this.children;
    for (int i = 0; i < children.length; i++) {
      Component c = children.elementAt(i);
      if (c.children.isEmpty) {
        if (c is Hitbox) {
          c.debugMode = !c.debugMode;
          c.debugColor = color;
        }
      } else {
        c.toggleHitBoxTree();
      }
    }
  }
}
