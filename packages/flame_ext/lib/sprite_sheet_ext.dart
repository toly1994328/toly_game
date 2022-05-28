import 'package:flame/sprite.dart';

extension SpriteSheetExt on SpriteSheet {
  /// 获取指定索引区间的 [Sprite] 列表
  /// [row] : 第几行
  /// [start] : 第几个开始
  /// [count] : 有几个
  List<Sprite> getRowSprites({
    required int row,
    int start = 0,
    required count,
  }) {
    return List.generate(count, (i) => getSprite(row, start + i)).toList();
  }

  /// 获取指定索引区间的 [Sprite] 列表
  /// [start] : 第几个开始
  /// [count] : 有几个
  List<Sprite> getSprites({int start = 0, int? count}) {
    count ??= columns * rows;
    return List.generate(count, (i) => getSpriteById(start + i)).toList();
  }
}
