
import 'persistence/frame/frame_store.dart';
import 'persistence/life_game_store.dart';

class GameLifeStorage {

  GameLifeStorage._();

  static GameLifeStorage? _instance;

  factory GameLifeStorage() => _instance ??= GameLifeStorage._();

  final LifeGameDbStore _lifeGame = LifeGameDbStore();

  FrameStore get frameStore => _lifeGame.frameStore;

  Future<void> init() async{
    await _lifeGame.open();
  }

}
