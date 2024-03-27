import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class GameConfig {
  /// 最大解锁关卡数
  final int maxUnLockLevel;

  // 绿水晶个数
  final int blueCrystal;

  // 金币个数
  final int coin;

  // 是否开启音效
  final bool enableSoundEffect;

  // 是否开启背景音乐
  final bool enableBgMusic;

  const GameConfig({
    required this.maxUnLockLevel,
    required this.blueCrystal,
    required this.coin,
    required this.enableSoundEffect,
    required this.enableBgMusic,
  });

  factory GameConfig.fromMap(dynamic map) {
    return GameConfig(
      maxUnLockLevel: map['maxUnLockLevel'] ?? 1,
      blueCrystal: map['blueCrystal'] ?? 0,
      coin: map['coin'] ?? 0,
      enableSoundEffect: map['enableSoundEffect'] ?? true,
      enableBgMusic: map['enableBgMusic'] ?? true,
    );
  }

  Map<String, dynamic> toJson() => {
        'maxUnLockLevel': maxUnLockLevel,
        'blueCrystal': blueCrystal,
        'coin': coin,
        'enableSoundEffect': enableSoundEffect,
        'enableBgMusic': enableBgMusic,
      };

  GameConfig copyWith({
    int? maxUnLockLevel,
    int? blueCrystal,
    int? coin,
    bool? enableSoundEffect,
    bool? enableBgMusic,
  }) =>
      GameConfig(
        maxUnLockLevel: maxUnLockLevel ?? this.maxUnLockLevel,
        blueCrystal: blueCrystal ?? this.blueCrystal,
        coin: coin ?? this.coin,
        enableSoundEffect: enableSoundEffect ?? this.enableSoundEffect,
        enableBgMusic: enableBgMusic ?? this.enableBgMusic,
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
}
