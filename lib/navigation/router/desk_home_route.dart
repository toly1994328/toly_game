import 'package:flutter/material.dart';
import 'package:fx_framework/fx_framework.dart';

import '../../pages/collect/collect_page.dart';
import '../../pages/game_center/game_center.dart';
import '../../pages/mine/mine_page.dart';
import '../../pages/save/save_page.dart';
import '../../pages/settings/settings_page.dart';
import '../view/desk_top/desk_navigation.dart';
import 'app_route.dart';

RouteBase get deskHomeRoute => ShellRoute(
      builder: (_, __, Widget child) => DeskNavigation(content: child),
      routes: [
        GoRoute(
          path: AppRoute.gameCenter.path,
          pageBuilder: (_, __) =>
              const NoTransitionPage(child: GameCenterPage()),
          builder: (_, __) => const GameCenterPage(),
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
      ],
    );
