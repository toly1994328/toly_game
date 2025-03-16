
import 'package:flame/widgets.dart';
import 'package:flame_ext/flame_ext.dart';
import 'package:flutter/material.dart';
import '../../bricks_game.dart';
import '../../config/buy_goods.dart';
import '../shop_page/goods.dart';
import '../shop_page/shop_page.dart';

class PackageGoodsCell extends StatelessWidget {
  final BuyGoods buyGoods;
  final BricksGame game;
  final ValueChanged<Goods> onSelect;

  const PackageGoodsCell(
      {super.key,
        required this.buyGoods,
        required this.game,
        required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: buyGoods.goods.desc,
      child: GestureDetector(
        onTap: () => onSelect(buyGoods.goods),
        child: Stack(
          children: [
            SizedBox(
              width: 56,
              height: 56,
              child: NineImageWidget(
                  opacity: 0.95,
                  expandZone: const Rect.fromLTWH(26, 26, 46, 56),
                  image: game.loader['package_cell.png'].image,
                  child: PackageGoodsItem(
                    goods: buyGoods.goods,
                    game: game,
                    count: buyGoods.count,
                  )),
            ),
            if (game.config.paddleType.src == buyGoods.goods.src)
              Positioned(
                  right: 0,
                  bottom: 0,
                  child: Icon(
                    Icons.check,
                    color: Colors.green,
                  ))
          ],
        ),
      ),
    );
  }
}

class PackageGoodsItem extends StatelessWidget {
  final Goods goods;
  final int count;

  final BricksGame game;

  const PackageGoodsItem({
    super.key,
    required this.goods,
    required this.game,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (goods.type == GoodsType.rune)
            BrickGem(
              width: 12,
              game: game,
              path: goods.src,
            ),
          if (goods.type == GoodsType.paddle)
            SizedBox(
              width: 32,
              height: 32 * 28 / 96,
              child: SpriteWidget(
                sprite: game.loader[goods.src],
              ),
            ),
          if (goods.type == GoodsType.function)
            SizedBox(
              width: 18,
              height: 18,
              child: SpriteWidget(
                sprite: game.loader[goods.src],
              ),
            ),
          if (goods.type != GoodsType.paddle)
            Text(
              'x${count}',
              style: TextStyle(color: Colors.white, fontSize: 12),
            ),
        ],
      ),
    );
  }
}
