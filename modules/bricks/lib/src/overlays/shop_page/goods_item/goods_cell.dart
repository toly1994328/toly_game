import 'package:flame_ext/flame_ext.dart';
import 'package:flutter/material.dart';
import '../goods.dart';
import '../../../bricks_game.dart';

class GoodsCell extends StatelessWidget {
  final BricksGame game;
  final Goods goods;
  final Size size;
  final Widget child;
  final Widget bottom;

  final ValueChanged<Goods> onSelectGoods;

  const GoodsCell({
    super.key,
    required this.goods,
    required this.game,
    required this.size,
    required this.onSelectGoods,
    required this.child,
    required this.bottom,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onSelectGoods(goods),
      child: SizedBox(
        height: size.height,
        width: size.width,
        child: NineImageWidget(
          expandZone: const Rect.fromLTWH(4, 4, 4, 4),
          image: game.loader['Cell01.png'].image,
          child: _buildContent(),
        ),
      ),
    );
  }

  Widget _buildContent(){
    const EdgeInsets pd = EdgeInsets.symmetric(vertical: 4);
    return Center(
      child: Column(
        children: [
          Expanded(child: Center(child: child)),
          const Divider(height: 1),
          Padding(padding: pd, child: bottom),
        ],
      ),
    );
  }
}
