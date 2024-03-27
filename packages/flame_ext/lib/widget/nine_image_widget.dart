import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class NineImageWidget extends StatelessWidget {
  final Rect expandZone;
  final Widget? child;
  final ui.Image image;
  final double opacity;
  final EdgeInsetsGeometry? padding;

  const NineImageWidget({
    super.key,
    required this.expandZone,
    required this.image,
    this.child,
    this.opacity = 1,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _NightImagePainter(image, expandZone, opacity),
      child: padding == null ? child : Padding(padding: padding!, child: child),
    );
  }
}

final _emptyPaint = Paint();

class _NightImagePainter extends CustomPainter {
  final ui.Image image;
  final Rect expandZone;
  final double opacity;

  _NightImagePainter(this.image, this.expandZone, this.opacity);

  @override
  void paint(Canvas canvas, Size size) {
    Rect rect = Rect.fromLTWH(expandZone.left, expandZone.top,
        image.width - expandZone.right, image.height - expandZone.bottom);
    _emptyPaint.color = Colors.white.withOpacity(opacity);
    canvas.drawImageNine(image, rect, Offset.zero & size, _emptyPaint);
  }

  @override
  bool shouldRepaint(covariant _NightImagePainter oldDelegate) {
    return oldDelegate.expandZone != expandZone
        || oldDelegate.image != image||oldDelegate.opacity!=opacity;
  }
}
