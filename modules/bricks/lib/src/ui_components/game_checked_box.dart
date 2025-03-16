import 'package:flame/components.dart';
import 'package:flame/widgets.dart';
import 'package:flutter/material.dart';

class GameCheckedBox extends StatelessWidget {
  final bool value;
  final Sprite inactive;
  final Sprite active;
  final Size size;

  const GameCheckedBox({
    super.key,
    required this.value,
    required this.inactive,
    required this.active,
    this.size = const Size(20,20,)
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size.width,
      height: size.height,
      child: SpriteWidget(
        // srcSize: Vector2(24,24),
        sprite: value ? active : inactive,
        anchor: Anchor.center,
      ),
    );
  }
}
