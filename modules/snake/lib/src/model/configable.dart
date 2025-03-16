import 'package:flame/components.dart';
import 'package:snake/src/model/speed.dart';

mixin Configable {
  int column = 30;
  int row = 16;
  double boxSize = 24;

  Vector2 get gridSize=> Vector2(column * boxSize, row * boxSize);
}

