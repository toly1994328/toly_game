
import 'package:flutter/material.dart';
import 'package:fx_framework/fx_framework.dart';
import 'package:toly_game/navigation/view/desk_navigation/rail_bar/rail_navigation.dart';

import '../../../pages/game_center/game_center.dart';



class DeskNavigation extends StatelessWidget {
  final Widget content;

  const DeskNavigation({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [primaryDark, deepSpace],
                stops: [0.3, 0.8],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight
            )
        ),
        child: Row(
          children: [
            DragToMoveWrapper(
                child: Container(
                  width: 68,
                  child: DeskNavigationRail(),
                  // color: Colors.grey,
                )),
            VerticalDivider(),
            Expanded(child: content),
          ],
        ),
      ),
      // body: Placeholder(),
    );
  }
}
