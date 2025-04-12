import 'package:flutter/material.dart';
import 'package:fx_framework/fx_framework.dart';
import 'package:sweeper/app/sweeper_app.dart';
import 'package:toly3d/toly3d.dart';

import '../../pages/collect/collect_page.dart';
import '../../pages/game_center/game_center.dart';
import '../../pages/game_center/games/breaks.dart';
import '../../pages/game_center/games/life_game.dart';
import '../../pages/game_center/games/snake.dart';
import '../../pages/game_center/games/swipper.dart';
import '../../pages/game_center/games/trex.dart';
import '../../pages/mine/mine_page.dart';
import '../../pages/save/save_page.dart';
import '../../pages/settings/settings_page.dart';
import '../view/desktop/desk_navigation.dart';
import 'app_route.dart';

RouteBase get gameRoute => GoRoute(
      path: 'game/:name',
      pageBuilder: (_, GoRouterState state) {
        String? gameName = state.pathParameters['name'];
        Widget child = gameWidgetMap[gameName] ?? const GameCenter();
        return NoTransitionPage(child: child);
      },
    );

Map<String, Widget> get gameWidgetMap => {
      "sweeper": const SweeperPage(),
      "trex": const TrexPage(),
      "breaks": const BricksPage(),
      "snake": const SnakePage(),
      "life_game": const LifeGamePage(),
      "world3d": const Word3dScope(),
    };

List<StatefulShellBranch> get gameBranches {
  List<String> pages = ["center", ...gameWidgetMap.keys];
  return pages.map((String name) {
    Widget child = gameWidgetMap[name] ?? const GameCenter();
    Page page = NoTransitionPage(child: child);
    GoRoute route = GoRoute(path: 'game/$name', pageBuilder: (_, __) => page);
    return StatefulShellBranch(routes: [route]);
  }).toList();
}

RouteBase get deskHomeRoute => ShellRoute(
      builder: (_, __, Widget child) => DeskNavigation(content: child),
      routes: [
        // ShellRoute(
        //   routes: [gameRoute],
        //   builder: (_, __, Widget child) => GameCenterNavigation(child: child),
        // ),
        StatefulShellRoute.indexedStack(
          builder: (_, __, StatefulNavigationShell child) =>
              GameCenterNavigation(child: child),
          branches: gameBranches,
        ),
        GoRoute(
          path: AppRoute.save.path,
          pageBuilder: (_, __) => const NoTransitionPage(child: SavePage()),
        ),
        GoRoute(
          path: AppRoute.collect.path,
          pageBuilder: (_, __) => const NoTransitionPage(child: CollectPage()),
        ),
        GoRoute(
          path: AppRoute.mine.path,
          pageBuilder: (_, __) => const NoTransitionPage(child: Word3dScope()),
        ),
        GoRoute(
          path: AppRoute.settings.path,
          pageBuilder: (_, __) => const NoTransitionPage(child: SettingsPage()),
        ),
      ],
    );
