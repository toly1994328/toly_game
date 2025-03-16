

enum GameStatus {
  ready("Ready"),
  playing("Playing"),
  paused("Paused"),
  died("Game Over");

  final String label;
  const GameStatus(this.label);
}