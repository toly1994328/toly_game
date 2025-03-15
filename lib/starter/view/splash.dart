import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fx_framework/fx_framework.dart';

import '../toly_game_box.dart';

class Splash extends StatelessWidget {
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppStartListener<AppConfig>(
      child: Scaffold(
        body: Center(
          child: CupertinoActivityIndicator(),
        ),
      ),
    );
  }
}
