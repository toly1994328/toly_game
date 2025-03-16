import 'package:flame/widgets.dart';
import 'package:flutter/material.dart';

import '../goods.dart';
import '../shop_page.dart';
import 'goods_cell.dart';
import '../../../bricks_game.dart';

class PaddleGoodsItem extends StatelessWidget {
  final bool active;
  final bool hasPaddle;
  final BricksGame game;
  final Goods goods;
  final ValueChanged<Goods> onSelectGoods;

  const PaddleGoodsItem({
    super.key,
    required this.game,
    required this.goods,
    required this.onSelectGoods,
    required this.active,
    required this.hasPaddle,
  });

  @override
  Widget build(BuildContext context) {
    Widget child = GoodsCell(
      size: const Size(90, 90),
      goods: goods,
      game: game,
      onSelectGoods: onSelectGoods,
      bottom: buildBottom(hasPaddle, active),
      child: SizedBox(
        width: 64,
        height: 64 * 28 / 96,
        child: SpriteWidget(sprite: game.loader[goods.src]),
      ),
    );
    if (hasPaddle) {
      child = Tooltip(message: goods.desc, child: child);
    }
    return child;
  }

  Widget buildBottom(bool has, bool active) {
    const TextStyle white = TextStyle(color: Colors.white);
    const TextStyle blue = TextStyle(color: Colors.blue);
    if (active) return const Text("正在使用", style: blue);
    if (has) return const Text("已购买", style: white);
    String coin = 'assets/images/break_bricks/coin.png';
    return Wrap(
      spacing: 2,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Image.asset(coin, width: 14, height: 14),
        Text(goods.coin.toString(), style: white),
      ],
    );
  }
}

class SizedGoodsItem extends StatelessWidget {
  final BricksGame game;
  final Goods goods;
  final Size size;

  final ValueChanged<Goods> onSelectGoods;

  const SizedGoodsItem({
    super.key,
    required this.game,
    required this.goods,
    required this.onSelectGoods,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    Widget child = switch (goods.type) {
      GoodsType.rune => BrickGem(
          game: game,
          path: goods.src,
        ),
      GoodsType.function => SizedBox(
          width: 24,
          height: 24,
          child: SpriteWidget(
            sprite: game.loader[goods.src],
          ),
        ),
      _ => const SizedBox(),
    };
    return GoodsCell(
      goods: goods,
      game: game,
      size: size,
      onSelectGoods: (g) => onSelectGoods(g),
      bottom: Wrap(
        spacing: 2,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Image.asset(
            'assets/images/break_bricks/coin.png',
            width: 14,
            height: 14,
          ),
          Text(
            goods.coin.toString(),
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
      child: child,
    );
  }
}
