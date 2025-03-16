import 'package:flutter/material.dart';

import '../../storage/bean/world.dart';
import '../action_toolbar.dart';
import 'edit_frame_panel.dart';
import 'list_frame_panel.dart';
import 'menu_tools_wrapper.dart';

class TogglePanel extends StatelessWidget {
  final ValueNotifier<List<ToolAction>> actions;
  final OnSubmit<FramePayload?> onSubmit;
  final OnMenuAction<MenuAction, FramePo?> onMenuAction;
  final ValueNotifier<String?> activeFrame;
  final FramePo? editData;

  const TogglePanel({
    super.key,
    required this.actions,
    required this.onSubmit,
    required this.onMenuAction,
    required this.activeFrame, this.editData,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: actions,
      builder: (context, value, __) {
        Widget? child;

        if (value.contains(ToolAction.save)) {
          child = EditFramePanel(onSubmit: onSubmit,model: editData,);
        }
        if (value.contains(ToolAction.list)) {
          child = ListFramePanel(
            onMenuAction: onMenuAction,
            activeFrame: activeFrame,
          );
        }
        if (child == null) return SizedBox();
        return Container(
          width: 200,
          decoration: BoxDecoration(
              border: Border(
                  left: BorderSide(
                      color: Theme.of(context).colorScheme.outlineVariant,
                      width: 1 / View.of(context).devicePixelRatio),
                  right: BorderSide(
                      color: Theme.of(context).colorScheme.outlineVariant,
                      width: 1 / View.of(context).devicePixelRatio))),
          child: child,
        );
      },
    );
  }
}
