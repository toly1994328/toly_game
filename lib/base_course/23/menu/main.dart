import 'package:flutter/material.dart';
import 'package:toly_game/base_course/23/i10n/l10n.dart';

import '../app/key.dart';

import '../main.dart';

class MainMenu extends StatelessWidget {
  const MainMenu({Key? key}) : super(key: key);

  final TextStyle shadowStyle = const TextStyle(
      fontSize: 30,
      shadows: [Shadow(color: Colors.white,blurRadius: 10)]
  );

  @override
  Widget build(BuildContext context) {
    String play = context.l10n.play;
    String options = context.l10n.options;

    return Scaffold(
      body: Center(
        child: Wrap(
          spacing: 20,
          direction: Axis.vertical,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Text('Adventurer', style: shadowStyle,),
            SizedBox(
                width: 120,
                child: ElevatedButton(onPressed: _doPlay, child:  Text(play))),

        SizedBox(
          width: 120,
          child: ElevatedButton(onPressed: _toOptions, child:  Text(options)))
          ],
        ),
      ),
    );
  }

  void _doPlay() {
    Keys.navigator?.pushReplacement(
      MaterialPageRoute(builder: (ctx) => const GameWorld()),
    );
  }

  void _toOptions() {
  }
}
