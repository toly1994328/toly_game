import 'package:flame/game.dart';
import 'package:flame/widgets.dart';
import 'package:flutter/material.dart';

class CoinWidget extends StatelessWidget {
  const CoinWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return       Row(
      children: [
        SizedBox(
          width: 24,
          height: 24,
          child: SpriteAnimationWidget.asset(
            playing: true,
            // anchor: Anchor.center,
            path: 'break_bricks/spr_coin_strip4.png',
            data: SpriteAnimationData.sequenced(
                amount: 4,
                stepTime: 0.15,
                textureSize: Vector2(16, 16)),
          ),
        ),
        const SizedBox(width: 2,),
        Text(
          "10",
          style: TextStyle(color: Colors.white),
        ),
        const SizedBox(width: 16,),
        SizedBox(
          width: 20,
          height: 20,
          child: SpriteAnimationWidget.asset(
            playing: true,
            // anchor: Anchor.center,
            path: 'break_bricks/MonedaD.png',
            data: SpriteAnimationData.sequenced(
                amount: 5,
                stepTime: 0.15,
                textureSize: Vector2(16, 16)),
          ),
        ),
        const SizedBox(width: 2,),
        Text(
          "1024",
          style: TextStyle(color: Colors.white),
        )
      ],
    );
  }
}
