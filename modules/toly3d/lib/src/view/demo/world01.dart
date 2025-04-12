import 'dart:math';

import 'package:flutter/material.dart';
import 'package:toly3d/toly3d.dart';
import 'package:tolyui/tolyui.dart';

import '../../core/project/project.dart';

class World3D extends CustomPainter {
  final double rotationZ;
  final double d;

  World3D({this.rotationZ = 0, this.d = 18});

  // Offset project(Point3D p) {
  //   double scale = 40.0;
  //   double angle = 30 / 180 * pi;
  //   final x = (p.x - p.y) * cos(angle);
  //   final y = (p.x + p.y) * sin(angle) - p.z;
  //   return Offset(x * scale, y * scale);
  // }

  Project _project = Project();

  // 3D点投影到2D平面
  Offset project(Point3D p) {
    return _project.simpleProject(p);
    // double scale = 32.0; // 缩放系数
    // double angle = 30 / 180 * pi; // 30度弧度值（π/6）
    //
    // // 绕Z轴旋转
    // final rx = p.x * cos(rotationZ) - p.y * sin(rotationZ);
    // final ry = p.x * sin(rotationZ) + p.y * cos(rotationZ);
    //
    // // 等轴测投影
    // final xProj = (rx - ry) * cos(angle);
    // final yProj = (rx + ry) * sin(angle) - p.z;
    //
    // double radio = d / (d - yProj);
    // // radio = 1;
    // return Offset(xProj * scale * radio, yProj * scale * radio);
  }

  @override
  void paint(Canvas canvas, Size size) {
    Rect rect = Offset.zero & size;
    canvas.clipRect(rect);
    final center = Offset(size.width / 2, size.height / 2);

    // 平移画布到中心
    canvas.translate(center.dx, center.dy);

    final grid = Paint()
      ..style = PaintingStyle.stroke
      ..color = Colors.grey;
    canvas.drawLine(
        Offset(-size.width / 2, 0), Offset(size.width / 2, 0), grid);
    canvas.drawLine(
        Offset(0, -size.height / 2), Offset(0, size.height / 2), grid);

    // 绘制坐标系轴
    _drawAxis(canvas, Colors.red, Point3D(6, 0, 0), 'X'); // X轴
    _drawAxis(canvas, Colors.green, Point3D(0, 6, 0), 'Y'); // Y轴
    _drawAxis(canvas, Colors.blue, Point3D(0, 0, 4), 'Z'); // Z轴

    canvas.drawArc(
        Rect.fromCenter(center: Offset.zero, width: 40, height: 40),
        0,
        30 / 180 * pi,
        false,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1
          ..color = Colors.white);

    // 绘制轴标签
    TextStyle style = TextStyle(color: Colors.white, fontSize: 16);
    TextPainter(
        text: TextSpan(text: "30°", style: style),
        textDirection: TextDirection.ltr)
      ..layout()
      ..paint(canvas, const Offset(35, -2));
    TextPainter(
        text: TextSpan(text: "x", style: style),
        textDirection: TextDirection.ltr)
      ..layout()
      ..paint(canvas, const Offset(260, -24));

    TextPainter(
        text: TextSpan(text: "y", style: style),
        textDirection: TextDirection.ltr)
      ..layout()
      ..paint(canvas, const Offset(-16, 160));

    // drawStep1(canvas);
    // drawStep2(canvas);

    drawLinePoint(canvas, 120);
    drawLinePoint(canvas, 160);
    drawLinePoint(canvas, 200);
    drawLinePoint(canvas, 240);
    // _drawAxis(canvas, Colors.green, Point3D(0, 6, 0), 'Y'); // Y轴
    // _drawAxis(canvas, Colors.blue, Point3D(0, 0, 6), 'Z'); // Z轴

    // _drawGrid(canvas);
    // drawPoint111(canvas);
  }

  void drawLinePoint(Canvas canvas, double d) {
    const double angle = 30 / 180 * pi; // 30度弧度值（π/6）
    double x = cos(angle) * d;
    double y = sin(angle) * d;

    Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..color = Colors.white;

    Path path = Path()
      ..moveTo(x, 0)
      ..relativeLineTo(0, y);
    const DashPainter(span: 6, step: 6).paint(canvas, path, paint);

    canvas.drawCircle(Offset(x, y), 4, Paint()..color = Colors.red);

    Path pathY = Path()
      ..moveTo(0, y)
      ..relativeLineTo(x, 0);
    DashPainter(span: 6, step: 6).paint(canvas, pathY, paint);
  }

  void drawStep1(Canvas canvas) {
    const double angle = 30 / 180 * pi; // 30度弧度值（π/6）
    double x = cos(angle) * 6 * 40.0;
    double y = sin(angle) * 6 * 40.0;

    Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..color = Colors.white;

    Path path = Path()
      ..moveTo(x, 0)
      ..relativeLineTo(0, y);
    const DashPainter(span: 6, step: 6).paint(canvas, path, paint);

    canvas.drawLine(
        Offset.zero,
        Offset(x, 0),
        Paint()
          ..color = Color(0x66F44336)
          ..strokeWidth = 4);
  }

  void drawStep2(Canvas canvas) {
    const double angle = 30 / 180 * pi; // 30度弧度值（π/6）
    double x = cos(angle) * 6 * 40.0;
    double y = sin(angle) * 6 * 40.0;

    Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..color = Colors.white;

    Path path = Path()
      ..moveTo(0, y)
      ..relativeLineTo(x, 0);
    DashPainter(span: 6, step: 6).paint(canvas, path, paint);

    canvas.drawLine(
        Offset.zero,
        Offset(0, y),
        Paint()
          ..color = Color(0x66F44336)
          ..strokeWidth = 4);

    canvas.drawCircle(Offset(x, y), 4, Paint()..color = Colors.red);

    TextStyle style = TextStyle(color: Colors.white, fontSize: 16);

    TextPainter(
        text: TextSpan(text: "p:(x,y)", style: style),
        textDirection: TextDirection.ltr)
      ..layout()
      ..paint(canvas, Offset(x - 8, y + 4));

    TextPainter(
        text: TextSpan(text: "p.x = 240*cos(30°)", style: style),
        textDirection: TextDirection.ltr)
      ..layout()
      ..paint(canvas, Offset(x - 160, -32));

    TextPainter(
        text: TextSpan(text: "p.y = 240*sin(30°)", style: style),
        textDirection: TextDirection.ltr)
      ..layout()
      ..paint(canvas, Offset(-140, y / 2 - 12));

    TextPainter(
        text: TextSpan(text: "d=240", style: style),
        textDirection: TextDirection.ltr)
      ..layout()
      ..paint(canvas, Offset(x - 130, 0 + y / 2));
  }

  void drawStep3(Canvas canvas) {
    const double angle = 30 / 180 * pi; // 30度弧度值（π/6）
    double x = cos(angle) * 6 * 40.0;
    double y = sin(angle) * 6 * 40.0;

    Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..color = Colors.white;

    final p1 = project(Point3D(4, 1, 0));
    canvas.drawCircle(p1, 2, paint..color = Colors.cyanAccent);

    List<(Point3D, Point3D)> lines = [
      (Point3D(0, 1, 0), Point3D(4, 1, 0)),
      (Point3D(4, 0, 0), Point3D(4, 1, 0)),
    ];
    for (var line in lines) {
      Offset p0 = project(line.$1);
      Offset p1 = project(line.$2);
      canvas.drawLine(p0, p1, paint);
    }

    paint..color = Colors.white;
    canvas.drawLine(Offset(p1.dx, 0), Offset(p1.dx, p1.dy), paint);
    canvas.drawLine(Offset(0, p1.dy), Offset(p1.dx, p1.dy), paint);
  }

  void _drawAxis(Canvas canvas, Color color, Point3D endPoint, String label) {
    Paint paint = Paint()
      ..color = color
      ..strokeWidth = 2;
    Offset start = project(Point3D.zero());
    Offset end = project(endPoint);
    canvas.drawLine(start, end, paint);

    // 绘制轴标签
    TextStyle style = TextStyle(color: color, fontSize: 16);
    TextPainter(
        text: TextSpan(text: label, style: style),
        textDirection: TextDirection.ltr)
      ..layout()
      ..paint(canvas, end + const Offset(5, -10));
  }

  void _drawGrid(Canvas canvas) {
    List<(Point3D, Point3D)> lines = [];
    for (double i = -32; i <= 32; i++) {
      lines.add((Point3D(i, -5, 0), Point3D(i, 5, 0)));
      lines.add((Point3D(-5, i, 0), Point3D(5, i, 0)));
    }

    Paint paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 1;

    for (var line in lines) {
      Offset p0 = project(line.$1);
      Offset p1 = project(line.$2);
      canvas.drawLine(p0, p1, paint);
    }
  }

  List<(Point3D, Point3D)> draw1() {
    List<(Point3D, Point3D)> bottomLines = [
      (Point3D(0, 0, 0), Point3D(0, 1, 0)),
      (Point3D(0, 0, 0), Point3D(1, 0, 0)),
      (Point3D(0, 0, 0), Point3D(1, 1, 0)),
      (Point3D(0, 1, 0), Point3D(1, 1, 0)),
      (Point3D(1, 0, 0), Point3D(1, 1, 0)),
      (Point3D(0, 1, 0), Point3D(1, 0, 0)),
    ];
    return bottomLines;
  }

  void drawPoint111(Canvas canvas) {
    Paint paint = Paint()
      ..color = Colors.grey
      ..strokeWidth = 1;

    {
      final p1 = project(Point3D(0, 0, 0));
      final p2 = project(Point3D(1, 1, 1));
      canvas.drawLine(p1, p2, paint..color = Colors.cyanAccent);
    }

    {
      final p1 = project(Point3D(1, 1, 0));
      final p2 = project(Point3D(1, 1, 1));
      canvas.drawLine(p1, p2, paint..color = Colors.grey);
    }

    {
      final p1 = project(Point3D(0, 0, 1));
      final p2 = project(Point3D(1, 1, 1));
      canvas.drawLine(p1, p2, paint..color = Colors.grey);
      canvas.drawCircle(p2, 4, paint..color = Colors.orange);
    }
  }

  @override
  bool shouldRepaint(World3D oldDelegate) => rotationZ != oldDelegate.rotationZ;
}
