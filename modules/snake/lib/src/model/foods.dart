import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

const kColorSupport = [
  Colors.redAccent,
  Colors.orange,
  Colors.yellow,
  Colors.brown,
  Colors.indigo,
  Colors.purple,
  Colors.pink,
  Colors.cyanAccent,
  Colors.cyan,
];

class FoodNode {
  final Color color;
  final Point<int> position;
  final int score;

  FoodNode({
   required this.color,
   required this.position,
   required this.score,
  });

}
