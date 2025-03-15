import 'package:flutter/material.dart';
import 'package:fx_framework/fx_framework.dart';

import '../data/data.dart';
import '../navigation/router/app_route.dart';
import 'view/entry.dart';
import 'toly_game_box_repo.dart';

class TolyGameBoxApp with FxStarter<AppConfig> {
  const TolyGameBoxApp();

  @override
  Widget get app => const TolyGameBox();

  @override
  void onGlobalError(Object error, StackTrace stack) {
    print("${error}: stack:$stack");
  }

  @override
  void onLoaded(BuildContext context, int cost, AppConfig state) {

  }

  @override
  void onStartError(BuildContext context, Object error, StackTrace trace) {}

  @override
  void onStartSuccess(BuildContext context, AppConfig state) {
    context.go(AppRoute.gameCenter.url);
  }

  @override
  AppStartRepository<AppConfig> get repository => const TolyGameBoxRepo();
}
