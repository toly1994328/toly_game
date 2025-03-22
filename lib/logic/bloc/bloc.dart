import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fx_framework/fx_framework.dart';
import 'package:toly_game/data/data.dart';
import 'package:toly_game/navigation/router/app_route.dart';
import 'package:tolyui_meta/tolyui_meta.dart';

class GameCenterBloc extends Cubit<GameCenterState> {
  GameCenterBloc() : super(const GameCenterState());

  GameRepository repository = GameRepository();

  void loadGame() async {
    List<GamePo> games = await repository.queryGame();
    emit(GameCenterState(games: games));
  }

  void openGame(String id) {
    GamePo? po = findGameById(id);
    if (po == null) return;
    List<ImageMenu> menus = state.tabMenus.toList();
    menus.removeWhere((e) => e.route == po.route);
    ImageMenu menu = ImageMenu(po.logo, label: po.title, route: po.route);
    emit(state.copyWith(tabMenus: [menu, ...menus]));
  }

  GamePo? findGameById(String id) {
    int index = state.games.indexWhere((e) => e.id == id);
    if (index == -1) {
      // TODO 根据 id 加载 GamePo
      return null;
    } else {
      return state.games[index];
    }
  }

  int closeGame(ImageMenu menu) {
    List<ImageMenu> menus = state.tabMenus.toList();
    int index = menus.indexWhere((e) => e.id == menu.id);
    menus.removeAt(index);
    emit(state.copyWith(tabMenus: menus));
    return index;
  }


}

class GameCenterState {
  final List<GamePo> games;
  final List<ImageMenu> tabMenus;

  const GameCenterState({
    this.games = const [],
    this.tabMenus = const [],
  });

  GameCenterState copyWith({
    List<GamePo>? games,
    List<ImageMenu>? tabMenus,
  }) {
    return GameCenterState(
      games: games ?? this.games,
      tabMenus: tabMenus ?? this.tabMenus,
    );
  }
}
