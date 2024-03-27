import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toly_game/utils/size_utils.dart';

import 'app.dart';

main() {
  runApp(const TolyGameApp());
  SizeUtils.setSize(size: const Size(360, 360 * 2400 / 1080 + 30 - 18));
}
