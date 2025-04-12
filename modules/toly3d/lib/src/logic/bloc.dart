import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tolyui/tolyui.dart';

import '../view/menus.dart';

part 'state.dart';

class World3dBloc extends Cubit<WorldState> {
  Action3D get mode {
    if (state.activeMenus.contains(Action3D.rotate.name))
      return Action3D.rotate;
    if (state.activeMenus.contains(Action3D.reset.name)) return Action3D.reset;

    return Action3D.none;
  }

  World3dBloc()
      : super(WorldState(activeMenus: [
          Action3D.grid.name,
          Action3D.rotate.name,
        ]));

  void onTapMenu(String id) {
    print("====onTapMenu:${id}=========");
    if (id == Action3D.reset.name) {
      emit(state.copyWith(transform: Transform3d()));
      return;
    }
    List<String> current = state.activeMenus.toList();
    if (current.contains(id)) {
      current.remove(id);
    } else {
      current.add(id);
    }

    emit(state.copyWith(activeMenus: current));
  }

  void transrorm(double dx) {
    if (mode == Action3D.rotate) {
      emit(state.copyWith(
          transform: Transform3d(
        rotation: state.transform.rotation + dx / 300,
      )));
    }
  }
}
