import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';

import '../../../painter/decoration/border_decoration.dart';
import '../../config/color_res.dart';
import '../../model/game_state.dart';
import '../../sweeper_game.dart';

class SweepButtons extends PositionComponent with HasGameRef<SweeperGame>{
  @override
  FutureOr<void> onLoad() {
    anchor = const Anchor(0, 1);
    y = -4;
    double gap = 6;
    SweepTextButton btn1 = SweepTextButton('初级',onTap,id:0);
    SweepTextButton btn2 = SweepTextButton('中级',onTap,id:1);
    SweepTextButton btn3 = SweepTextButton('高级',onTap,id:2);
    add(btn1);
    add(btn2);
    add(btn3);

    btn2.x=btn1.width+gap;
    btn3.x=btn2.x+btn1.width+gap;
    size = Vector2(btn1.width+btn2.width+btn3.width+2, btn3.height);

    return super.onLoad();
  }

  void onTap(int index){
    if(index==0){
      game.changeMode(const GameMode.primary());
    }
    if(index==1){
      game.changeMode(const GameMode.middle());
    }
    if(index==2){
      bool portrait = game.size.y>game.size.x;
      game.changeMode(GameMode.advanced(portrait: portrait));
    }
  }

}

class SweepTextButton extends PositionComponent with HasGameRef<SweeperGame>, TapCallbacks {
  final String text;
  final int id;
  final double strokeWidth;
  final ValueChanged<int> onTap;

  SweepTextButton(this.text, this.onTap,  {this.strokeWidth = 2,required this.id,});

  TextStyle infoStyle = const TextStyle(
      fontSize: 12, color: Colors.white, fontWeight: FontWeight.bold,shadows: [
        BoxShadow(color:Colors.black,offset: Offset(1, 1),blurRadius: 1),
  ]);

  @override
  FutureOr<void> onLoad() {
    TextComponent btn = TextComponent(
      text: text,
      anchor: Anchor.center,
      textRenderer: TextPaint(style: infoStyle),
    );
    add(btn);
    size = btn.size + Vector2(18, 6);
    btn.position = size / 2;
    return super.onLoad();
  }

  bool _perssed = false;

  @override
  void onTapDown(TapDownEvent event) {
    _perssed = true;
    super.onTapDown(event);
  }

  bool get active => game.mode.mode.index==id;
  Color get bgColor => active?Colors.blue: const Color(0xffc0c0c0);

  @override
  void onTapCancel(TapCancelEvent event) {
    _perssed = false;
    super.onTapCancel(event);
  }

  @override
  void onTapUp(TapUpEvent event) {
    onTap(id);
    _perssed = false;
    super.onTapUp(event);
  }

  // Color get bgColor => game.state.mode.mode

  @override
  void render(Canvas canvas) {
    canvas.drawRect(
        Rect.fromLTWH(0, 0, width, height), Paint()..color = bgColor);
    decoration.paint(Rect.fromLTWH(0, 0, width, height), canvas);

    super.render(canvas);
  }

  BorderDecoration get decoration {
    if(active){
      return BorderDecoration(
        strokeWidth: strokeWidth,
        right: ColorRes.gray,
        bottom: ColorRes.gray,
        top: ColorRes.gray,
        left: ColorRes.gray,
      );
    }
    return _perssed? BorderDecoration(
    strokeWidth: strokeWidth,
    right: ColorRes.white,
    bottom: ColorRes.white,
    top: ColorRes.gray,
    left: ColorRes.gray,
  ):BorderDecoration(
    strokeWidth: strokeWidth,
    right: ColorRes.gray,
    bottom: ColorRes.gray,
    top: ColorRes.white,
    left: ColorRes.white,
  );
  }

}
