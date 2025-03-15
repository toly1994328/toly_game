import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame/events.dart';


import '../../logic/game_cell_logic.dart';
import '../../sweeper_game.dart';
import 'cell.dart';

class CellManager extends PositionComponent
    with HasGameRef<SweeperGame>, DragCallbacks,TapCallbacks,GameCellLogic {
  @override
  FutureOr<void> onLoad() {
    size = game.sizeRes.gridSize;
    double gap = game.sizeRes.gap;
    double height = game.sizeRes.hudSize.y + gap * 2;
    position = Vector2(gap, height);
    addAll(_createCells());
    return super.onLoad();
  }

  List<Cell> _createCells() {
    int rowCount = game.sizeRes.gridXY.$2;
    int columnCount = game.sizeRes.gridXY.$1;
    double cellSize = game.sizeRes.cellSize;
    List<Cell> result = [];
    for (int i = 0; i < rowCount; i++) {
      for (int j = 0; j < columnCount; j++) {
        Cell cell = Cell((j, i));
        cell.x = cellSize * j;
        cell.y = cellSize * i;
        result.add(cell);
      }
    }
    return result;
  }


}
