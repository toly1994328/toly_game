import 'package:fx_framework/fx_framework.dart';

import '../../data/data.dart';
import '../../starter/view/splash.dart';
import 'desk_home_route.dart';

RouteBase get appRoute {
  return GoRoute(
    path: AppRoute.home.path,
    redirect: (_, __) => null,
    routes: [
      GoRoute(
        path: AppRoute.splash.path,
        builder: (_, __) => const AppStartListener<AppConfig>(child: Splash()),
      ),
      if (kAppEnv.isDesktopUI) deskHomeRoute,
    ],
  );
}

enum AppRoute {
  home('/', url: '/'),
  splash('splash', url: '/splash'),
  startError('start_error', url: '/start_error'),
  globalError('404', url: '/404'),
  gameCenter('game_center', url: '/game_center'),
  sweeper('sweeper', url: '/sweeper'),
  save('save', url: '/save'),
  collect('collect', url: '/collect'),
  mine('mine', url: '/mine'),
  settings('settings', url: '/settings'),
  ;

  final String path;
  final String url;

  const AppRoute(this.path, {required this.url});
}
