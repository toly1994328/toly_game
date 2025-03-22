import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fx_framework/fx_framework.dart';
import 'package:sweeper/app/sweeper_app.dart';
import 'package:toly_game/components/project/custom_desk_top_bar.dart';

class SweeperPage extends StatelessWidget {
  const SweeperPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body:  Column(
        children: [
          // CustomDeskTopBar(title: '经典扫雷',leading: BackButton(
          //   onPressed: context.pop,
          // ),),
          const Expanded(child: SweeperGamePanel()),
        ],
      ),
    );
  }
}
