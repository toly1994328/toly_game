import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'bricks_game.dart';
import 'config/res_manager.dart';
import 'overlays/home_page/home_page.dart';
import 'overlays/lever_page/level_page.dart';
import 'overlays/loading_page/assets_loading_page.dart';
import 'overlays/menus/exit_menu.dart';
import 'overlays/menus/game_over_menu.dart';
import 'overlays/menus/game_win_menu.dart';
import 'overlays/menus/goods_info_menu.dart';
import 'overlays/menus/pause_menu.dart';
import 'overlays/package_page/package_page.dart';
import 'overlays/settings/settings_page.dart';
import 'overlays/shop_page/shop_page.dart';

class BreakGamePanel extends StatelessWidget {
  const BreakGamePanel({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: const AssetsLoadingPage());
  }

}

class BricksGameApp extends StatelessWidget{

  const BricksGameApp({super.key});


  @override
  Widget build(BuildContext context) {
    return GameWidget<BricksGame>.controlled(
      gameFactory: BricksGame.new,
      overlayBuilderMap: {
        'HomePage': (_, game) => HomePage(game: game),
        'Settings': (_, game) => SettingsPage(game: game),
        'ShopPage': (_, game) => ShopPage(game: game),
        'LevelPage': (_, game) => LevelPage(game: game),
        'PauseMenu': (_, game) => PauseMenu(game: game),
        'ExitMenu': (_, game) => ExitMenu(game: game),
        'GameOverMenu': (_, game) => GameOverMenu(game: game),
        'GoodsInfoMenu': (_, game) => GoodsInfoMenu(game: game,),
        'GameSuccessMenu': (_, game) => GameSuccessMenu(game: game),
        'PackagePage': (_, game) => PackagePage(game: game),
      },
      initialActiveOverlays: const ['HomePage'],
    );
  }
}
