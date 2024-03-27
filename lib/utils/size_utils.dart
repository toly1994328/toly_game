import 'dart:io';

import 'package:flutter/services.dart';

import 'platform_adapter/window/windows_adapter.dart';



class SizeUtils {
  static void setSize({
    Size size = const Size(920, 680),
  }) {
    WindowsAdapter.setSize(
      size: size,
    );
    fullScreenMobile();
  }

  static void fullScreenMobile() {
    if (Platform.isAndroid || Platform.isIOS) {
      // 强制横屏
      // SystemChrome.setPreferredOrientations(
      //     [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
      // 隐藏状态栏和导航栏
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    }
  }
}
