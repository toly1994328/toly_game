// Copyright 2014 The 张风捷特烈 . All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// Author:      张风捷特烈
// CreateTime:  2024-07-05
// Contact Me:  1981462002@qq.com

import 'package:flutter/material.dart';

import 'package:tolyui/basic/basic.dart';
import 'package:tolyui/tolyui.dart';

import '../logic/frame_evolve.dart';
import '../res/toly_icon.dart';






enum ToolAction {
  play(TolyIcon.icon_play),
  next(TolyIcon.icon_next),
  see(Icons.blur_on_outlined),
  move(TolyIcon.icon_drag),
  paint(TolyIcon.icon_paint),
  eraser(TolyIcon.icon_eraser),
  reset(TolyIcon.icon_reset),
  clear(TolyIcon.icon_clear),
  list(Icons.dataset_linked_outlined),
  save(Icons.save),
  zero(Icons.repeat_one_outlined),

  ;

  final IconData? icon;

  const ToolAction(this.icon);
}

class ActionToolbar extends StatelessWidget {
  final ValueChanged<ToolAction> onAction;
  final ValueNotifier<EvolveStatus> status;
  final ValueNotifier<List<ToolAction>> actions;

  const ActionToolbar({
    super.key,
    required this.onAction,
    required this.status,
    required this.actions,
  });

  @override
  Widget build(BuildContext context) {
    ActionStyle style = const ActionStyle(
      backgroundColor: Colors.black,
      padding: EdgeInsets.all(2),
      selectColor: Colors.white24,
      borderRadius: BorderRadius.all(Radius.circular(4)),
    );



    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      width: 30,
      alignment: Alignment.topCenter,
      child: Column(
        children: [
          Expanded(
            child: Wrap(
                spacing: 6,
                direction: Axis.vertical,
                children:
                [
                  ToolAction.play,
                  ToolAction.next,
                  ToolAction.see,
                  ToolAction.paint,
                  ToolAction.eraser,
                  ToolAction.move,
                  ToolAction.zero,
                ].map((e) {
                  if(e==ToolAction.play){
                    return PlayCtrlButton(
                      status: status,
                      onAction: onAction,
                    );
                  }
                  if(e==ToolAction.see || e==ToolAction.paint ||
                     e==ToolAction.eraser || e==ToolAction.move){
                    return ValueListenableBuilder(
                      valueListenable: actions,
                      builder: (context,value,__) {
                        return TolyAction(
                          selected: value.contains(e),
                          style: style,
                          child: Icon(e.icon, size: 18),
                          onTap: () => onAction(e),
                        );
                      },
                    );
                  }

                  return TolyAction(
                    style: style,
                    child: Icon(e.icon, size: 18),
                    onTap: () => onAction(e),
                  );
                }).toList()),
          ),
          ValueListenableBuilder(
            valueListenable: actions,
            builder: (context,value,__) {
              return TolyAction(
                selected: value.contains(ToolAction.list),
                style: style,
                child: Icon(ToolAction.list.icon, size: 18),
                onTap: () => onAction(ToolAction.list),
              );
            },
          ),
          const SizedBox(height: 6),
          ValueListenableBuilder(
            valueListenable: actions,
            builder: (context,value,__) {
              return TolyAction(
                selected: value.contains(ToolAction.save),
                style: style,
                child: Icon(ToolAction.save.icon, size: 18),
                onTap: () => onAction(ToolAction.save),
              );
            },
          ),
          const SizedBox(height: 6),TolyAction(
            style: style,
            child: Icon(ToolAction.reset.icon, size: 18),
            onTap: (){
              onAction(ToolAction.reset);
            },
          ),
          const SizedBox(height: 6),TolyAction(
            style: style,
            child: Icon(ToolAction.clear.icon, size: 18),
            onTap: (){
              onAction(ToolAction.clear);
            },
          ),
        ],
      ),
    );
  }
}

class PlayCtrlButton extends StatelessWidget {
  final ValueNotifier<EvolveStatus> status;
  final ValueChanged<ToolAction> onAction;

  const PlayCtrlButton({super.key, required this.status, required this.onAction});

  @override
  Widget build(BuildContext context) {
    ActionStyle style = const ActionStyle(
      backgroundColor: Colors.black,
      padding: EdgeInsets.all(2),
      borderRadius: BorderRadius.all(Radius.circular(4)),
    );


    return ValueListenableBuilder(
      valueListenable: status,
      builder: (BuildContext context, EvolveStatus value, Widget? child) {
        Color? color;
        IconData icon;
        switch(value){
          case EvolveStatus.evolving:
            color = Colors.red;
            icon = TolyIcon.icon_pause;
            break;
          case EvolveStatus.stopped:
            icon = TolyIcon.icon_play;
            color = Colors.green;
        }

        return TolyAction(
          style: style,
          child: Icon(icon, size: 18,color: color,),
          onTap: () => onAction(ToolAction.play),
        );
      },
    );
  }
}
