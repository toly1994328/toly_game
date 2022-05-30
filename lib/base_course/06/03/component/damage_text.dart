import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class DamageText extends PositionComponent{

  final TextStyle _damageTextStyle = const TextStyle(
      fontSize: 14,
      color: Colors.white,
      fontFamily: 'Menlo',
      shadows: [
        Shadow(color: Colors.red, offset: Offset(1, 1), blurRadius: 1),
      ]);
  final TextStyle _critDamageTextStyle = const TextStyle(
      fontSize: 15,
      color: Colors.yellow,
      fontFamily: 'Menlo',
      shadows: [
        Shadow(color: Colors.red, offset: Offset(1, 1), blurRadius: 1),
      ]);

  void addDamage(int damage,{bool isCrit = false}) {
    if(!isCrit){
      _addWhiteDamage(damage);
    }else{
      _addCritDamage(damage);
    }
  }

  Future<void> _addWhiteDamage(int damage) async {
    TextComponent damageText =
    TextComponent(textRenderer: TextPaint(style: _damageTextStyle));
    damageText.text = damage.toString();
    damageText.position = Vector2(-30, 0);
    add(damageText);
    await Future.delayed(const Duration(seconds: 1));
    damageText.removeFromParent();
  }

  Future<void> _addCritDamage(int damage) async {
    TextComponent damageText =
    TextComponent(textRenderer: TextPaint(style: _critDamageTextStyle));
    damageText.text = damage.toString();
    damageText.position = Vector2(-30, 0);
    TextStyle style = _critDamageTextStyle.copyWith(fontSize: 10);
    TextComponent infoText = TextComponent(textRenderer: TextPaint(style:style ));
    infoText.text = '暴击';
    infoText.position = Vector2(-30+damageText.width-infoText.width/2, -infoText.height/2);
    add(infoText);
    add(damageText);
    await Future.delayed(const Duration(seconds: 1));
    infoText.removeFromParent();
    damageText.removeFromParent();
  }


}
