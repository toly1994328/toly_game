import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fx_framework/fx_framework.dart';

class Splash extends StatelessWidget {
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
    const TextStyle style = TextStyle(fontSize: 12, color: Color(0xB3FFFFFF));
    String text = "Powered by 张风捷特烈";
    return DragToMoveWrapper(
      child: Scaffold(
        body: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            _buildLogo(),
            const Positioned(top: 0, right: 0, child: WindowButtons()),
            Positioned(bottom: 16, child: Text(text, style: style))
          ],
        ),
      ),
    );
  }

  Widget _buildLogo() => Center(
        child: Wrap(
          direction: Axis.vertical,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Hero(
              tag: "splash-logo",
              child: SvgPicture.asset('assets/images/logo.svg', width: 100),
            ),
            const Text("Toly Game Box", style: TextStyle(fontSize: 18)),
            const SizedBox(
              height: 12,
            ),
            const CupertinoActivityIndicator()
          ],
        ),
      );
}
