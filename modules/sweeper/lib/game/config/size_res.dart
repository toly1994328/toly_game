import 'package:flame/components.dart';
import 'package:flame/extensions.dart';

class SizeRes {
  final double cellSize;
  final (int, int) gridXY;

  SizeRes({
    this.cellSize = 18,
    this.gridXY = (16, 16),
  });

  Vector2 get gridSize => Vector2(gridXY.$1 * cellSize, gridXY.$2 * cellSize);

  Vector2 get hudSize => Vector2(gridXY.$1 * cellSize, cellSize * 2);

  Vector2 get faceSize => Vector2(cellSize * 1.5, cellSize * 1.5);

  Rect get hudRect => Rect.fromLTWH(gap, gap, hudSize.x, hudSize.y);

  Rect get gridRect =>
      Rect.fromLTWH(gap, hudSize.y + gap + gap, gridSize.x, gridSize.y);

  Vector2 get layoutSize => Vector2(
        gridSize.x + gap * 2,
        gridSize.y + hudSize.y + gap * 3,
      );

  double get gap => 0.618 * cellSize;

  double get ledSpace => cellSize * 0.12;

  double get ledWidth => cellSize * 0.64;
}
