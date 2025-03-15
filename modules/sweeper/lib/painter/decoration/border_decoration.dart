import 'dart:ui';

class BorderDecoration {
  final double strokeWidth;
  final Color top;
  final Color right;
  final Color bottom;
  final Color left;

  BorderDecoration({
    required this.strokeWidth,
    required this.top,
    required this.right,
    required this.bottom,
    required this.left,
  });

  void paint(Rect rect, Canvas canvas) {
    Paint paint = Paint()..strokeWidth = strokeWidth..strokeCap = StrokeCap.round;
    canvas.drawLine(
      rect.topRight, rect.topRight + Offset(0, rect.height),
      paint..color = right,
    );
    canvas.drawLine(
      rect.bottomLeft, rect.bottomLeft + Offset(rect.width, 0),
      paint..color = bottom,
    );
    canvas.drawLine(
      rect.topLeft, rect.topLeft + Offset(rect.width, 0),
      paint..color = top,
    );
    canvas.drawLine(
      rect.topLeft, rect.topLeft + Offset(0, rect.height),
      paint..color = left,
    );
  }
}
