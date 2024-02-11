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
      _points.add(point);
    }
  }
}

class DotComponent extends PositionComponent {
  final TickerTap dotRecord;

  DotComponent(this.dotRecord);

  @override
  void onGameResize(Vector2 size) {
    y = size.y - 111;
    super.onGameResize(size);
  }

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
