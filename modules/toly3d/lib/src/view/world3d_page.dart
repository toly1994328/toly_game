import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toly3d/src/logic/bloc.dart';

import '../../toly3d.dart';
import '../core/project/project.dart';
import 'menus.dart';

class Word3dScope extends StatelessWidget {
  const Word3dScope({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<World3dBloc>(
      create: (_) {
        return World3dBloc();
      },
      child: World3dPage(),
    );
  }
}

class World3dPage extends StatefulWidget {
  const World3dPage({super.key});

  @override
  State<World3dPage> createState() => _World3dPageState();
}

class _World3dPageState extends State<World3dPage> {
  @override
  Widget build(BuildContext context) {
    World3dBloc bloc = context.watch<World3dBloc>();
    Transform3d transform = bloc.state.transform;
    bool showGrid = bloc.state.activeMenus.contains('grid');
    return Scaffold(
      backgroundColor: Colors.black,
      body: Row(
        children: [
          const Menus(),
          VerticalDivider(),
          Expanded(
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Column(
                  children: [
                    Divider(),
                    Expanded(
                        child: GestureDetector(
                      onDoubleTap: () {},
                      onPanDown: _onPanDown,
                      onPanUpdate: _onPanUpdate,
                      onPanEnd: _onPanEnd,
                      child: CustomPaint(
                        painter: World3D(
                          showGrid: showGrid,
                          rotationZ: transform.rotation,
                          d: transform.distance,
                        ),
                        child: const Center(),
                      ),
                    ))
                  ],
                ),
                // Positioned(
                //   top: 40,
                //   width: 500,
                //   child: Column(
                //     children: [
                //       Slider(
                //           min: 0,
                //           max: 360,
                //           // divisions: 36,
                //           value: angle,
                //           onChanged: (v) {
                //             print(v);
                //             setState(() {
                //               angle = v;
                //             });
                //           }),
                //       Slider(
                //           min: 6,
                //           max: 40,
                //           // divisions: 36,
                //           value: d,
                //           onChanged: (v) {
                //             print(v);
                //             setState(() {
                //               d = v;
                //             });
                //           }),
                //     ],
                //   ),
                // )
              ],
            ),
          ),
        ],
      ),
    );
  }

  double _dx = 0;

  void _onPanDown(DragDownDetails details) {
    _dx = 0;
  }

  void _onPanUpdate(DragUpdateDetails details) {
    context.read<World3dBloc>().transrorm(details.delta.dx);
  }

  void _onPanEnd(DragEndDetails details) {
    _dx = 0;
  }
}

typedef Line3D = (Point3D, Point3D);

class World3D extends CustomPainter {
  final double rotationZ;
  final double d;
  final bool showGrid;

  World3D({this.rotationZ = 0, this.d = 18, this.showGrid = true});

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
    return _project.projectWithCamera(p, rotationZ, 18);
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

    // final grid = Paint()
    //   ..style = PaintingStyle.stroke
    //   ..color = Colors.grey;
    // canvas.drawLine(
    //     Offset(-size.width / 2, 0), Offset(size.width / 2, 0), grid);
    // canvas.drawLine(
    //     Offset(0, -size.height / 2), Offset(0, size.height / 2), grid);

    // 绘制坐标系轴
    _drawAxis(canvas, Colors.red, Point3D(6, 0, 0), 'X'); // X轴
    _drawAxis(canvas, Colors.green, Point3D(0, 6, 0), 'Y'); // Y轴
    _drawAxis(canvas, Colors.blue, Point3D(0, 0, 6), 'Z'); // Z轴

    if (showGrid) {
      _drawGrid(canvas);
    }

    List<Point3D> points = [
      Point3D(-4, 4, 0),
      Point3D(-4, 1, 0),
      Point3D(-1, 1, 0),
    ];
    // Path path = Path();
    // List<Offset> point2ds = points.map(project).toList();
    // path.moveTo(point2ds[0].dx, point2ds[0].dy);
    // path.lineTo(point2ds[1].dx, point2ds[1].dy);
    // path.lineTo(point2ds[2].dx, point2ds[2].dy);
    // path.lineTo(point2ds[0].dx, point2ds[0].dy);
    Paint paint = Paint()
      ..color = Colors.cyanAccent
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;
    // canvas.drawPath(path, paint);
    //
    // for (int i = 0; i < points.length; i++) {
    //   Offset point2d = project(points[i]);
    //   if (i == 0) {
    //     path.moveTo(point2d.dx, point2d.dy);
    //     continue;
    //   }
    //   path.lineTo(point2d.dx, point2d.dy);
    //
    //   if (close && points.isNotEmpty && i == points.length - 1) {
    //     Offset point2d = project(points.first);
    //     path.lineTo(point2d.dx, point2d.dy);
    //   }
    // }
    // canvas.drawPath(
    //     path,
    //     Paint()
    //       ..color = Colors.cyanAccent
    //       ..strokeWidth = 2
    //       ..style = PaintingStyle.stroke);

    List<Point3D> points3d = [
      Point3D(4.00, 0.00, 0),
      Point3D(2.83, 2.83, 0),
      Point3D(0.00, 4.00, 0),
      Point3D(-2.83, 2.83, 0),
      Point3D(-4.00, 0.00, 0),
      Point3D(-2.83, -2.83, 0),
      Point3D(0.00, -4.00, 0),
      Point3D(2.83, -2.83, 0),
    ];
    Path path = buildPathByPoints3d(points3d, type: DrawArrays.triangleFan);
    canvas.drawPath(path, paint);

    drawPoints(canvas, points3d);

    // [
    //   [[0, 0], [2, 0], [0, 2]],
    //   [[0, 0], [-2, 0], [0, 2]],
    //   [[0, 0], [-2, 0], [0, -2]],
    //   [[0, 0], [2, 0], [0, -2]],
    //   [[0, 0], [1.5, 1.5], [0, 2.5]],
    //   [[0, 0], [-1.5, 1.5], [0, 2.5]]
    // ].map((e)=>Point3D((e[0]), y, z));
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

  void drawPoints(Canvas canvas, List<Point3D> points3d) {
    List<Offset> points2d = points3d.map((project)).toList();
    canvas.drawPoints(
      PointMode.points,
      points2d,
      Paint()
        ..color = Colors.orange
        ..strokeWidth = 6
        ..strokeCap = StrokeCap.round,
    );
  }

  Path buildPathByPoints3d(
    List<Point3D> points3d, {
    DrawArrays type = DrawArrays.triangles,
  }) {
    Path path = Path();
    if (points3d.length == 1) path;
    List<Offset> points = points3d.map((project)).toList();
    return switch (type) {
      DrawArrays.triangles => _buildTrianglesPath(points),
      DrawArrays.triangleStrip => _buildStripPath(points),
      DrawArrays.triangleFan => _buildFanPath(points),
    };
  }

  Path _buildTrianglesPath(List<Offset> points) {
    Path path = Path();
    for (int i = 0; i + 2 < points.length; i += 3) {
      path
        ..moveTo(points[i].dx, points[i].dy)
        ..lineTo(points[i + 1].dx, points[i + 1].dy)
        ..lineTo(points[i + 2].dx, points[i + 2].dy)
        ..close();
    }
    return path;
  }

  Path _buildStripPath(List<Offset> points) {
    Path path = Path();
    for (int i = 0; i + 2 < points.length; i++) {
      path.moveTo(points[i].dx, points[i].dy);
      path.lineTo(points[i + 1].dx, points[i + 1].dy);
      path.lineTo(points[i + 2].dx, points[i + 2].dy);
      path.close();
    }
    return path;
  }

  Path _buildFanPath(List<Offset> points) {
    Path path = Path();
    Offset center = points[0];
    for (int i = 1; i + 1 < points.length; i++) {
      path.moveTo(center.dx, center.dy);
      path.lineTo(points[i].dx, points[i].dy);
      path.lineTo(points[i + 1].dx, points[i + 1].dy);
      path.close();
    }
    return path;
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
  bool shouldRepaint(World3D oldDelegate) =>
      rotationZ != oldDelegate.rotationZ || true;
}

enum DrawArrays {
  // points,
  // lines,
  // lineStrip,
  // lineLoop,
  triangles,
  triangleStrip,
  triangleFan,
}
