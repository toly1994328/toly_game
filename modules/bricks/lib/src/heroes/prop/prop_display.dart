import 'dart:async';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import '../../bricks_game.dart';
import 'prop.dart';

class PropDisplay extends PositionComponent with HasGameRef<BricksGame> {
  final Prop prop;
  late double _life = prop.time;

  PropDisplay(this.prop);

  late TextComponent time = TextComponent(
    text: "$_life s",
    anchor: Anchor.center,
    textRenderer:
        TextPaint(style: const TextStyle(color: Colors.white, fontSize: 12)),
  );

  void addOne() {
    _life += prop.time;
  }

  @override
  FutureOr<void> onLoad() {
    SpriteComponent sprite = SpriteComponent(sprite: game.loader[prop.src]);
    add(sprite);
    add(time);
    time.x = sprite.width / 2;
    time.y = -time.height / 2;
    size = sprite.size;
    return super.onLoad();
  }

  @override
  void update(double dt) {
    if(isRemoving) return;
    _life -= dt;
    time.text = '${_life.toStringAsFixed(1)} s';
    if (_life < 0) {
      removeFromParent();
    }
    super.update(dt);
  }

  @override
  void onRemove() {
    super.onRemove();
    if(prop==Prop.expand){
      game.world.paddle.expandEnd();
    }
  }
}
