import 'dart:convert';

import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flutter/services.dart';
import 'dart:ui';
import 'package:path/path.dart' as path;

class TextureLoader {
  final List<Frame> _frames = [];
  late final Image _sprites;

  final Map<String, Sprite> _staticSpriteMap = {};

  Future<void> _initStaticSprites() async {
    List<String> images = [
      'break_bricks/Btn_V13.png',
      'break_bricks/Btn_V14.png',
      'break_bricks/Btn_V03.png',
      'break_bricks/Btn_V04.png',
      'break_bricks/Btn_V17.png',
      'break_bricks/Btn_V18.png',
      'break_bricks/Btn_V15.png',
      'break_bricks/Btn_V16.png',
      'break_bricks/Btn_V11.png',
      'break_bricks/Btn02.png',
      'break_bricks/Btn01.png',
      'break_bricks/BtnExitOpacity.png',
      'break_bricks/BtnExitNoOpacity.png',
      'break_bricks/blue_boxCheckmark.png',
      'break_bricks/grey_box.png',
      'break_bricks/red_cross.png',
      'break_bricks/buttonLong_beige.png',
      'break_bricks/buttonLong_beige_pressed.png',
      'break_bricks/shadedDark33.png',
      'break_bricks/shadedDark31.png',
      'break_bricks/shadedDark24.png',
      'break_bricks/texture_metal1.png',
      'break_bricks/texture_gem3.png',
      'break_bricks/texture_fabric1.png',
      'break_bricks/texture_ice1.png',
      'break_bricks/tile_0046.png',
      'break_bricks/tile_0044.png',
      'break_bricks/flatDark15.png',
      'break_bricks/flatDark13.png',
      'break_bricks/buttonLong_brown.png',
      'break_bricks/buttonLong_brown_pressed.png',
      'break_bricks/buttonLong_blue.png',
      'break_bricks/buttonLong_blue_pressed.png',
      'break_bricks/buttonLong_blue_pressed.png',
      'break_bricks/panel.png',
      'break_bricks/Window04.png',
      'break_bricks/level.png',
    ];
    for (int i = 0; i < images.length; i++) {
      String filename = path.basename(images[i]);
      _staticSpriteMap[filename] = await Sprite.load(images[i]);
    }
  }

  Future<void> load(String jsonAsset, String imageAsset) async {
    await _initStaticSprites();
    _frames.clear();
    String data = await rootBundle.loadString(jsonAsset);
    List<dynamic> textures = json.decode(data)['textures'];
    for (int i = 0; i < textures.length; i++) {
      dynamic texture = textures[i];
      _frames.addAll((texture['frames'] as List).map(Frame.fromMap));
    }
    _sprites = await Flame.images.load(imageAsset);
  }

  Sprite operator [](String name) {
    if(_staticSpriteMap.containsKey(name)){
      return _staticSpriteMap[name]!;
    }

    Frame frame = _frames.singleWhere((e) => e.name == name);
    return Sprite(
      _sprites,
      srcPosition: frame.srcPosition,
      srcSize: frame.sourceSize,
    );
  }
}

class Frame {
  final String name;
  final Vector2 sourceSize;
  final Vector2 srcPosition;

  Frame({
    required this.name,
    required this.sourceSize,
    required this.srcPosition,
  });

  factory Frame.fromMap(dynamic map) {
    return Frame(
        name: map['filename'],
        sourceSize: Vector2(
          map['frame']['w'].toDouble(),
          map['frame']['h'].toDouble(),
        ),
        srcPosition: Vector2(
          map['frame']['x'].toDouble(),
          map['frame']['y'].toDouble(),
        ));
  }

  @override
  String toString() {
    return 'Frame{name: $name, sourceSize: $sourceSize, srcPosition: $srcPosition}';
  }
}
