
import 'package:flutter/cupertino.dart';
import 'package:fx_framework/fx_framework.dart';
import 'package:toly_game/pages/mine/mine_page.dart';
import 'package:toly_game/pages/settings/settings_page.dart';

import '../../pages/collect/collect_page.dart';
import '../../pages/game_center/game_center.dart';
import '../../pages/save/save_page.dart';
import '../../starter/view/splash.dart';
import '../view/desk_navigation/desk_navigation.dart';

RouteBase get appRoute {

  return GoRoute(
    path: AppRoute.home.path,
    redirect: (_, __) => null,
    routes: [
      GoRoute(
        path: AppRoute.splash.path,
        builder: (_, __) => const Splash(),
      ),
      ShellRoute(
        builder: (_, __, Widget child) => DeskNavigation(content: child),
        routes: [
          GoRoute(
            path: AppRoute.playground.path,
            builder: (_, __) =>  const GameCenterPage(),
          ),
          GoRoute(
            path: AppRoute.save.path,
            builder: (_, __) =>  const SavePage(),
          ),
          GoRoute(
            path: AppRoute.collect.path,
            builder: (_, __) =>  const CollectPage(),
          ),
          GoRoute(
            path: AppRoute.mine.path,
            builder: (_, __) =>  const MinePage(),
          ),
          GoRoute(
            path: AppRoute.settings.path,
            builder: (_, __) =>  const SettingsPage(),
          ),
        ],
      ),
      // GoRoute(
      //   path: AppRoute.playground.path,
      //   builder: (_, __) => const Playground(),
      // ),
    ],
  );
}


enum AppRoute {
  home('/', url: '/'),
  splash('splash', url: '/splash'),
  startError('start_error', url: '/start_error'),
  globalError('404', url: '/404'),
  playground('playground', url: '/playground'),
  save('save', url: '/save'),
  collect('collect', url: '/collect'),
  mine('mine', url: '/mine'),
  settings('settings', url: '/settings'),


  ;

  final String path;
  final String url;

  const AppRoute(
      this.path, {
        required this.url,
      });
}