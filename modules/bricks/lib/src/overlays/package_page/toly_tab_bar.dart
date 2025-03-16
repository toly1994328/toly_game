import 'package:flutter/material.dart';

class TolyTabBar extends StatelessWidget {
  final int activeIndex;
  final ValueChanged<int> onTap;
  final List<String> tabs;

  const TolyTabBar({
    super.key,
    required this.onTap,
    required this.tabs,
    required this.activeIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
        children: tabs
            .asMap()
            .keys
            .map((int index) => MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () => onTap(index),
                    child: TolyTab(
                      label: tabs[index],
                      active: index == activeIndex,
                    ),
                  ),
                ))
            .toList());
  }
}

class TolyTab extends StatelessWidget {
  final String label;
  final bool active;

  const TolyTab({super.key, required this.label, required this.active});

  TextStyle get style {
    return active
        ? const TextStyle(
            fontSize: 14,
            color: Colors.blue,
            shadows: [Shadow(color: Colors.white, offset: Offset(.5, .5))])
        : const TextStyle(fontSize: 12, color: Colors.white);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        label,
        style: style,
      ),
    );
  }
}
