import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class DamageText extends PositionComponent{

  final TextStyle _damageTextStyle = const TextStyle(
      fontSize: 14,
      color: Colors.white,
      fontFamily: 'Menlo',
      shadows: [
        Shadow(color: Colors.red, offset: Offset(1, 1), blurRadius: 1),
      ]);
  final TextStyle _critDamageTextStyle = TextStyle(
      fontSize: 15,
      color: Colors.yellow,
      fontFamily: 'Menlo',
      shadows: [
        Shadow(color: Colors.red, offset: Offset(1, 1), blurRadius: 1),
      ]
  );


  void addDamage(int damage,{bool isCrit = false}) {
    Vector2 offset = Vector2(-30, 0);
    if(children.isNotEmpty){
      final PositionComponent last;
      if(children.last is PositionComponent){
        last = children.last as PositionComponent;
        offset = last.position + Vector2(5, last.height);
      }
    }
    if(!isCrit){
      _addWhiteDamage(damage,offset);
    }else{
      _addCritDamage(damage,offset);
    }
  }

  Future<void> _addWhiteDamage(int damage,Vector2 position) async {
    TextComponent damageText =
    TextComponent(textRenderer: TextPaint(style: _damageTextStyle));
    damageText.text = damage.toString();
    damageText.position = position;
    add(damageText);
    await Future.delayed(const Duration(seconds: 1));
    damageText.removeFromParent();
  }

  Future<void> _addCritDamage(int damage,Vector2 position) async {
    TextComponent damageText =
    TextComponent(textRenderer: TextPaint(style: _critDamageTextStyle));
    damageText.text = damage.toString();
    damageText.position = position;

    TextStyle style = _critDamageTextStyle.copyWith(fontSize: 10);
    TextComponent infoText = TextComponent(textRenderer: TextPaint(style:style ));
    infoText.text = '暴击';
    infoText.position = position + Vector2(damageText.width-infoText.width/2, -infoText.height/2);
    add(infoText);
    add(damageText);
    await Future.delayed(const Duration(seconds: 1));
    infoText.removeFromParent();
    damageText.removeFromParent();
  }


}
