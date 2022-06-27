import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';

class Background extends PositionComponent with HasGameRef{
  @override
  int priority = -1;

  late Paint white;
  late final Rect hugeRect;
  List<Circle> circles = [];

  Background() : super(size: Vector2.all(100000));
  @override
  Future<void> onLoad() async {
    white = BasicPalette.white.paint();
    Rect rect = size.toRect();
    hugeRect = rect.translate(-rect.width/2, -rect.height/2);
    initRandomBall();
  }

  void initRandomBall(){
    circles.clear();
    for(int i =1;i<20;i++){
      circles.add(Circle(Offset(i*20,0), 10,index: i));
    }
    for(int i =1;i<20;i++){
      circles.add(Circle(Offset(-i*20,0), 10,index: -i));
    }
  }

  @override
  void render(Canvas c) {
    c.drawRect(hugeRect, white);
    circles.forEach((element) {
      element.draw(c);
    });
  }
}

class Circle{
  final Offset position;
  final double size;
  final int index;

  Circle(this.position, this.size,{this.index=0});

  void draw(Canvas canvas){
    Color color = index>0?Colors.blue:Colors.red;
    canvas.drawCircle(position, size/2, Paint()..color=color);
  }


}