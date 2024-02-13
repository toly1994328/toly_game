import 'package:flame/components.dart';
import 'package:flame/text.dart';

import '../trex_game.dart';

const String kHighestScoreKey = 'highestScore';

class ScoreComponent extends PositionComponent with HasGameReference<TrexGame> {
  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    x = size.x - 360;
    y = 20;
  }

  late TextComponent _scoreText;

  @override
  Future<void> onLoad() async {
    const chars = '0123456789HI ';
    final renderer = SpriteFontRenderer.fromFont(
      SpriteFont(
        source: game.spriteImage,
        size: 23,
        ascent: 23,
        glyphs: [
          for (var i = 0; i < chars.length; i++)
            Glyph(chars[i], left: 954.0 + 20 * i, top: 0, width: 20),
        ],
      ),
      letterSpacing: 2,
    );
    highestScore = game.sp.getInt(kHighestScoreKey)??0;
    _scoreText = TextComponent(textRenderer: renderer);
    add(_scoreText);
  }

  int get score =>_score;

  set score(int newScore) {
    _score = newScore;
    _scoreText.text = '${scoreString(_score)}  HI ${scoreString(highestScore)}';
  }

  String scoreString(int score) => score.toString().padLeft(5, '0');

  int _score = 0;
  int highestScore = 0;

  double _distance = 0;
  final double acceleration = 20;

  @override
  void update(double dt) {
    super.update(dt);
    if (game.state == GameState.running) {
      _distance += dt * game.moveSpeed;
      score = _distance ~/ 5;
      // 分数
      int level = _score ~/ 1000;
      if (level <= 10) {
        game.moveSpeed = game.kInitSpeed + level * acceleration;
      }
    }
  }

  void saveHistory() async{
    if (score > highestScore) {
      highestScore = score;
      await game.sp.setInt(kHighestScoreKey, highestScore);
    }
  }

}
