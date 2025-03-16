import 'package:flutter/material.dart';

import 'rail_navigation.dart';

const Gradient bgGradient = LinearGradient(
  colors: [Color(0xFF0A0A12), Color(0xFF1A1A2C)],
  stops: [0.3, 0.8],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);

class DeskNavigation extends StatelessWidget {
  final Widget content;

  const DeskNavigation({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration: const BoxDecoration(gradient: bgGradient),
        child: Row(
          children: [
            const DeskNavigationRail(),
            const VerticalDivider(),
            Expanded(child: content),
          ],
        ),
      ),
    );
  }
}
