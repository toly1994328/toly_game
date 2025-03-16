import 'package:flutter/material.dart';

class LevelItem extends StatelessWidget {
  final bool locked;
  final ValueChanged<int> onTapItem;
  final int level;

  const LevelItem({
    super.key,
    this.locked = true,
    required this.level,
    required this.onTapItem,
  });

  @override
  Widget build(BuildContext context) {
    const TextStyle numStyle = TextStyle(
        fontSize: 20, color: Colors.white, fontFamily: 'JetBrainsMono');
    const TextStyle textStyle =
        TextStyle(color: Colors.white, fontFamily: 'JetBrainsMono');
    const AssetImage image = AssetImage('assets/images/break_bricks/level.png');
    Widget child = Center(
      child: Container(
        width: 84,
        height: 84,
        alignment: Alignment.center,
        decoration: const BoxDecoration(image: DecorationImage(image: image)),
        child: Wrap(
          direction: Axis.vertical,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Text(level.toString(), style: numStyle),
            if (locked) const Icon(Icons.lock, color: Colors.white, size: 16),
            if (!locked) const Text("Level", style: textStyle),
          ],
        ),
      ),
    );

    if (locked) return ColorFiltered(colorFilter: greyscale, child: child);

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => onTapItem(level),
        child: child,
      ),
    );
  }
}

const ColorFilter greyscale = ColorFilter.matrix(<double>[
  0.2126,
  0.7152,
  0.0722,
  0,
  0,
  0.2126,
  0.7152,
  0.0722,
  0,
  0,
  0.2126,
  0.7152,
  0.0722,
  0,
  0,
  0,
  0,
  0,
  1,
  0,
]);
