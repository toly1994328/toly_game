import 'dart:ui';

import 'package:flutter/material.dart';

import '../../components/project/custom_desk_top_bar.dart';
import 'core/core.dart';
import 'core/project/project.dart';

class MinePage extends StatefulWidget {
  const MinePage({super.key});

  @override
  State<MinePage> createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: [
          CustomDeskTopBar(title: '我的账号'),
          Divider(),
        ],
      ),
    );
  }
}
