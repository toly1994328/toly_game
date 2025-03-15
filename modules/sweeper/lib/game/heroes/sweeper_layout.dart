import 'dart:async';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';


import '../../painter/decoration/border_decoration.dart';
import '../config/color_res.dart';
import '../sweeper_game.dart';

import 'cell/cell_manager.dart';
import 'text/help_text.dart';
import 'hud/sweeper_hud.dart';
import 'text/sweep_text_button.dart';

class SweeperLayout extends PositionComponent with HasGameRef<SweeperGame> {
  HelpText helpText = HelpText();

  FpsTextComponent fps = (FpsTextComponent(
    anchor:  const Anchor(1, 0),
      textRenderer: TextPaint(
    style: const TextStyle(fontSize: 12, color: Color(0xff808080)),
  )));

  @override
  void onGameResize(Vector2 size) {
    x = (size.x - width) / 2;
    y = (size.y - height) / 2;
    super.onGameResize(size);
  }

  @override
  FutureOr<void> onLoad() {
    size = game.sizeRes.layoutSize;
    double gap = game.sizeRes.gap;
    add(SweepButtons());
    SweeperHud hud = SweeperHud()..position = Vector2(gap, gap);
    add(hud);
    CellManager manager = CellManager();
    add(manager);

    // add(helpText..position = Vector2(x, height + 6));
    // add(fps);


    fps.position = Vector2(width, height + 8);
    return super.onLoad();
  }

  @override
  void render(Canvas canvas) {
    Rect rect = Offset.zero & Size(width, height);
    canvas.drawRect(rect, Paint()..color = ColorRes.background);
    _pintHudBorder(canvas);
    _paintGridBorder(canvas);
    _paintOutBorder(canvas, rect);
    super.render(canvas);
  }

  void _pintHudBorder(Canvas canvas) {
    double strokeWidth = game.sizeRes.gap * 0.35;
    BorderDecoration decoration = BorderDecoration(
      strokeWidth: strokeWidth,
      top: ColorRes.gray,
      left: ColorRes.gray,
      right: ColorRes.white,
      bottom: ColorRes.white,
    );
    decoration.paint(game.sizeRes.hudRect, canvas);
  }

  void _paintGridBorder(Canvas canvas) {
    double strokeWidth = game.sizeRes.gap * 0.42;
    BorderDecoration decoration = BorderDecoration(
      strokeWidth: strokeWidth,
      top: ColorRes.gray,
      left: ColorRes.gray,
      right: ColorRes.white,
      bottom: ColorRes.white,
    );
    decoration.paint(game.sizeRes.gridRect, canvas);
  }

  void _paintOutBorder(Canvas canvas, Rect rect) {
    double strokeWidth = game.sizeRes.gap * 0.25;
    BorderDecoration decoration = BorderDecoration(
      strokeWidth: strokeWidth,
      top: ColorRes.white,
      left: ColorRes.white,
      right: ColorRes.gray,
      bottom: ColorRes.gray,
    );
    decoration.paint(rect, canvas);
  }
}
