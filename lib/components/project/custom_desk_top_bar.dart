import 'package:flutter/material.dart';
import 'package:fx_framework/fx_framework.dart';

class CustomDeskTopBar extends StatelessWidget {
  final double height;
  final String title;
  final Widget? center;

  const CustomDeskTopBar({
    super.key,
    this.height = 56,
    required this.title,
    this.center,
  });

  @override
  Widget build(BuildContext context) {
    const TextStyle titleStyle =
        TextStyle(fontSize: 16, fontWeight: FontWeight.bold);
    Widget? child = const Spacer();
    if (center != null) {
      child = Expanded(child: center!);
    }
    return DragToMoveWrapper(
        child: SizedBox(
      height: height,
      child: Row(
        children: [
          const SizedBox(width: 16),
          Text(title, style: titleStyle),
          child,
          if (kAppEnv.isWindows) const WindowButtons()
        ],
      ),
      // color: Colors.grey,
    ));
  }
}
