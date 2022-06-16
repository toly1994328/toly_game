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
    '0 重置位置\n'
    '1 线性控制器 LinearEffectController\n'
    '2 曲线控制器 CurvedEffectController\n'
    '3 反向线性控制器 ReverseLinearEffectController\n'
    '4 反向曲线控制器 ReverseCurvedEffectController\n'
    '5 sin 曲线控制器 SineEffectController\n'
    '6 噪音曲线控制器 NoiseEffectController\n'
    '7 锯齿曲线控制器 ZigzagEffectController\n'
    '8 延时特效控制器 DelayedEffectController\n'
    '9 重复特效控制器 RepeatedEffectController\n'
    'q 无限特效控制器 InfiniteEffectController\n'
    'w 随机时长控制器 RandomEffectController\n'
    'e 速度控制器 SpeedEffectController\n'
    'r 序列控制器 SequenceEffectController\n'
    // '2 移动到 MoveToEffect\n'
    // '3 旋转了 RotateEffect.by\n'
    // '4 旋转到 RotateEffect.to\n'
    // '5 缩放了 ScaleEffect.by\n'
    // '6 缩放到 ScaleEffect.to\n'
    // '7 移除 RemoveEffect\n'
    // '8 尺寸加了 SizeEffect.by\n'
    // '9 尺寸到 SizeEffect.to\n'
    // 'q 透明度加了 OpacityEffect.by\n'
    // 'w 透明度到 OpacityEffect.to\n'
    // 'e 颜色特效 ColorEffect\n'
    // 'r 沿路径运动 MoveAlongPathEffect\n'

    ;
    add(damageText);
  }

}
