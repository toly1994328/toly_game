import 'dart:io';

import 'package:flutter/services.dart';

class SizeUtils {
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
