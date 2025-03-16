import 'package:flutter/material.dart';
import '../../bricks_game.dart';
import '../../config/buy_goods.dart';
import '../shop_page/goods.dart';
import 'package_cell.dart';
import 'toly_tab_bar.dart';

class PackageContent extends StatefulWidget {
  final BricksGame game;

  const PackageContent({super.key, required this.game});

  @override
  State<PackageContent> createState() => _PackageContentState();
}

class _PackageContentState extends State<PackageContent> {
  late int _activeIndex = widget.game.hasHomePage?0:1;

  List<BuyGoods> get buyGoods {
    if (_activeIndex == 0) {
      return widget.game.buyPaddleGoods
          .map<BuyGoods>((e) => BuyGoods(count: 1, goods: e))
          .toList();
    } else {
      return widget.game.configManager.config.buyGoods
          .where((e) => e.goods.type.index == _activeIndex)
          .toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TolyTabBar(
            onTap: _onTabChange,
            tabs: const ['挡板', '符文', '道具'],
            activeIndex: _activeIndex,
          ),
          goodsContent(),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget goodsContent() {
    if (buyGoods.isEmpty) {
      return const Expanded(
        child: Center(
          child: Text('暂无道具', style: TextStyle(color: Colors.white)),
        ),
      );
    }
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: buyGoods
          .map((e) => PackageGoodsCell(
                buyGoods: e,
                game: widget.game,
                onSelect: _onSelectGoods,
              ))
          .toList(),
    );
  }

  void _onTabChange(int index) {
    setState(() {
      _activeIndex = index;
    });
  }

  void _onSelectGoods(Goods goods) {
    if(widget.game.hasHomePage){
      if (goods.type == GoodsType.paddle) {
        widget.game.switchPaddle(goods.src);
        setState(() {});
      }
    }else{
      if (goods.type != GoodsType.paddle) {
        widget.game.useGoods(goods);
        widget.game.overlays.remove("PackagePage");
      }
    }
  }
}
