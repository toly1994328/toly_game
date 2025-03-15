
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fx_framework/fx_framework.dart';
import 'package:toly_game/logic/bloc/bloc.dart';
import 'package:tolyui/app/toly_ui.dart';

import '../../navigation/router/app_route.dart';

class TolyGameBox extends StatefulWidget {
  const TolyGameBox({super.key});

  @override
  State<TolyGameBox> createState() => _TolyGameBoxState();
}

class _TolyGameBoxState extends State<TolyGameBox> {

  final GoRouter _router = GoRouter(
    initialLocation: AppRoute.splash.url,
    routes: <RouteBase>[appRoute],
    onException: (BuildContext ctx, GoRouterState state, GoRouter router) {
      router.go(AppRoute.globalError.url, extra: state.uri.toString());
    },
  );

  @override
  Widget build(BuildContext context) {
    return GlobalStateScope(
      child: TolyUiApp.router(
        themeMode: ThemeMode.dark,
        theme: ThemeData(
          brightness: Brightness.dark,
            pageTransitionsTheme: const PageTransitionsTheme(builders: {
              TargetPlatform.android: SlidePageTransitionsBuilder(),
              TargetPlatform.iOS: SlidePageTransitionsBuilder(),
              TargetPlatform.macOS: FadePageTransitionsBuilder(),
              TargetPlatform.windows: FadePageTransitionsBuilder(),
              TargetPlatform.linux: FadePageTransitionsBuilder(),
            }),
          dividerTheme: DividerThemeData(
            color: Color(0xFF2A2A4D),
            thickness: 1,
            space: 1
          )
        ),
        routerConfig: _router,
      ),
    );
  }
}


class GlobalStateScope extends StatelessWidget {
  final Widget child;

  const GlobalStateScope({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (_)=>GameCenterBloc()..loadGame())
        ],
        child: child);
  }
}
