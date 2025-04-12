import 'package:flutter/material.dart';
import 'package:tolyui/basic/basic.dart';

class Menus extends StatelessWidget {
  const Menus({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      padding: EdgeInsets.symmetric(vertical: 16),
      width: 52,
      child: Column(
        spacing: 6,
        children: [
          TolyAction(
              selected: true,
              child: Icon(
                Icons.grid_4x4,
                size: 20,
              ),
              onTap: () {}),
          TolyAction(
              selected: false,
              child: Icon(Icons.rotate_90_degrees_ccw, size: 20),
              onTap: () {}),
          TolyAction(
              selected: false,
              child: Icon(Icons.rotate_90_degrees_ccw, size: 20),
              onTap: () {}),
        ],
      ),
    );
  }
}
