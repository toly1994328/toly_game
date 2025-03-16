import 'dart:math';

import 'package:equatable/equatable.dart';

/// [kWorldTimeUnit] 是世界演化的基本时间单位
/// 对应现实世界的 1000 ms 也就是 1s
///
/// [kSupports] 应用支持的演化速率设置
class Speed extends Equatable {
  final int level;

  static const _kWorldTimeUnit = 600;

  const Speed._(this.level);

  static List<Speed> kSupports = [1, 2, 3, 4, 5, 6,7,8].map((e) => Speed._(e)).toList();

  static Speed initial = const Speed._(1);

  double get time => _kWorldTimeUnit / level;

  static  ({int min,int max}) get limit => (min:kSupports.first.level,max: kSupports.last.level);

  @override
  List<Object?> get props => [level];
}
