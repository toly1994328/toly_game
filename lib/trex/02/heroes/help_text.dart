
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import '../trex_game.dart';

class HelpText extends PositionComponent with HasGameReference<TrexGame>  {
  TextStyle stateStyle = const TextStyle(fontSize: 12, color: Colors.blue);
  TextStyle infoStyle = const TextStyle(fontSize: 12, color: Colors.grey);

  final String _info = '提示信息:\n'
      '键盘a/点击: 切换恐龙状态\n'
      '键盘 d: 切换展示边框信息';

  String initState = '';

  HelpText(this.initState);

  double get centerY {
    return (game.size.y / 2) - height / 2;
  }

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    y = centerY;
    x = 60;
  }

  late TextComponent _stateText;

  void changeState(String state) {
    _stateText.text = state;
  }

  @override
  Future<void> onLoad() async {
    _stateText = TextComponent(
      text: initState,
      position: Vector2(0,68),
      textRenderer: TextPaint(style: stateStyle),
    );
    add(_stateText);
    add(TextComponent(
      position: position.translated(0, 68+20),
      text: _info,
      textRenderer: TextPaint(style: infoStyle),
    ));
  }
}
