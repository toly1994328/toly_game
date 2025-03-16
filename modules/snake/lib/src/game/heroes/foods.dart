import 'dart:async';

import 'package:flame/components.dart';

import '../../model/foods.dart';
import 'snake.dart';

class Foods extends PositionComponent {
  final Iterable<FoodNode> foods;

  Foods(this.foods);

  @override
  FutureOr<void> onLoad() {
    setFrame();
    return super.onLoad();
  }

  void setFrame() {
    removeWhere((e) => true);
    for (FoodNode food in foods) {
      add(Cell(
        food.position,
        type: CellType.food,
        side: 24,
        color: food.color,
        value: food.score
      ));
    }
  }
}
