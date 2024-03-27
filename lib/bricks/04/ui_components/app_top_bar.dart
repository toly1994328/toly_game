import 'package:flutter/material.dart';

import '../../../utils/platform_adapter/views/window_buttons.dart';
import '../../../utils/platform_adapter/window/windows_adapter.dart';

class AppTopBar extends StatelessWidget {
  const AppTopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return const DragToMoveAreaNoDouble(
      child: Material(
        color: Color(0xffebebeb),
        child: SizedBox(
          height: 30,
          child: NavigationToolbar(
            middle: Text(
              "Toly Game",
              style: TextStyle(fontSize: 12),
            ),
            trailing: WindowButtons(),
          ),
        ),
      ),
    );
  }
}
