import 'dart:convert';

import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flutter/services.dart';
import 'dart:ui';

class TextureLoader {
  final List<Frame> _frames = [];
  late final Image _sprites;

  Future<void> load(String jsonAsset, String imageAsset) async {
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
