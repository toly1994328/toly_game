import 'dart:async';

import 'package:flame/game.dart';
import 'package:flame/widgets.dart';
import 'package:flame_ext/flame_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utils/platform_adapter/window/windows_adapter.dart';
import '../bricks/04/ui_components/app_top_bar.dart';

class TolyGameApp extends StatelessWidget {
  const TolyGameApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: '宋体'),
      home: _buildHomeByPlatform(),
    );
  }

  Widget _buildHomeByPlatform() {
    Widget home = const BricksGameApp();
    if (kIsDesk) {
      home = Column(
        children: [
          const AppTopBar(),
          Expanded(child: home),
        ],
      );
    }
    return home;
  }
}

class BricksGameApp extends StatelessWidget {
  const BricksGameApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GameWidget<UiTestGame>.controlled(
      gameFactory: UiTestGame.new,
      overlayBuilderMap: {
        'HomePage': (_, game) => HomePage(game: game),
        // 'GameOver': (_, game) => GameOver(game: game),
      },
      initialActiveOverlays: const ['HomePage'],
    );
  }
}

class HomePage extends StatefulWidget {
  final UiTestGame game;

  const HomePage({super.key, required this.game});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: PanelContent(game: widget.game,)),
    );
  }
}

class PanelContent extends StatefulWidget {
  final UiTestGame game;
  const PanelContent({super.key, required this.game});

  @override
  State<PanelContent> createState() => _PanelContentState();
}

class _PanelContentState extends State<PanelContent> {
  double tileSize = 0;
  double destTileSize = 0;
  double width = 100;
  double height = 100;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
                width: width,
                height: height,
                child: NineImageWidget(
                  expandZone: Rect.fromLTWH(32, 45, 32, 40),
                  image: widget.game.loader['Window04.png'].image,
                )
                // NineTileBoxWidget.asset(
                //   // padding: EdgeInsets.all(8),
                //   path: 'break_bricks/panel.png',
                //   // dart:ui image instance
                //   // path: 'break_bricks/Window04.png',// dart:ui image instance
                //   tileSize: tileSize,
                //   // The width/height of the tile on your grid image
                //   destTileSize: destTileSize,
                //   // The dimensions to be used when drawing the tile on the canvas
                //   // child: Padding(
                //   //   padding: const EdgeInsets.only(top: 30,bottom: 4,right: 8,left: 8),
                //   //   child: Text("Flutter&Flame 游戏开发 By 张风捷特烈"),
                //   // ), // Any Flutter widget
                // ),
                ),
          ],
        ),
        Row(
          children: [
            Slider(
                min: 0,
                max: 100,
                value: tileSize,
                onChanged: (v) {
                  setState(() {
                    tileSize = v;
                  });
                }),
            Text("${tileSize.toStringAsFixed(2)}")
          ],
        ),
        Row(
          children: [
            Slider(
                min: 0,
                max: 200,
                value: destTileSize,
                onChanged: (v) {
                  setState(() {
                    destTileSize = v;
                  });
                }),
            Text("${destTileSize.toStringAsFixed(2)}")
          ],
        ),
        Row(
          children: [
            Slider(
                min: 10,
                max: 400,
                value: height,
                onChanged: (v) {
                  setState(() {
                    height = v;
                  });
                }),
            Text("${height.toStringAsFixed(2)}")
          ],
        ),
        Row(
          children: [
            Slider(
                min: 10,
                max: 1200,
                value: width,
                onChanged: (v) {
                  setState(() {
                    width = v;
                  });
                }),
            Text("${width.toStringAsFixed(2)}")
          ],
        ),
      ],
    );
  }
}

class UiTestGame extends FlameGame {
  TextureLoader loader = TextureLoader();

  @override
  FutureOr<void> onLoad() async {
    await loader.load(
      'assets/images/break_bricks/break_bricks.json',
      'break_bricks/break_bricks.png',
    );
  }
}
