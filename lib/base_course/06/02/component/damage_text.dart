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

  Future<void> addDamage(int damage) async {
    TextComponent damageText =
    TextComponent(textRenderer: TextPaint(style: _damageTextStyle));
    damageText.text = damage.toString();
    damageText.position = Vector2(-30, 0);
    add(damageText);
    await Future.delayed(const Duration(seconds: 1));
    damageText.removeFromParent();
  }

}
