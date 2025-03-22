import 'package:bricks/bricks.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fx_framework/fx_framework.dart';
import 'package:sweeper/app/sweeper_app.dart';
import 'package:toly_game/components/project/custom_desk_top_bar.dart';
import 'package:trex/main.dart';

class BricksPage extends StatefulWidget {
  const BricksPage({super.key});

  @override
  State<BricksPage> createState() => _BricksPageState();
}

class _BricksPageState extends State<BricksPage> {

  @override
  void initState() {
  print("=========BricksPage#initState===========");
    super.initState();
  }

  @override
  void didUpdateWidget(covariant BricksPage oldWidget) {
    print("=========BricksPage#didUpdateWidget===========");
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    print("=========BricksPage#dispose===========");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body:  Column(
        children: [
          // CustomDeskTopBar(title: '经典打砖块',leading: BackButton(
          //   onPressed: context.pop,
          // ),),
          const Expanded(child: BreakGamePanel()),
        ],
      ),
    );
  }
}
