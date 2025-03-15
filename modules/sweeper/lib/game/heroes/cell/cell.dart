import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame_svg/flame_svg.dart';

import '../../model/types.dart';
import '../../sweeper_game.dart';

class Cell extends SvgComponent with HasGameRef<SweeperGame> {
  final (int, int) pos;

  Cell(this.pos);

  @override
  FutureOr<void> onLoad() {
    double cellSize = game.sizeRes.cellSize;
    size = Vector2(cellSize, cellSize);
    svg = game.loader.findSvg('closed.svg');
    return super.onLoad();
  }

  void pressed() {
    svg = game.loader.findSvg('pressed.svg');
  }

  void died() {
    svg = game.loader.findSvg('mine_red.svg');
  }

  void mark() {
    svg = game.loader.findSvg('flag.svg');
  }

  void unMark() {
    reset();
  }

  void open() {
    CellType? type = game.cells[pos];
    if (type != null) {
      svg = game.loader.findSvg(type.key);
      game.open(pos);
    }
  }

  void openMine() {
    CellType? type = game.cells[pos];
    if (type != null&&type==CellType.mine) {
      svg = game.loader.findSvg(type.key);
      game.open(pos);
    }
  }


  void reset() {
    svg = game.loader.findSvg('closed.svg');
  }
}
