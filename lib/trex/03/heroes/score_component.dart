
import 'package:flame/components.dart';
import 'package:flame/text.dart';

import '../trex_game.dart';

class ScoreComponent extends PositionComponent with HasGameReference<TrexGame> {

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    x = size.x - _score.width -20;
    y = 20;
  }

  late TextComponent _score;

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
    _score = TextComponent( textRenderer: renderer);
    _score.text = '1024  HI 2048';
    add(_score);
  }
}
