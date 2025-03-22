import 'package:flutter/material.dart';
import 'package:fx_framework/fx_framework.dart';
import 'package:sweeper/app/sweeper_app.dart';

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
    };

RouteBase get deskHomeRoute => ShellRoute(
      builder: (_, __, Widget child) => DeskNavigation(content: child),
      routes: [
        ShellRoute(
          routes: [gameRoute],
          builder: (_, __, Widget child) => GameCenterNavigation(child: child),
        ),
        // StatefulShellRoute.indexedStack(
        //     builder: (_, __, Widget child) => GameCenterNavigation(child: child),
        //     branches: [
        //       GoRoute(
        //         path: 'gameCenter',
        //         pageBuilder: (_, GoRouterState state) {
        //           return NoTransitionPage(child: GameCenter());
        //         },
        //       ),
        //       // gameRoute,
        //     ].map((e) => StatefulShellBranch(routes: [e])).toList()),
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
          pageBuilder: (_, __) => const NoTransitionPage(child: MinePage()),
        ),
        GoRoute(
          path: AppRoute.settings.path,
          pageBuilder: (_, __) => const NoTransitionPage(child: SettingsPage()),
        ),
      ],
    );
