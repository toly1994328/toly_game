// Copyright 2014 The 张风捷特烈 . All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// Author:      张风捷特烈
// CreateTime:  2024-07-08
// Contact Me:  1981462002@qq.com


import 'package:flutter/material.dart';
import 'package:tolyui/tolyui.dart';

import '../model/evolve.dart';

class StatusBar extends StatelessWidget {
  final ValueNotifier<int> generation;
  final ValueNotifier<EvolveSpeed> speed;
  final ValueChanged<EvolveSpeed> onSpeedChange;

  const StatusBar({
    super.key,
    required this.generation,
    required this.onSpeedChange,
    required this.speed,
  });

  @override
  Widget build(BuildContext context) {
    ActionStyle style = const ActionStyle(
      backgroundColor: Colors.black,
      padding: EdgeInsets.all(2),
      selectColor: Colors.black,
      borderRadius: BorderRadius.all(Radius.circular(4)),
    );
    return Container(
      height: 26,
      padding: EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [

          Spacer(),
          ValueListenableBuilder(
            valueListenable: speed,
            builder: (_, value, __) {
              return RateChangeMenu(
                onSpeedChange: onSpeedChange,
                speed: value,
              );
            },
          )
          ,
          const SizedBox(width: 12),
          ValueListenableBuilder(
            valueListenable: generation,
            builder: (_, value, __) {
              return Text(
                '第 $value 代',
                style: TextStyle(fontSize: 12, height: 1),
              );
            },
          )
        ],
      ),
    );
  }
}

class RateChangeMenu extends StatelessWidget {
  final ValueChanged<EvolveSpeed> onSpeedChange;
  final EvolveSpeed speed;

  const RateChangeMenu({super.key, required this.onSpeedChange, required this.speed});

  @override
  Widget build(BuildContext context) {
    Color bgColor = context.isDark ? const Color(0xff303133) : Colors.white;

    return TolyDropMenu(
        placement: Placement.top,
        style: const DropMenuCellStyle(
            foregroundColor: Color(0xffcfd3dc),
            backgroundColor: Colors.transparent,
            hoverBackgroundColor: Color(0xff18222c),
            disableColor: Color(0xffbfbfbf),
            hoverForegroundColor: Color(0xffe6f7ff),
            textStyle: TextStyle(fontSize: 12)),
        offsetCalculator: boxOffsetCalculator,
        decorationConfig: DecorationConfig(isBubble: false, backgroundColor: bgColor),
        onSelect: (MenuMeta meta) {
          SpeedMeta? speedMeta = meta.ext?.me<SpeedMeta>();
          if (speedMeta != null) {
            onSpeedChange(speedMeta.speed);
          }
        },
        menuItems: EvolveSpeed.kSupports
            .map(
              (e) => ActionMenu(
                active: speed == e,
                MenuMeta(
                  router: '${e.level}',
                  label: 'v * ${e.level}',
                  ext: SpeedMeta(e),
                ),
              ),
            )
            .toList(),
        childBuilder: (_, ctrl, __) {
          return TolyAction(
              style: ActionStyle.dark(
                  backgroundColor: Color(0xff000000),
                  padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2)),
              onTap: ctrl.open,
              child: Text(
                '速率*${speed.level}',
                style: TextStyle(fontSize: 12, height: 1),
              ));
        });
  }
}

class SpeedMeta extends MenuMateExt {
  final EvolveSpeed speed;

  SpeedMeta(this.speed);
}
