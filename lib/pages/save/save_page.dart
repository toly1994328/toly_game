import 'package:flutter/material.dart';
import 'package:fx_framework/fx_framework.dart';

import '../../components/project/custom_desk_top_bar.dart';

class SavePage extends StatelessWidget {
  const SavePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: [
          CustomDeskTopBar(title: '游戏存档'),
          Divider(),
        ],
      ),
    );
  }
}
