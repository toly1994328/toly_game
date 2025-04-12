part of 'bloc.dart';

class WorldState {
  final List<String> activeMenus;
  final Transform3d transform;

  WorldState({
    this.activeMenus = const [],
    this.transform = const Transform3d(),
  });

  WorldState copyWith({
    List<String>? activeMenus,
    Transform3d? transform,
  }) {
    return WorldState(
      activeMenus: activeMenus ?? this.activeMenus,
      transform: transform ?? this.transform,
    );
  }
}

class Transform3d {
  final double rotation;
  final double scale;
  final double distance;

  const Transform3d({
    this.rotation = 0,
    this.scale = 32,
    this.distance = 18,
  });
}
