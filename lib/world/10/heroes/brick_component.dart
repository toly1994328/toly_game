import 'package:flame/components.dart';
import 'package:flutter/material.dart';

const List<Color> _kColors = [Colors.red, Colors.green, Colors.blue, Colors.yellow];

class BrickComponent extends PositionComponent {
  final Vector2 brickSize = Vector2(300, 12);
  int index;

  BrickComponent({this.index = 0});

  late TextComponent text;

  void updateInfo(int value,double posX){
    index = value;
    x = posX;
    text.text = '$index';
  }

  @override
  Future<void> onLoad() async{
     super.onLoad();
     add(text = TextComponent(
       text: '$index',
       position: Vector2(150-6,14),
       textRenderer: TextPaint(style: const TextStyle(fontSize: 14, color: Colors.blue)),
     ));
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    Paint paint = Paint()..style = PaintingStyle.stroke;
    canvas.drawRect(Rect.fromLTRB(0, 0, brickSize.x, brickSize.y),
        Paint()..color = _kColors[index % _kColors.length]);
    Path wallBottom = boxPath(0, Size(brickSize.x, brickSize.y));
    canvas.drawPath(wallBottom, paint);
  }

  Path boxPath(double y, Size wallSize, {double step = 15}) {
    Path path = Path()
      ..moveTo(0, y)
      ..lineTo(wallSize.width, y)
      ..relativeLineTo(0, wallSize.height)
      ..relativeLineTo(-wallSize.width, 0)
      ..relativeLineTo(0, -wallSize.height);
    double step = 15;
    for (double i = 0; i < wallSize.width - step; i += step) {
      path
        ..moveTo(step + i, y)
        ..relativeLineTo(-step, wallSize.height);
    }
    return path;
  }
}
