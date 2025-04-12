import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fx_framework/fx_framework.dart';
import 'package:sweeper/app/sweeper_app.dart';
import 'package:toly_game/components/project/custom_desk_top_bar.dart';
import 'package:toly_game/data/data.dart';
import 'package:toly_game/data/res/toly_game_icon.dart';
import 'package:toly_game/navigation/router/app_route.dart';
import 'package:tolyui/basic/basic.dart';
import 'package:tolyui_meta/tolyui_meta.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../logic/bloc/bloc.dart';

// 颜色常量定义
const Color primaryDark = Color(0xFF0A0A12); // 基础深空黑
const Color accentPurple = Color(0xFF7C4DFF); // 主品牌紫
const Color neonBlue = Color(0xFF00F2FE); // 霓虹蓝
const Color cyberPink = Color(0xFFFF2D55); // 赛博粉
const Color matrixGreen = Color(0xFF00FF88); // 矩阵绿
const Color deepSpace = Color(0xFF1A1A2C); // 太空深蓝

class GameCenterNavigation extends StatelessWidget {
  final StatefulNavigationShell child;

  const GameCenterNavigation({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: [
          GameCenterTopBar(onClose: _closeGame),
          const Divider(),
          Expanded(child: child)
        ],
      ),
    );
  }

  void _closeGame(BuildContext context, ImageMenu menu, bool active) {
    GameCenterBloc bloc = context.read<GameCenterBloc>();
    int removedIndex = bloc.closeGame(menu);
    List<ImageMenu> menus = bloc.state.tabMenus;
    child.closeBranch(menu.route);
    if (!active) return;

    String nextRoute() {
      if (menus.isEmpty) {
        return AppRoute.gameCenter.url;
      }
      if (removedIndex == 0) {
        return menus.first.route;
      }
      return menus[removedIndex - 1].route;
    }

    context.go(nextRoute());
  }
}

class GameCenterTopBar extends StatelessWidget {
  final CloseCallBack<ImageMenu> onClose;

  const GameCenterTopBar({super.key, required this.onClose});

  @override
  Widget build(BuildContext context) {
    final String activePath = GoRouterState.of(context).uri.toString();
    List<ImageMenu> games = context.select(
      (GameCenterBloc bloc) => bloc.state.tabMenus,
    );
    if (games.isEmpty) {
      return const CustomDeskTopBar(title: '游戏中心');
    }
    const ImageMenu gameCenter = ImageMenu(
      "assets/images/logo/game_center.svg",
      label: '游戏中心',
      route: '/game/center',
      closeable: false,
    );
    games = [gameCenter, ...games];
    return CustomDeskTopBar(
      vAlignment: CrossAxisAlignment.start,
      center: Wrap(
        children: games.map((e) {
          return GameTab(
            active: e.route == activePath,
            menu: e,
            onClose: onClose,
            onTap: (menu) => context.go(menu.route),
          );
        }).toList(),
      ),
    );
  }
}

typedef CloseCallBack<T> = Function(BuildContext context, T data, bool value);

class GameTab extends StatelessWidget {
  final ImageMenu menu;
  final ValueChanged<ImageMenu> onTap;
  final CloseCallBack<ImageMenu> onClose;
  final bool active;

  const GameTab({
    super.key,
    required this.menu,
    required this.onTap,
    required this.onClose,
    required this.active,
  });

  BoxDecoration get decoration {
    Color color = active ? const Color(0xff1e1f22) : Colors.transparent;
    Color borderColor = active ? const Color(0xff3574f0) : Colors.transparent;
    const BorderSide topSide = BorderSide(width: 2, color: Colors.transparent);
    BorderSide bottomSide = BorderSide(width: 2, color: borderColor);
    Border border = Border(top: topSide, bottom: bottomSide);
    return BoxDecoration(color: color, border: border);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(menu),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: decoration,
        child: Wrap(
          spacing: 6,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            SvgPicture.asset(menu.image, width: 14, color: Colors.white),
            Text(menu.label),
            if (menu.closeable)
              TolyAction(
                child: const Icon(Icons.close, size: 10),
                onTap: () => onClose(context, menu, active),
              )
          ],
        ),
      ),
    );
  }
}

class GameCenterPage extends StatelessWidget {
  const GameCenterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: [
          CustomDeskTopBar(title: '游戏中心'),
          Divider(),
          Expanded(child: GameCenter())
        ],
      ),
    );
  }
}

class GameCenter extends StatelessWidget {
  const GameCenter({super.key});

  @override
  Widget build(BuildContext context) {
    const SliverGridDelegate grid = SliverGridDelegateWithMaxCrossAxisExtent(
      maxCrossAxisExtent: 200,
      childAspectRatio: 0.8,
    );
    const EdgeInsetsGeometry padding = EdgeInsets.all(8);
    List<GamePo> games =
        context.select((GameCenterBloc bloc) => bloc.state.games);
    return GridView.builder(
      padding: padding,
      gridDelegate: grid,
      itemBuilder: (_, index) {
        return GameTiled(
          onTap: (GamePo game) {
            context.read<GameCenterBloc>().openGame(game.id);
            context.go(game.route);
          },
          game: games[index],
        );
      },
      itemCount: games.length,
    );
  }
}

class GameTiled extends StatelessWidget {
  final GamePo game;
  final ValueChanged<GamePo> onTap;

  const GameTiled({super.key, required this.game, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(game),
      child: ColoredBox(
        color: Colors.transparent,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: _buildImage()),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 4),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      game.title,
                      style: const TextStyle(color: Color(0xffb0b0b0)),
                    ),
                  ),
                  if (game.article != null)
                    GestureDetector(
                        onTap: () => launch(game.article!),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 4.0),
                          child: Icon(
                            TolyGameIcon.juejin,
                            size: 18,
                          ),
                        )),
                  if (game.github != null)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: GestureDetector(
                          onTap: () => launch(game.github!),
                          child: const Icon(
                            TolyGameIcon.github,
                            size: 20,
                          )),
                    )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                game.createAt,
                style: const TextStyle(fontSize: 12, color: Color(0xff6b6b6b)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> launch(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  }

  Widget _buildImage() {
    return Card(
      color: const Color(0xff222222),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: AspectRatio(
              aspectRatio: 1,
              child: Image.asset(
                game.image,
                fit: BoxFit.cover,
              )),
        ),
      ),
    );
  }
}
