import 'dart:ui';

import 'package:flame/components.dart';

class TickerTap {
  /// 打点计数器的频率: 1s 打多少个点
  double frequency = 0;

  TickerTap({this.frequency = 5});

  final List<Offset> _points = [];

  List<Offset> get points => _points;

  void clear() {
    _points.clear();
  }

  double _totalTime = 0;
  double _snapshot = 0;

  void onTick(Offset point, double dt) {
    _totalTime += dt;
    if ((_totalTime - _snapshot) > 1 / frequency) {
      _snapshot = _totalTime;
      bool canAdd = true;
      if(points.isNotEmpty){
        canAdd = (points.last-point).distance != 0;
      }
      if(canAdd){
        _points.add(point);
      }
    }
  }
}

class DotComponent extends PositionComponent {
  final TickerTap dotRecord;

  DotComponent(this.dotRecord);

  Paint paint = Paint()
    ..style = PaintingStyle.fill
    ..color = const Color(0xff133C9A);

  @override
  void render(Canvas canvas) {
    for (Offset points in dotRecord.points) {
      canvas.drawCircle(points, 4, paint);
    }
  }
}
