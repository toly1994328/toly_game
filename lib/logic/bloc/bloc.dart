import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toly_game/data/data.dart';

class GameCenterBloc extends Cubit<GameCenterState> {
  GameCenterBloc() : super(const GameCenterState());

  GameRepository repository = GameRepository();

  void loadGame() async {
    List<GamePo> games = await repository.queryGame();
    emit(GameCenterState(games: games));
  }
}

class GameCenterState {
  final List<GamePo> games;

  const GameCenterState({this.games = const []});
}
