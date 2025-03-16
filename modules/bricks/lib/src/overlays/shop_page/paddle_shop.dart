import 'package:flutter/material.dart';
import '../../bricks_game.dart';
import 'goods.dart';
import 'goods_item/paddle_goods_item.dart';

class PaddleShop extends StatefulWidget {
  final BricksGame game;

  const PaddleShop({super.key, required this.game});

  @override
  State<PaddleShop> createState() => _PaddleShopState();
}

class _PaddleShopState extends State<PaddleShop> {
  @override
  Widget build(BuildContext context) {
    const TextStyle style =  TextStyle(fontSize: 16, color: Colors.white);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 12),
          child: Text("挡板商铺", style: style),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Wrap(
            spacing: 12,
            runSpacing: 12,
            crossAxisAlignment: WrapCrossAlignment.center,
            alignment: WrapAlignment.center,
            runAlignment: WrapAlignment.center,
            children: widget.game.goodsManager
                .goods(GoodsType.paddle)
                .map(_buildItem)
                .toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildItem(Goods goods) {
    List<String> srcList = widget.game.buyPaddles.map((e) => e.src).toList();
    bool hasPaddle = srcList.contains(goods.src);
    bool active = widget.game.paddleType.src == goods.src;
    return PaddleGoodsItem(
      hasPaddle: hasPaddle,
      active: active,
      goods: goods,
      onSelectGoods: (goods) {
        if (active) return;
        if (hasPaddle && !active) {
          widget.game.switchPaddle(goods.src);
          setState(() {});
        } else {
          widget.game.goodsManager.showMenuGoods = goods;
          widget.game.overlays.add("GoodsInfoMenu");
        }
      },
      game: widget.game,
    );
  }
}
