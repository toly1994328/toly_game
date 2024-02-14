import 'package:flame/components.dart';
import 'package:flame/text.dart';
import 'package:flutter/material.dart';

class FpsText extends PositionComponent {
  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    x = 10;
    y = 8;
  }

  late TextComponent text = TextComponent(
    textRenderer: TextPaint(style: const TextStyle(fontSize: 14, color: Colors.grey)),
  );

  @override
  Future<void> onLoad() async => add(text);

  int _timeRecord = 0;
  int _frameCount = 0;

  @override
  void update(double dt) {
    super.update(dt);
    int now = DateTime.now().millisecondsSinceEpoch;
    _frameCount++;
    int span = now - _timeRecord;
    if (span > 500) {
      _timeRecord = now;
      text.text = 'FPS: ${(_frameCount / span * 1000).toInt()}';
      _frameCount = 0;
    }
  }
}
