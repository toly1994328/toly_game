import 'dart:async';
import 'dart:math';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import '../../model/snake.dart';

class Snake extends PositionComponent {
  final Iterable<SnakeNode> points;
  final Color headColor;

  Snake(this.points, this.headColor);

  @override
  FutureOr<void> onLoad() {
    setFrame();
    return super.onLoad();
  }

  void setFrame() {
    removeWhere((e) => true);
    int i = 0;
    for (SnakeNode node in points) {
      CellType type = i == 0 ? CellType.snakeHeader : CellType.snakeBody;
      Color? color = i == 0 ? headColor :  node.color;
      add(Cell(node.position, type: type, side: 24,color: color));
      i++;
    }
  }
}

enum CellType { snakeHeader, snakeBody, food }

class Cell extends PositionComponent {
  final Point<int> point;
  final double side;
  final CellType type;
  final Color? color;
  final int? value;

  Cell(
    this.point, {
    this.side = 20,
    this.color,
    this.value,
    this.type = CellType.snakeBody,
  }) : super(size: Vector2(side, side));

  @override
  FutureOr<void> onLoad() {
    if(value!=null){
      TextStyle style =
          TextStyle(fontSize: 8, fontFamily: 'BlackOpsOne', package: 'life_game', color: textColor);
      TextComponent text = TextComponent(
        text: '$value',
        textRenderer: TextPaint(style: style),
        position: Vector2(point.x * side, point.y * side),
        anchor: Anchor.center,
      );
      add(text);
      text.position = text.position + size / 2;
    }

    return super.onLoad();
  }

  @override
  void render(Canvas canvas) {
    Paint paint = Paint()..color = bodyColor;
    if(type==CellType.food){
      Rect zone = Rect.fromLTWH(point.x * side, point.y * side, width, height);
      canvas.drawRRect(RRect.fromRectXY(zone.inflate(-2), 2, 2), paint);
    }else{
      canvas.drawRect(Rect.fromLTWH(point.x * side, point.y * side, width, height), paint);
    }
    
  }

  Color? get textColor {
    if (type == CellType.snakeHeader || type == CellType.food) return Colors.white;
    return Colors.grey;
  }

  Color get bodyColor {
    if(color!=null) {
      if(type == CellType.snakeBody){
        return color!.withOpacity(0.8);
      }
      return color!;
    }
    if (type == CellType.snakeHeader) return Colors.blue;
    if (type == CellType.food) return Colors.redAccent;
    return Colors.white;
  }
}
