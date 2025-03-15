import 'dart:async';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame_svg/flame_svg.dart';
import 'package:flutter/material.dart';

import '../../../painter/decoration/border_decoration.dart';
import '../../config/color_res.dart';
import '../../model/types.dart';
import '../../sweeper_game.dart';

class LedScreen extends PositionComponent with HasGameRef<SweeperGame> {
  final int count;
  final double ledWidth;
  final double ledSpace;

  LedScreen({
    this.count = 3,
    required this.ledWidth,
    required this.ledSpace,
  });

  Vector2 get screenSize => Vector2(
        ledWidth * count + (count - 1) * ledSpace + 2 * ledSpace,
        ledWidth * 2 + ledSpace,
      );

  @override
  FutureOr<void> onLoad() {
    size = screenSize;
    addAll(_createLedLamps());
    return super.onLoad();
  }

  List<Component> _createLedLamps() {
    List<Component> ledLamps = [];
    Vector2 ledSize = Vector2(ledWidth, ledWidth * 2);
    for (int i = 0; i < count; i++) {
      SvgComponent led = SvgComponent(
        svg: game.loader.findSvg('d0.svg'),
        size: ledSize,
        position: Vector2(ledSpace + (ledWidth + ledSpace) * i, ledSpace / 2),
      );
      ledLamps.add(led);
    }
    return ledLamps;
  }

  int _value = 0;

  set value(int value) {
    _value = value;
    List<SvgComponent> lamps = children.whereType<SvgComponent>().toList();
    String valueStr = _value.toString().padLeft(count, '0');
    for (int i = 0; i < lamps.length; i++) {
      String key = DigitalType.values[int.tryParse(valueStr[i]) ?? 0].key;
      lamps[i].svg = game.loader.findSvg(key);
    }
  }

  void setLed() {}

  @override
  void render(Canvas canvas) {
    Rect rect = Offset.zero & Size(width, height);
    canvas.drawRect(rect, Paint()..color = Colors.black);
    _paintGridBorder(canvas, rect);
    super.render(canvas);
  }

  void _paintGridBorder(Canvas canvas, Rect rect) {
    double strokeWidth = game.sizeRes.gap * 0.1;
    BorderDecoration decoration = BorderDecoration(
      strokeWidth: strokeWidth,
      top: ColorRes.gray,
      left: ColorRes.gray,
      right: ColorRes.white,
      bottom: ColorRes.white,
    );
    decoration.paint(rect, canvas);
  }
}
