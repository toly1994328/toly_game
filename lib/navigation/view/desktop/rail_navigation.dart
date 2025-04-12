import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fx_framework/fx_framework.dart';
import 'package:toly_game/data/res/toly_game_icon.dart';
import 'package:tolyui/tolyui.dart';

import '../../router/app_route.dart';
import 'elements/logo.dart';
import 'elements/setting_button.dart';

class DeskNavigationRail extends StatelessWidget {
  const DeskNavigationRail({super.key});

  List<MenuMeta> get navMenus => [
        IconMenu(TolyGameIcon.game_center,
            label: "首页", route: AppRoute.gameCenter.url),
        IconMenu(
          TolyGameIcon.save,
          label: "存档",
          route: AppRoute.save.url,
        ),
        IconMenu(
          TolyGameIcon.collect,
          label: "收藏",
          route: AppRoute.collect.url,
        ),
        IconMenu(
          TolyGameIcon.mine,
          label: "我的",
          route: AppRoute.mine.url,
        ),
      ];

  @override
  Widget build(BuildContext context) {
    final String activePath = GoRouterState.of(context).uri.toString();
    final bool isSetting = activePath == AppRoute.settings.url;
    return DragToMoveWrapper(
      child: TolyRailMenuBar(
        width: 68,
        gap: 10,
        padding: const EdgeInsets.symmetric(horizontal: 6),
        cellBuilder: GameMenuCell.create,
        animationConfig: const AnimationConfig(type: AnimTickType.hove),
        leading: (type) => const TolyGameLogo(),
        menus: navMenus,
        activeId: activePath,
        backgroundColor: Colors.transparent,
        onSelected: context.go,
        tail: (_) => SettingButton(active: isSetting),
      ),
    );
  }
}

class GameMenuCell extends StatelessWidget {
  final MenuMeta menu;
  final DisplayMeta display;

  const GameMenuCell({
    super.key,
    required this.menu,
    required this.display,
  });

  const GameMenuCell.create(this.menu, this.display, {super.key});

  ColorTween get foregroundTween => ColorTween(
      begin: const Color(0xFF4A4A6A), end: const Color(0xFF8D6EFF) // 强化品牌色,
      );

  ColorTween get textTween =>
      ColorTween(begin: const Color(0xFF6A6A8A), end: const Color(0xaaedf2fa));

  @override
  Widget build(BuildContext context) {
    Color? textColor = textTween.transform(display.rate);
    Color? menuColor = foregroundTween.transform(display.rate);

    TextStyle style = TextStyle(color: textColor, fontSize: 12);
    IconData? icon;
    if (menu is IconMenu) {
      icon = (menu as IconMenu).icon;
    }
    return Container(
      alignment: Alignment.center,
      height: 64,
      child: Wrap(
        spacing: 6,
        direction: Axis.vertical,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Icon(icon, color: menuColor, size: 24),
          Text(menu.label, style: style),
        ],
      ),
    );
  }
}
