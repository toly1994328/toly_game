import 'package:equatable/equatable.dart';

/// [kWorldTimeUnit] 是世界演化的基本时间单位
/// 对应现实世界的 1000 ms 也就是 1s
///
/// [kSupports] 应用支持的演化速率设置
class EvolveSpeed extends Equatable{
  final double level;

  static const _kWorldTimeUnit = 500;

  const EvolveSpeed._(this.level);

  static List<EvolveSpeed> kSupports = [ 0.5, 1.0,2.0,3.0, 5.0, 10.0, 20.0]
      .map((e) => EvolveSpeed._(e))
      .toList();

  static EvolveSpeed initial = const EvolveSpeed._(1);

  double get time => _kWorldTimeUnit/level;

  @override
  List<Object?> get props => [level];
}
