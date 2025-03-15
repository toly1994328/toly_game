import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/events.dart';

import '../heroes/cell/cell.dart';
import '../model/types.dart';
import '../model/game_state.dart';
import '../sweeper_game.dart';

mixin GameCellLogic on DragCallbacks, TapCallbacks, HasGameRef<SweeperGame> {
  /// 被按压的单元格
  final List<Cell> _pressedCells = [];

  @override
  void onTapDown(TapDownEvent event) {
    pressed(event.localPosition);
    super.onTapDown(event);
  }

  @override
  void onLongTapDown(TapDownEvent event) {
    if (game.disable) return;
    print("========onLongTapDown=============");
    XY pos = trans(event.localPosition);
    if (game.isOpened(pos)) return;
    Cell? cell = activeCell(pos);
    if (cell != null) {
      cell.mark();
      game.mark(pos);
      unpressed();
    }
    super.onLongTapDown(event);
  }

  Cell? activeCell(XY pos) {
    List<Cell> cells = children.whereType<Cell>().toList();
    Iterable<Cell> targets = cells.where((e) => e.pos == pos);
    if (targets.isNotEmpty) {
      return targets.first;
    }
    return null;
  }

  @override
  void onDragUpdate(DragUpdateEvent event) {
    pressed(event.localStartPosition);
    super.onDragUpdate(event);
  }

  @override
  void onDragCancel(DragCancelEvent event) {
    unpressed();
    super.onDragCancel(event);
  }

  @override
  void onDragEnd(DragEndEvent event) {
    open();
    super.onDragEnd(event);
  }

  @override
  void onTapUp(TapUpEvent event) {
    open();
    super.onTapUp(event);
  }

  @override
  void onTapCancel(TapCancelEvent event) {
    unpressed();
    super.onTapCancel(event);
  }

  void open() {
    if (game.disable) return;
    if (_pressedCells.isNotEmpty) {
      Cell cell = _pressedCells.first;
      if (_handelMark(cell)) return;
      game.initMapOrNot(cell.pos);
      _handleOpenCell(cell);
      _pressedCells.clear();
    }
    unpressed();
  }

  bool _handelMark(Cell cell) {
    if (game.isMarked(cell.pos)) {
      cell.unMark();
      game.unMark(cell.pos);
      return true;
    }
    return false;
  }

  void _handleOpenCell(Cell cell) {
    CellType? type = game.cells[cell.pos];
    if (type == CellType.mine) {
      gameOver(cell);
    } else {
      cell.open();
      handleAutoOpen(type, cell.pos);
    }
  }

  void gameOver(Cell cell) {
    game.lose();
    Iterable<Cell> cells = children.whereType<Cell>();
    for (Cell cell in cells) {
      cell.openMine();
    }
    cell.died();
  }

  void autoOpenAt(XY pos) {
    if(!game.allowAutoOpen(pos)) return;
    Cell? cell = activeCell(pos);
    if (cell != null) {
      CellType? type = game.cells[pos];
      if (type != CellType.mine) {
        cell.open();
        handleAutoOpen(type, pos);
      }
    }
  }

  void handleAutoOpen(CellType? type, XY pos) {
    if (type != CellType.value0) return;
    int x = pos.$2;
    int y = pos.$1;
    for (int i = x - 1; i <= x + 1; i++) {
      for (int j = y - 1; j <= y + 1; j++) {
          autoOpenAt((j, i));
      }
    }
  }

  void unpressed() {
    if (game.disable) return;
    _pressedCells.clear();
    game.emit(FaceType.common);
  }

  void pressed(Vector2 vector2) {
    if (game.disable) return;
    game.emit(FaceType.active);
    pressedAt(trans(vector2));
  }

  XY trans(Vector2 vector2) {
    double cellSize = game.sizeRes.cellSize;
    int x = vector2.x ~/ cellSize;
    int y = vector2.y ~/ cellSize;
    return (x, y);
  }

  void pressedAt(XY pos) {
    if (!_allowPressAt(pos)) return;
    _resetPrevPressed();
    _doPressAt(pos);
  }

  bool _allowPressAt(XY pos) {
    return !game.isOpened(pos) &&
        _pressedCells.where((e) => e.pos == pos).isEmpty;
  }

  void _resetPrevPressed() {
    if (_pressedCells.isNotEmpty) {
      Cell lastActive = _pressedCells.removeLast();
      lastActive.reset();
    }
  }

  void _doPressAt(XY pos) {
    Cell? cell = activeCell(pos);
    if (cell != null) {
      if(!game.isMarked(pos)){
        cell.pressed();
      }
      _pressedCells.add(cell);
    }
  }

  // void _showAllFlag() {
  //   List<XY> v = game.cells.keys.toList();
  //   for (int i = 0; i < v.length; i++) {
  //     CellType? type = game.cells[v[i]];
  //     if (type == CellType.mine) {
  //       activeCell(v[i])?.mark();
  //     }
  //   }
  // }
  //
  // void _debugOpenAll() {
  //   List<XY> v = game.cells.keys.toList();
  //   for (int i = 0; i < v.length; i++) {
  //     CellType? type = game.cells[v[i]];
  //     activeCell(v[i])?.open();
  //   }
  // }
}
