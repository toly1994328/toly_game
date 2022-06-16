import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/parallax.dart';
import 'package:flutter/widgets.dart';

class BasicParallaxExample extends FlameGame {

  final _layersMeta = {
    'parallax/bg.png': 1.0,
    'parallax/mountain-far.png': 1.5,
    'parallax/mountains.png': 2.3,
    'parallax/trees.png': 3.8,
    'parallax/foreground-trees.png': 6.6,
  };

  Future<List<ParallaxLayer>> formLayerByMap(Map<String,double> data) async{
    List<ParallaxLayer> result = [];
    for(String image in data.keys){
      ParallaxLayer layer =  await loadParallaxLayer(
        ParallaxImageData(image),
        velocityMultiplier: Vector2(data[image]!, 1.0),
      );
      result.add(layer);
    }
    return result;
  }


  @override
  Future<void> onLoad() async {
    List<ParallaxLayer> layers =  await formLayerByMap(_layersMeta);
    final ParallaxLayer airplaneLayer = await loadParallaxLayer(
      ParallaxAnimationData(
        'parallax/airplane.png',
        SpriteAnimationData.sequenced(
          amount: 4,
          stepTime: 0.2,
          textureSize: Vector2(320, 160),
        ),
      ),
      repeat: ImageRepeat.noRepeat,
      velocityMultiplier: Vector2.zero(),
      fill: LayerFill.none,
      alignment: Alignment.center,
    );
    layers.add(airplaneLayer);
    final parallax = ParallaxComponent(
      parallax: Parallax(
        layers,
        baseVelocity: Vector2(20, 0),
      ),
    );
    add(parallax);
  }
}
