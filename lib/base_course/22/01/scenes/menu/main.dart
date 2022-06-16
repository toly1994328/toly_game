import 'package:flutter/material.dart';
import 'package:toly_game/base_course/22/01/main.dart';

class MainMenu extends StatelessWidget {
  const MainMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Wrap(
          spacing: 20,
          direction: Axis.vertical,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Text('Adventurer',style: TextStyle(fontSize: 30,shadows: [
              Shadow(
                color:
                  Colors.white,
                blurRadius: 10
              )
            ]),),
            ElevatedButton(onPressed: ()=> _doPlay(context), child: Text('开 始')),
            ElevatedButton(onPressed: _toOptions, child: Text('设 置'))
          ],
        ),
      ),
    );
  }

  void _doPlay(BuildContext context) {
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx)=>const GameWorld()));
  }

  void _toOptions() {
  }
}
