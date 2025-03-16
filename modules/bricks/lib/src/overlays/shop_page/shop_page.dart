import 'package:flame/widgets.dart';
import 'package:flutter/material.dart';

import '../../bricks_game.dart';
import '../../config/audio_manager/sound_effect.dart';
import '../home_page/home_title.dart';
import 'goods.dart';
import 'goods_item/paddle_goods_item.dart';
import 'paddle_shop.dart';

class ShopPage extends StatelessWidget {
  final BricksGame game;

  const ShopPage({super.key, required this.game});


  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: DecoratedBox(
        decoration: const BoxDecoration(
            color: Colors.white,
            image: DecorationImage(
                fit: BoxFit.fill,
                image:
                    AssetImage('assets/images/break_bricks/bg_gallery.png'))),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            surfaceTintColor: Colors.transparent,
            centerTitle: false,
            leading: BackButton(onPressed: back),
            title: const Text('道具商店'),
            actions: [
              CoinWidget(
                spacing: 12,
                blueCrystal: game.config.blueCrystal,
                coin: game.config.coin,
              ),
              const SizedBox(
                width: 8,
              ),
              SpriteButton(
                onPressed: () {
                  game.am.play(SoundEffect.uiClick);
                  game.overlays.add('PackagePage');
                },
                label: const Text(
                  '',
                  style: TextStyle(color: Colors.white),
                ),
                sprite: game.loader['package.png'],
                pressedSprite: game.loader['package.png'],
                height: 24,
                width: 24,
              ),
              const SizedBox(
                width: 12,
              )
            ],
          ),
          body: Align(
            alignment: Alignment.topCenter,
            child: SizedBox(
              width: 360,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    PaddleShop(game: game,),
                    const SizedBox(height: 12,),

                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24.0, vertical: 12),
                      child: Text(
                        "碎石符文",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                    Center(
                        child: Wrap(
                      spacing: 6,
                      runSpacing: 12,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      alignment: WrapAlignment.center,
                      runAlignment: WrapAlignment.center,
                      children: game.goodsManager
                          .goods(GoodsType.rune)
                          .map(_buildItem)
                          .toList(),
                    )),
                    const SizedBox(height: 12,),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24.0, vertical: 12),
                      child: Text(
                        "功能道具",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18.0),
                      child: Wrap(
                          spacing: 6,
                          runSpacing: 12,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          alignment: WrapAlignment.center,
                          runAlignment: WrapAlignment.center,
                          children: game.goodsManager
                              .goods(GoodsType.function)
                              .map(_buildItem)
                              .toList()),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildItem(Goods goods) {
    Size goodsSize = switch (goods.type) {
      GoodsType.paddle => const Size(90, 90),
      GoodsType.rune => const Size(58, 90),
      GoodsType.function => const Size(58, 80),
    };
    return SizedGoodsItem(
      game: game,
      goods: goods,
      onSelectGoods: (Goods value) {
        game.goodsManager.showMenuGoods = goods;
        game.overlays.add("GoodsInfoMenu");
      },
      size: goodsSize,
    );
  }

  void back() {
    game.overlays.remove("ShopPage");
  }
}

class BrickGem extends StatelessWidget {
  final String path;
  final double width;
  final BricksGame game;

  const BrickGem({super.key, required this.path, required this.game,  this.width=18});

  @override
  Widget build(BuildContext context) {
    return RotatedBox(
      quarterTurns: 1,
      child: Stack(
        alignment: Alignment.center,
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: SizedBox(
                width: width*2,
                height: width,
                child: SpriteWidget(
                  sprite: game.loader[path],
                ),
              )),
          Image.asset(
            'packages/bricks/assets/images/tc_game_lightning02.webp',
            width: width*2,
          ),
        ],
      ),
    );
  }
}
