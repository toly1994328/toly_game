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

RouteBase get deskHomeRoute => ShellRoute(
      builder: (_, __, Widget child) => DeskNavigation(content: child),
      routes: [
        GoRoute(
          path: AppRoute.gameCenter.path,
          pageBuilder: (_, __) => const NoTransitionPage(child: GameCenterPage()),
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
          pageBuilder: (_, __) => const NoTransitionPage(child: MinePage()),
        ),
        GoRoute(
          path: AppRoute.settings.path,
          pageBuilder: (_, __) => const NoTransitionPage(child: SettingsPage()),
        ),
        GoRoute(
          path: AppRoute.sweeper.path,
          pageBuilder: (ctx, __) => const NoTransitionPage(child: SweeperPage()),
        ),
        GoRoute(
          path: '/trex',
          pageBuilder: (ctx, __) => const NoTransitionPage(child: TrexPage()),
        ),
        GoRoute(
          path: '/breaks',
          pageBuilder: (ctx, __) => const NoTransitionPage(child: BricksPage()),
        ),
        GoRoute(
          path: '/snake',
          pageBuilder: (ctx, __) => const NoTransitionPage(child: SnakePage()),
        ),
        GoRoute(
          path: '/life_game',
          pageBuilder: (ctx, __) => const NoTransitionPage(child: LifeGamePage()),
        ),
      ],
    );
