
import 'package:flame/components.dart';
import 'package:flutter/material.dart';


class HelpText extends PositionComponent   {
  TextStyle infoStyle = const TextStyle(fontSize: 12, color: Colors.white);

  final String _info = '提示信息:\n'
      '键盘 ↑ : 世界向上移动\n'
      '键盘 ↓ : 世界向下移动\n'
      '键盘 ← : 世界向左移动\n'
      '键盘 → : 世界向右移动\n'
      '键盘 [ : 世界放大\n'
      '键盘 ] : 世界缩小\n'
      '键盘 T : 世界旋转变换\n'
      '键盘 R : 世界恢复原状\n'
  ;


  HelpText();


  @override
  Future<void> onLoad() async {

    add(TextComponent(
      position: position.translated(20, 40),
      text: _info,
      textRenderer: TextPaint(style: infoStyle),
    ));
  }
}
