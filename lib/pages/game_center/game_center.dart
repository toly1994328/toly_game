import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fx_framework/fx_framework.dart';
import 'package:sweeper/app/sweeper_app.dart';
import 'package:toly_game/components/project/custom_desk_top_bar.dart';
import 'package:toly_game/data/data.dart';
import 'package:toly_game/data/res/toly_game_icon.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../logic/bloc/bloc.dart';

// 颜色常量定义
const Color primaryDark = Color(0xFF0A0A12); // 基础深空黑
const Color accentPurple = Color(0xFF7C4DFF); // 主品牌紫
const Color neonBlue = Color(0xFF00F2FE); // 霓虹蓝
const Color cyberPink = Color(0xFFFF2D55); // 赛博粉
const Color matrixGreen = Color(0xFF00FF88); // 矩阵绿
const Color deepSpace = Color(0xFF1A1A2C); // 太空深蓝

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
    List<GamePo> games =
        context.select((GameCenterBloc bloc) => bloc.state.games);
    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
        childAspectRatio: 0.8,
      ),
      itemBuilder: (_, index) {
        return GestureDetector(
            onTap: () {
              context.push('/${games[index].id}');
            },
            child: GameTiled(game: games[index]));
      },
      itemCount: games.length,
    );
  }
}

class GameTiled extends StatelessWidget {
  final GamePo game;

  const GameTiled({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
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
                    style: TextStyle(color: Color(0xffb0b0b0)),
                  ),
                ),
                if (game.article != null)
                  GestureDetector(
                      onTap: () => launch(game.article!),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
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
                        child: Icon(
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
              style: TextStyle(fontSize: 12, color: Color(0xff6b6b6b)),
            ),
          ),
        ],
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
