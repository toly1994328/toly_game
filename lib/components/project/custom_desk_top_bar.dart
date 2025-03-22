import 'package:flutter/material.dart';
import 'package:fx_framework/fx_framework.dart';

class CustomDeskTopBar extends StatelessWidget {
  final double height;
  final String? title;
  final Widget? center;
  final Widget? leading;
  final CrossAxisAlignment? vAlignment;

  const CustomDeskTopBar({
    super.key,
    this.height = 56,
    this.title,
    this.center,
    this.leading,
    this.vAlignment,
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
        crossAxisAlignment: vAlignment??CrossAxisAlignment.center,
        children: [
          if(leading!=null) Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: leading!,
          ),
          if(title!=null)
            Padding(
                padding: const EdgeInsets.only(left: 16),
                child:  Text(title!, style: titleStyle)),
          child,
          if (kAppEnv.isWindows) const WindowButtons()
        ],
      ),
      // color: Colors.grey,
    ));
  }
}
