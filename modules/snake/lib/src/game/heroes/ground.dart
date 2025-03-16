import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:snake/src/game/heroes/foods.dart';
import 'package:snake/src/model/player.dart';

import '../snake_game.dart';
import 'snake.dart';

class Ground extends PositionComponent with HasGameRef<SnakeGame> {
  @override
  void onGameResize(Vector2 size) {
    this.size = game.gridSize;
    x = (size.x - width) / 2;
    y = (size.y - height) / 2;
    super.onGameResize(size);
  }

  @override
  FutureOr<void> onLoad() {
    updateSnake();
    updateFoods();
    return super.onLoad();
  }

  void updateSnake() {
    removeWhere((e) => e is Snake);
    for (int i = 0; i < game.players.length; i++) {
      final Player player = game.players[i];
      add(Snake(player.snakeList, player.color));
    }
  }

  void updateFoods() {
    removeWhere((e) => e is Foods);
    add(Foods(game.foodList));
  }

  @override
  void render(Canvas canvas) {
    drawGrid(canvas, game.boxSize, game.column, game.row);
  }

  Paint girdPaint = Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = 1
    ..color = const Color(0x4400ffff);

  void drawGrid(Canvas canvas, double boxSize, int row, int column) {
    Path path = Path();
    double width = row * boxSize;
    double height = column * boxSize;
    for (int i = 0; i <= column; i++) {
      path.moveTo(0, boxSize * i);
      path.relativeLineTo(width, 0);
    }
    for (int i = 0; i <= row; i++) {
      path.moveTo(boxSize * i, 0);
      path.relativeLineTo(0, height);
    }
    canvas.drawPath(path, girdPaint);
  }
}
