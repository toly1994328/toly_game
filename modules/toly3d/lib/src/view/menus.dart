import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toly3d/src/logic/bloc.dart';
import 'package:tolyui/basic/basic.dart';
import 'package:tolyui/tolyui.dart';

enum Action3D {
  none,
  grid,
  rotate,
  translation,
  reset,
}

class Menus extends StatelessWidget {
  const Menus({super.key});

  @override
  Widget build(BuildContext context) {
    List<IconMenu> menus = [
      IconMenu(Icons.grid_3x3_outlined, route: Action3D.grid.name, label: ''),
      IconMenu(Icons.threed_rotation, route: Action3D.rotate.name, label: ''),
      IconMenu(Icons.my_location, route: Action3D.reset.name, label: ''),
      IconMenu(Icons.transgender, route: 't', label: ''),
    ];

    List<String> activeMenus =
        context.select((World3dBloc bloc) => bloc.state.activeMenus);

    return Container(
      color: Colors.black,
      padding: EdgeInsets.symmetric(vertical: 16),
      width: 52,
      child: Column(
          spacing: 6,
          children: menus.map((e) {
            return TolyAction(
                selected: activeMenus.contains(e.id),
                child: Icon(
                  e.icon,
                  size: 20,
                ),
                onTap: () {
                  context.read<World3dBloc>().onTapMenu(e.id);
                });
          }).toList()

          // [
          //   TolyAction(
          //       selected: true,
          //       child: Icon(
          //         Icons.grid_4x4,
          //         size: 20,
          //       ),
          //       onTap: () {}),
          //   TolyAction(
          //       selected: false,
          //       child: Icon(Icons.rotate_90_degrees_ccw, size: 20),
          //       onTap: () {}),
          //   TolyAction(
          //       selected: false,
          //       child: Icon(Icons.rotate_90_degrees_ccw, size: 20),
          //       onTap: () {}),
          // ],
          ),
    );
  }
}
