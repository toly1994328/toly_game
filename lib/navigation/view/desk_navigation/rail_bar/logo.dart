import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class TolyGameLogo extends StatelessWidget {
  const TolyGameLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: const Color(0x3340c4ff),
      child: SvgPicture.asset(
        'assets/images/logo.svg',
        width: 24,
      ),
    );
  }
}
