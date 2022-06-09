import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class TextInfoComponent extends PositionComponent{

  TextInfoComponent({required Vector2 position}):super(position: position);

  final TextStyle _textStyle = const TextStyle(
      fontSize: 12,
      color: Colors.white,
      shadows: [
        Shadow(color: Colors.red, offset: Offset(1, 1), blurRadius: 1),
      ]);


  @override
  Future<void> onLoad() async{
    TextComponent damageText = TextComponent(textRenderer: TextPaint(style: _textStyle));
    damageText.text =
    '1 移动了 MoveByEffect\n'
    '2 移动到 MoveToEffect\n'
    '3 旋转了 RotateEffect.by\n'
    '4 旋转到 RotateEffect.to\n'
    '5 缩放了 ScaleEffect.by\n'
    '6 缩放到 ScaleEffect.to\n'
    '7 移除 RemoveEffect\n'
    '8 尺寸加了 SizeEffect.by\n'
    '9 尺寸到 SizeEffect.to\n'
    'q 透明度加了 OpacityEffect.by\n'
    'w 透明度到 OpacityEffect.to\n'
    'e 颜色特效 ColorEffect\n'

    ;
    add(damageText);
  }

}
