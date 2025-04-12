import 'dart:math';
import 'dart:ui';

import '../core.dart';

class Project {
  Offset simpleProject(Point3D p) {
    double scale = 40.0;
    double angle = 30 / 180 * pi;
    final x = (p.x - p.y) * cos(angle);
    final y = (p.x + p.y) * sin(angle) - p.z;
    return Offset(x * scale, y * scale);
  }

  // 3D点投影到2D平面
  Offset projectWithRotation(Point3D p, double rotationZ) {
    double scale = 32.0; // 缩放系数
    double angle = 30 / 180 * pi; // 30度弧度值（π/6）
    // 绕Z轴旋转
    final rx = p.x * cos(rotationZ) - p.y * sin(rotationZ);
    final ry = p.x * sin(rotationZ) + p.y * cos(rotationZ);

    // 等轴测投影
    final xProj = (rx - ry) * cos(angle);
    final yProj = (rx + ry) * sin(angle) - p.z;

    return Offset(xProj * scale, yProj * scale);
  }

  Offset projectWithCamera(Point3D p, double rotationZ, double distance) {
    double scale = 32.0; // 缩放系数
    double angle = 30 / 180 * pi; // 30度弧度值（π/6）

    // 绕Z轴旋转
    final rx = p.x * cos(rotationZ) - p.y * sin(rotationZ);
    final ry = p.x * sin(rotationZ) + p.y * cos(rotationZ);

    // 等轴测投影
    final xProj = (rx - ry) * cos(angle);
    final yProj = (rx + ry) * sin(angle) - p.z;

    // double cameraDistance = 18.0;
    double radio = distance / (distance - yProj);
    if (distance == 0) {
      radio = 1;
    }
    return Offset(xProj * scale * radio, yProj * scale * radio);
  }
}
