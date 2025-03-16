import 'package:bricks/bricks.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fx_framework/fx_framework.dart';
import 'package:sweeper/app/sweeper_app.dart';
import 'package:toly_game/components/project/custom_desk_top_bar.dart';
import 'package:trex/main.dart';

class BricksPage extends StatelessWidget {
  const BricksPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body:  Column(
        children: [
          CustomDeskTopBar(title: '经典打砖块',leading: BackButton(
            onPressed: context.pop,
          ),),
          const Expanded(child: BreakGamePanel()),
        ],
      ),
    );
  }
}
