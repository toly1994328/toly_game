import 'dart:async';
import 'dart:math';

import '../model/game_state.dart';
import '../model/types.dart';
import 'game_face_logic.dart';
import 'game_hud_logic.dart';

mixin GameStateLogic on GameHudLogic, GameFaceLogic{
  /// 游戏模式
  GameMode mode = const GameMode.middle();
  /// 游戏状态
  GameStatus _status = GameStatus.ready;

  /// 地图数据
  Map<XY, CellType> cells = {};
  /// 已打开点集
  final List<XY> _openPos = [];
  /// 已标记点集
  final List<XY> _markPos = [];

  /// 随机数
  final Random _random = Random();

  set status(value){
    _status = value;
    switch(_status){
      case GameStatus.ready:
      case GameStatus.died:
      case GameStatus.win:
        closeTimer();
        break;
      case GameStatus.playing:
        startTimer();
    }
  }

  void lose() {
    status = GameStatus.died;
    emit(FaceType.lose);
  }

  bool get disable => _status == GameStatus.died || _status == GameStatus.win;

  int get ledMineCount => mode.mineCount - _markPos.length;

  void reset() {
    status = GameStatus.ready;
    _openPos.clear();
    _markPos.clear();
    cells.clear();
  }


  bool allowAutoOpen(XY pos) {
    return !isOpened(pos) && !isMarked(pos);
  }

  void initMapOrNot(XY pos) {
    if (_openPos.isEmpty) {
      status = GameStatus.playing;
      int row = mode.row;
      int column = mode.column;
      _createMine(pos, row, column,mode.mineCount);
      _createCellValue( row, column);
    }
  }

  void open(XY pos) {
    _openPos.add(pos);
    checkWinGame();
  }

  bool isOpened(XY pos) => _openPos.contains(pos);

  bool get isWin {
    return _openPos.length == mode.row * mode.column - mode.mineCount;
  }

  void checkWinGame() {
    if (isWin) {
      // Toast.success('恭喜胜利');
      status = GameStatus.win;
    }
  }

  void mark(XY pos) {
    _markPos.add(pos);
    changeMineCount(ledMineCount);
  }

  void unMark(XY pos) {
    _markPos.remove(pos);
    changeMineCount(ledMineCount);
  }

  bool isMarked(XY pos) => _markPos.contains(pos);

  void _createMine(XY pos, int row, int column,int mineCount) {
    List<XY> posPool = [];
    for (int i = 0; i < row; i++) {
      for (int j = 0; j < column; j++) {
        if (pos != (j, i)) {
          posPool.add((j, i));
        }
      }
    }
    while (cells.length < mineCount) {
      int index = _random.nextInt(posPool.length);
      XY target = posPool[index];
      cells[target] = CellType.mine;
      posPool.remove(target);
    }
  }

  void _createCellValue(int row, int column) {
    for (int y = 0; y < row; y++) {
      for (int x = 0; x < column; x++) {
        if (cells[(x, y)] != CellType.mine) {
          int count = _calculate(x, y);
          cells[(x, y)] = CellType.values[count];
        }
      }
    }
  }

  int _calculate(int x, int y) {
    int count = 0;
    for (int i =  y - 1; i <= y + 1; i++) {
      for (int j =  x - 1; j <= x + 1; j++) {
        if (cells[(j, i)] == CellType.mine) count++;
      }
    }
    return count;
  }
}
