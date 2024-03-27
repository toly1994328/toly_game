import 'dart:io';

import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

bool kIsDesk = Platform.isMacOS || Platform.isWindows || Platform.isLinux;

class WindowsAdapter {

  static Future<void> setSize({
    Size  size = const Size(920,680),
    Size?  minimumSize,
}) async {
    if (Platform.isMacOS || Platform.isWindows || Platform.isLinux) {
    //仅对桌面端进行尺寸设置
      await windowManager.ensureInitialized();
      WindowOptions windowOptions =  WindowOptions(
        size: size,
        minimumSize: minimumSize,
        center: true,
        backgroundColor: Colors.transparent,
        skipTaskbar: false,

        titleBarStyle: TitleBarStyle.hidden,
      );
      windowManager.waitUntilReadyToShow(windowOptions, () async {
        await windowManager.setTitleBarStyle(TitleBarStyle.hidden,windowButtonVisibility: false);
        // await windowManager.setAsFrameless();
        // await windowManager.setHasShadow(true);

        await windowManager.show();

        await windowManager.focus();
      });
    }
  }

}


class DragToMoveAreaNoDouble extends StatelessWidget {
  final Widget child;

  const DragToMoveAreaNoDouble({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(Platform.isAndroid||Platform.isIOS) return child;
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onPanStart: (details) {
        windowManager.startDragging();
      },
      child: child,
    );
  }
}