
import 'dart:math';
import 'dart:ui';

class SnakeNode {
  final Point<int> position;
  Color? color;

  SnakeNode({
    required this.position,
    this.color,
  });
}