enum GameStatus {
  ready,
  died,
  playing,
  win,
}

enum Mode{
  primary,
  middle,
  advanced,
  diy,
}

typedef XY = (int, int);


class GameMode {
  final XY size;
  final int mineCount;
  final Mode mode;

  int get column => size.$1;

  int get row => size.$2;

  const GameMode(this.size, this.mineCount):mode=Mode.diy;

  const GameMode.primary()
      : size = (9, 9),
        mineCount = 10,mode=Mode.primary;

  const GameMode.middle()
      : size = (16, 16),
        mineCount = 40,mode=Mode.middle;

  const GameMode.advanced({bool portrait=false})
      : size = portrait?(16, 30):(30, 16),
        mineCount = 99,mode=Mode.advanced;
}