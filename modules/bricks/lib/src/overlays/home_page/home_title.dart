import 'package:flame/cache.dart';
import 'package:flame/game.dart';
import 'package:flame/widgets.dart';
import 'package:flutter/material.dart';

import '../../bricks_game.dart';
import '../../config/audio_manager/sound_effect.dart';

class HomeTitle extends StatelessWidget {
  final BricksGame game;

  const HomeTitle({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 12.0, top: 12),
              child: CoinWidget(
                blueCrystal: game.config.blueCrystal,
                coin: game.config.coin,
              ),
            ),
            Spacer(),
            // Padding(
            //   padding: const EdgeInsets.only(top: 8.0),
            //   child: SpriteButton(
            //     onPressed: () {
            //       game.am.play(SoundEffect.uiClick);
            //       game.overlays.add('PackagePage');
            //     },
            //     label: const Text(
            //       '',
            //       style: TextStyle(color: Colors.white),
            //     ),
            //     sprite: game.loader['package.png'],
            //     pressedSprite: game.loader['package.png'],
            //     height: 24,
            //     width: 24,
            //   ),
            // ),
            // Text("背包",style: TextStyle(color: Colors.white),)
            const SizedBox(
              width: 12,
            )
          ],
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 32.0),
          child: Column(
            children: [
              Text(
                "Bricks",
                style: TextStyle(fontSize: 24, color: Colors.white),
              ),
              Text(
                "经典打砖块",
                style: TextStyle(fontSize: 24, color: Colors.white),
              ),
            ],
          ),
        )
      ],
    );
  }
}

class CoinWidget extends StatelessWidget {
  final int blueCrystal;
  final int coin;
  final double spacing;

  const CoinWidget(
      {super.key,
      required this.blueCrystal,
      required this.coin,
       this.spacing=16});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 24,
          height: 24,
          child: SpriteAnimationWidget.asset(
            playing: true,
            images: Images(prefix: 'packages/bricks/assets/'),

            path: 'images/spr_coin_strip4.png',
            data: SpriteAnimationData.sequenced(
              amount: 4,
              stepTime: 0.15,
              textureSize: Vector2(16, 16),
            ),
          ),
        ),
        const SizedBox(width: 2),
        Text(
          blueCrystal.toString(),
          style: const TextStyle(color: Colors.white),
        ),
         SizedBox(width: spacing),
        _buildCoin(),
      ],
    );
  }

  Widget _buildCoin() {
    return Wrap(
      spacing: 2,
      children: [
        SizedBox(
          width: 20,
          height: 20,
          child: SpriteAnimationWidget.asset(
            playing: true,
            path: 'images/MonedaD.png',
            images: Images(prefix: 'packages/bricks/assets/'),

            data: SpriteAnimationData.sequenced(
              amount: 5,
              stepTime: 0.15,
              textureSize: Vector2(16, 16),
            ),
          ),
        ),
        Text(
          coin.toString(),
          style: const TextStyle(color: Colors.white),
        )
      ],
    );
  }
}

class CoinImage extends StatelessWidget {
  final double size;
  final bool playing;

  const CoinImage({super.key, required this.size, this.playing = true});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: size,
        height: size,
        child: SpriteAnimationWidget.asset(
          playing: playing,
          path: 'images/MonedaD.png',
          images: Images(prefix: 'packages/bricks/assets/'),

          data: SpriteAnimationData.sequenced(
            amount: 5,
            stepTime: 0.15,
            textureSize: Vector2(16, 16),
          ),
        ));
  }
}
