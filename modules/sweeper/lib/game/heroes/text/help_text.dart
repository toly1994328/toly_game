
import 'package:flame/components.dart';
import 'package:flutter/material.dart';



class HelpText extends PositionComponent {
  TextStyle noticeStyle = const TextStyle(fontSize: 12, color: Colors.red,fontWeight: FontWeight.bold);
  TextStyle infoStyle = const TextStyle(fontSize: 12, color: Colors.blueAccent,fontWeight: FontWeight.bold);

  @override
  Future<void> onLoad() async {
    TextComponent notice=  TextComponent(
      text: '操作注意: ',
      textRenderer: TextPaint(style: noticeStyle),
    );
    add(notice);
    add(TextComponent(
      text: '长按 - 标记旗子',
      textRenderer: TextPaint(style: infoStyle),
    )..x=notice.width);
  }
}
