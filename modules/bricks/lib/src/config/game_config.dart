import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../heroes/paddle.dart';
import '../overlays/shop_page/goods.dart';
import 'buy_goods.dart';

class GameConfig {
  // 已购买的挡板索引列表
  final List<int> activePaddles;
  final List<BuyGoods> buyGoods;

  /// 最大解锁关卡数
  final int maxUnLockLevel;

  // 绿水晶个数
  final int blueCrystal;

  // 金币个数
  final int coin;

  // 是否开启音效
  final bool enableSoundEffect;

  // 挡板类型
  final PaddleType paddleType;



  // 是否开启背景音乐
  final bool enableBgMusic;

  const GameConfig({
    required this.maxUnLockLevel,
    required this.blueCrystal,
    required this.coin,
    required this.paddleType,
    required this.enableSoundEffect,
    this.activePaddles = const [],
    this.buyGoods = const [],
    required this.enableBgMusic,
  });

  factory GameConfig.fromMap(dynamic map) {
    List<BuyGoods> buyGoods = [];
    if (map['buyGoods'] != null) {
      buyGoods =
          (map['buyGoods'] as List).map<BuyGoods>(BuyGoods.fromMap).toList();
    }

    return GameConfig(
      maxUnLockLevel: map['maxUnLockLevel'] ?? 1,
      buyGoods: buyGoods,
      blueCrystal: map['blueCrystal'] ?? 0,
      coin: map['coin'] ?? 0,
      activePaddles:
          map['activePaddles']?.map<int>((e) => e as int).toList() ?? [5],
      paddleType: PaddleType.values[map['paddleType'] ?? 5],
      enableSoundEffect: map['enableSoundEffect'] ?? true,
      enableBgMusic: map['enableBgMusic'] ?? true,
    );
  }

  Map<String, dynamic> toJson() => {
        'maxUnLockLevel': maxUnLockLevel,
        'blueCrystal': blueCrystal,
        'coin': coin,
        'activePaddles': activePaddles,
        'paddleType': paddleType.index,
        'enableSoundEffect': enableSoundEffect,
        'enableBgMusic': enableBgMusic,
        'buyGoods': buyGoods,
      };

  GameConfig copyWith({
    int? maxUnLockLevel,
    int? blueCrystal,
    int? coin,
    bool? enableSoundEffect,
    bool? enableBgMusic,
    PaddleType? paddleType,
    List<int>? activePaddles,
    List<BuyGoods>? buyGoods
  }) =>
      GameConfig(
        maxUnLockLevel: maxUnLockLevel ?? this.maxUnLockLevel,
        blueCrystal: blueCrystal ?? this.blueCrystal,
        coin: coin ?? this.coin,
        paddleType: paddleType ?? this.paddleType,
        enableSoundEffect: enableSoundEffect ?? this.enableSoundEffect,
        enableBgMusic: enableBgMusic ?? this.enableBgMusic,
        activePaddles: activePaddles ?? this.activePaddles,
        buyGoods: buyGoods ?? this.buyGoods,
      );
}

class GameConfigManager {
  static const _kConfigKey = 'bricks-game-config-key';

  final SharedPreferences sp;

  late GameConfig config;

  GameConfigManager(this.sp);

  void loadConfig(SharedPreferences sp) {
    String data = sp.getString(_kConfigKey) ?? "{}";
    config = GameConfig.fromMap(jsonDecode(data));
  }

  Future<void> saveConfig() => sp.setString(_kConfigKey, jsonEncode(config));

  /// 切换挡板样式
  Future<void> switchPaddleType(PaddleType type) {
    config = config.copyWith(paddleType: type);
    return saveConfig();
  }

  /// 购买挡板
  Future<void> buyPaddleSuccess(PaddleType type) {
    List<int> actives = [type.index, ...config.activePaddles];
    config = config.copyWith(activePaddles: actives);
    return saveConfig();
  }

  /// 解锁下一关
  Future<void> unlockNextLevel() {
    config = config.copyWith(maxUnLockLevel: config.maxUnLockLevel + 1);
    return saveConfig();
  }

  /// 增加绿水晶
  Future<void> addBlueCrystal({int count = 1}) {
    config = config.copyWith(blueCrystal: config.blueCrystal + count);
    return saveConfig();
  }

  /// 增加金币
  Future<void> addCoin({int count = 1}) {
    config = config.copyWith(coin: config.coin + count);
    return saveConfig();
  }

  /// 修改背景音乐是否激活
  Future<void> changeEnableBgMusic(bool enable) {
    config = config.copyWith(enableBgMusic: enable);
    return saveConfig();
  }

  /// 修改音效是否激活
  Future<void> changeEnableSoundEffect(bool enable) {
    config = config.copyWith(enableSoundEffect: enable);
    return saveConfig();
  }

  Future<void> saveGoodsToPackage(Goods goods) {
    List<BuyGoods> result = List.of(config.buyGoods);
    List<BuyGoods> buyGoods = config.buyGoods.where((e) => e.goods.src == goods.src).toList();
    if(buyGoods.isEmpty){
      result.add(BuyGoods(goods: goods, count: 1));
    }else{
      BuyGoods buy = buyGoods.first;
      BuyGoods newBuyGoods =  BuyGoods(goods: buy.goods,count:buy.count+1);
      result.removeWhere((e) => e.goods.src == goods.src);
      result.insert(0, newBuyGoods);
    }
    config = config.copyWith(buyGoods: result);
    return saveConfig();
  }

  Future<void> useGoodsInPackage(Goods goods) {
    List<BuyGoods> result = List.of(config.buyGoods);
    BuyGoods buyGoods = config.buyGoods.singleWhere((e) => e.goods.src == goods.src);
    if(buyGoods.count==1){
      result.removeWhere((e) => e.goods.src == goods.src);
    }else{
      BuyGoods newBuyGoods =  BuyGoods(goods: buyGoods.goods,count:buyGoods.count-1);
      result.removeWhere((e) => e.goods.src == goods.src);
      result.insert(0, newBuyGoods);
    }
    config = config.copyWith(buyGoods: result);
    return saveConfig();
  }
}
