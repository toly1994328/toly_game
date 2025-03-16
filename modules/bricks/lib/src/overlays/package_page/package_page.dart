import 'package:flame/widgets.dart';
import 'package:flame_ext/flame_ext.dart';
import 'package:flutter/material.dart';
import '../../bricks_game.dart';
import '../../config/audio_manager/sound_effect.dart';
import 'package_content.dart';

class PackagePage extends StatefulWidget {
  final BricksGame game;

  const PackagePage({super.key, required this.game});

  @override
  State<PackagePage> createState() => _PackagePageState();
}

class _PackagePageState extends State<PackagePage> {

  @override
  void initState() {
    super.initState();
    widget.game.paused = true;
  }

  @override
  void dispose() {
    if(!widget.game.hasHomePage){
      widget.game.paused = false;
    }
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    const color = Color.fromRGBO(255, 255, 255, 1.0);
    const TextStyle titleStyle =
        TextStyle(color: color, fontSize: 14, fontWeight: FontWeight.bold);
    return Material(
      color: Colors.transparent,
      child: Center(
        child: Stack(
          children: [
            Container(
              height: 460,
              width: 280,
              padding: const EdgeInsets.all(4.0),
              child: NineImageWidget(
                opacity: 0.95,
                expandZone: const Rect.fromLTWH(16, 16, 30, 30),
                image: widget.game.loader['package_panel.png'].image,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                        height: 46,
                        alignment: Alignment.center,
                        child: const Text('我的背包', style: titleStyle)),
                    Expanded(child: PackageContent(game: widget.game)),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
            Positioned(
                right: 0,
                child:
                    SpriteCloseButton(game: widget.game, pageId: 'PackagePage'))
          ],
        ),
      ),
    );
  }
}

class SpriteCloseButton extends StatelessWidget {
  final BricksGame game;
  final String pageId;

  const SpriteCloseButton(
      {super.key, required this.game, required this.pageId});

  @override
  Widget build(BuildContext context) {
    return SpriteButton(
      onPressed: () {
        game.am.play(SoundEffect.uiClose);
        game.overlays.remove(pageId);
      },
      label: const Text(''),
      sprite: game.loader['BtnExitNoOpacity.png'],
      pressedSprite: game.loader['BtnExitOpacity.png'],
      height: 24,
      width: 24,
    );
  }
}
