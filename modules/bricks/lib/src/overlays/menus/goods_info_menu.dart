
import 'package:flame/widgets.dart';
import 'package:flame_ext/flame_ext.dart';
import 'package:flutter/material.dart';

import '../../bricks_game.dart';
import '../../config/audio_manager/sound_effect.dart';
import '../shop_page/goods.dart';

class GoodsInfoMenu extends StatefulWidget {
  final BricksGame game;

  const GoodsInfoMenu({
    super.key,
    required this.game,
  });

  @override
  State<GoodsInfoMenu> createState() => _GoodsInfoMenuState();
}

class _GoodsInfoMenuState extends State<GoodsInfoMenu> {
  @override
  void initState() {
    super.initState();
    widget.game.paused = true;
  }

  @override
  void dispose() {
    widget.game.paused = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
   Goods goods =  widget.game.goodsManager.showMenuGoods!;
    const whiteTextColor = Color.fromRGBO(255, 255, 255, 1.0);

    return Material(
      color: Colors.transparent,
      child: Center(
        child: Container(
          // padding: const EdgeInsets.all(8.0),
          height: 300,
          width: 280,
          child: NineImageWidget(
            opacity: 0.9,
            expandZone: const Rect.fromLTWH(32, 45, 32, 40),
            image: widget.game.loader['Window04.png'].image,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 46,
                  child: NavigationToolbar(
                    middle: Text(
                      '商品详情',
                      style: TextStyle(
                          color: whiteTextColor,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const SizedBox(height: 8,),
                Text(goods.title,style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold,fontSize: 16),),

                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.only(left: 34, right: 38),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        goods.desc,
                        style: TextStyle(color: Colors.white),
                      ),
                      const SizedBox(height: 18),
                      // SpriteWidget(sprite: widget.game.loader['flatDark13.png']),

                      switch(goods.type){

                        // TODO: Handle this case.
                        GoodsType.function => SizedBox(
                          width: 24,
                          height: 24,
                          child: SpriteWidget(sprite: widget.game.loader[goods.src],
                          ),
                        ),
                        GoodsType.paddle => SizedBox(
                          width: 72,
                          height: 72 * 28 / 96,
                          child: SpriteWidget(sprite: widget.game.loader[goods.src],
                          ),
                        ),
                      GoodsType.rune => SizedBox(
                          width: 56,
                          height: 56/2,
                          child: SpriteWidget(sprite: widget.game.loader[goods.src],
                          ),
                        ),
                      },

                      const SizedBox(height: 8),
                      Text(
                        "售价:${goods.coin} 金币",
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ],
                  ),
                )),
                Padding(
                  padding:
                      const EdgeInsets.only(bottom: 46, right: 24, left: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SpriteButton(
                        onPressed: () => buyGoods(goods),
                        label: Text("购买"),
                        sprite: widget.game.loader['buttonLong_beige.png'],
                        pressedSprite:
                            widget.game.loader['buttonLong_beige_pressed.png'],
                        height: 49 * 0.5,
                        width: 190 * 0.5,
                      ),
                      SpriteButton(
                        onPressed: () {
                          widget.game.am.play(SoundEffect.uiClose);
                          widget.game.overlays.remove('GoodsInfoMenu');
                        },
                        label: Text(
                          "取消",
                          style: TextStyle(color: Colors.white),
                        ),
                        sprite: widget.game.loader['buttonLong_blue.png'],
                        pressedSprite:
                            widget.game.loader['buttonLong_blue_pressed.png'],
                        height: 49 * 0.5,
                        width: 190 * 0.5,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void buyGoods(Goods goods) {
    widget.game.am.play(SoundEffect.uiClose);
    widget.game.buy(goods);
    widget.game.overlays.remove('GoodsInfoMenu');
  }
}
