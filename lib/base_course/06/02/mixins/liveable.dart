import 'dart:math';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import '../component/damage_text.dart';

mixin Liveable on PositionComponent {
  final Paint _outlinePaint = Paint();
  final Paint _fillPaint = Paint();
  late double lifePoint; // 生命上限
  late double _currentLife; // 当前生命值

  // 当前血条百分百
  double get _progress => _currentLife / lifePoint;

  final TextStyle _defaultTextStyle =
      const TextStyle(fontSize: 10, color: Colors.white);

  void loss(double point) {
    _damageText.addDamage(-point.toInt());

    _currentLife -= point;
    _updateLifeText();
    if (_currentLife <= 0) {
      _currentLife = 0;
      onDied();
    }
  }

  final DamageText _damageText = DamageText();

  void cure(double point) {
    _currentLife += point;
    _updateLifeText();
    if (_currentLife >= lifePoint) {
      _currentLife = lifePoint;
    }
  }

  void onDied() {}

  late final TextComponent _text;
  final double offsetY = 10; // 血条距构件顶部偏移量
  final double widthRadio = 0.8; // 血条/构件宽度
  final double lifeBarHeight = 4; // 血条高度

  void initPaint({
    required double lifePoint,
    Color lifeColor = Colors.red,
    Color outlineColor = Colors.white,
  }) {
    _outlinePaint
      ..color = outlineColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    _fillPaint.color = lifeColor;

    this.lifePoint = lifePoint;
    _currentLife = lifePoint;

    // 添加生命值文字
    _text = TextComponent(textRenderer: TextPaint(style: _defaultTextStyle));
    _updateLifeText();
    double y = -(offsetY + _text.height + 2);
    double x = (size.x / 2) * (1 - widthRadio);
    _text.position = Vector2(x, y);
    // _text.add(RectangleHitbox()..debugMode = true);
    add(_text);
    add(_damageText);
  }

  void _updateLifeText() {
    _text.text = 'Hp ${_currentLife.toInt()}';
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    Rect rect = Rect.fromCenter(
        center: Offset(size.x / 2, lifeBarHeight / 2 - offsetY),
        width: size.x * widthRadio,
        height: lifeBarHeight);

    Rect lifeRect = Rect.fromPoints(
        rect.topLeft + Offset(rect.width * (1 - _progress), 0),
        rect.bottomRight);

    canvas.drawRect(lifeRect, _fillPaint);
    canvas.drawRect(rect, _outlinePaint);
  }
}
