library dash_painter;

import 'dart:ui';

// [step] the length of solid line 每段实线长
// [span] the space of each solid line  每段空格线长
// [pointCount] the point count of dash line  点划线的点数
// [pointWidth] the point width of dash line  点划线的点划长

class DashPainter {
  const DashPainter({
    this.step = 2,
    this.span = 2,
    this.pointCount = 0,
    this.pointWidth,
  });

  final double step;
  final double span;
  final int pointCount;
  final double? pointWidth;

  void paint(Canvas canvas, Path path, Paint paint) {
    final PathMetrics pms = path.computeMetrics();
    final double pointLineLength = pointWidth ?? paint.strokeWidth;
    final double partLength =
        step + span * (pointCount + 1) + pointCount * pointLineLength;

    pms.forEach((PathMetric pm) {
      final int count = pm.length ~/ partLength;
      for (int i = 0; i < count; i++) {
        canvas.drawPath(
          pm.extractPath(partLength * i, partLength * i + step), paint,);
        for (int j = 1; j <= pointCount; j++) {
          final start =
              partLength * i + step + span * j + pointLineLength * (j - 1);
          canvas.drawPath(
            pm.extractPath(start, start + pointLineLength),
            paint,
          );
        }
      }
      final double tail = pm.length % partLength;
      canvas.drawPath(pm.extractPath(pm.length - tail, pm.length), paint);
    });
  }
}
