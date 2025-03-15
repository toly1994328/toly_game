import 'package:flutter/material.dart';

import '../../components/project/custom_desk_top_bar.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: [
          CustomDeskTopBar(title: '系统设置'),
          Divider(),
        ],
      ),
    );
  }
}
