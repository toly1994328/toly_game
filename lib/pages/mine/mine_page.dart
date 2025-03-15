import 'package:flutter/material.dart';

import '../../components/project/custom_desk_top_bar.dart';


class MinePage extends StatelessWidget {
  const MinePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body : Column(
        children: [
          CustomDeskTopBar(title: '我的账号'),
          Divider(),
        ],
      ),
    );
  }
}
