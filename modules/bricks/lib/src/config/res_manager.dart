import 'dart:async';
import 'dart:convert';

import 'package:flame_ext/flame_ext.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/level.dart';
import '../overlays/shop_page/goods_mamager.dart';
import 'extra_images.dart';
import 'game_config.dart';

class ResManager {

  ResManager._();
  static ResManager instance = ResManager._();

  late SharedPreferences sp;
  late GameConfigManager configManager;
  GoodsManager goodsManager = GoodsManager();

  List<Level> _levels = [];
  List<Level> get levels => _levels;

  TextureLoader loader = TextureLoader(package: 'bricks');

  late StreamController<double> _progressCtrl;

  Stream<double> get loadStream => _progressCtrl.stream;

  void load() async{
    _progressCtrl = StreamController.broadcast();
    sp = await SharedPreferences.getInstance();
    _progressCtrl.add(0.1);
    configManager = GameConfigManager(sp);
    configManager.loadConfig(sp);
    await loadLevels();
    _progressCtrl.add(0.2);

    await loader.load(
      'packages/bricks/assets/images/break_bricks.json',
      'images/break_bricks.png',
      extra: extraImages,
      loadingCallBack: (total,cur){
        _progressCtrl.add(0.8*(cur/total));
      }
    );
    await goodsManager.loadGoods();
    _progressCtrl.add(1);
    _progressCtrl.close();
  }

  Future<void> loadLevels() async {
    String path = 'packages/bricks/assets/data/bricks_levels.json';
    String data = await rootBundle.loadString(path);
    List<dynamic> list = json.decode(data) as List;
    _levels = list.map(Level.fromMap).toList();
  }

}