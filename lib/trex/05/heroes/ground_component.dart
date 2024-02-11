import 'dart:collection';

import 'package:flame/components.dart';

import '../trex_game.dart';
import 'road_component.dart';

class GroundComponent extends PositionComponent with HasGameReference<TrexGame> {
  final Vector2 groundSize = Vector2(1200, 24);

  final double groundHeight = 24;

  Queue<RoadComponent> roads = Queue();

  Queue<RoadComponent> createBreaksWhenNeed(
      double winWidth, double brickWidth) {
    int total = (winWidth / brickWidth).ceil();
    int current = roads.length;

    /// 窗口尺寸变化时需要额外添加的个数
    int addCount = total - current;
    int lastIndex = roads.isEmpty ? -1 : roads.last.index;
    double lastX = roads.isEmpty ? 0 : roads.last.x;
    Queue<RoadComponent> addRoads = Queue();
    for (int i = 0; i < addCount; i++) {
      int curIndex = lastIndex + 1 + i;
      RoadComponent road = RoadComponent(index: curIndex);
      road.x = lastX + brickWidth * i;
      addRoads.add(road);
    }
    return addRoads;
  }

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    width = size.x;
    y = size.y - groundHeight - 40;
    Queue<RoadComponent> addRoads = createBreaksWhenNeed(size.x, 1200);
    roads.addAll(addRoads);
    addAll(addRoads);
  }



  @override
  void update(double dt) {
    super.update(dt);
    double dx = game.moveSpeed * dt;
    for (final road in roads) {
      road.x -= dx;
    }
    _handleRoads();
  }


  void _handleRoads() {
    double firstPosX = roads.first.x + roads.first.roadSize.x;
    if (firstPosX <= 0) {
      remove(roads.removeFirst());
    }

    double lastPosX = roads.last.x + roads.last.roadSize.x;
    if (lastPosX <= width) {
      RoadComponent road = RoadComponent(index: roads.last.index + 1);
      road.x = lastPosX;
      roads.add(road);
      add(road);
    }
  }
}
