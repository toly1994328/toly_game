import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tolyui/tolyui.dart';

enum MenuAction {
  newFrame('newFrame'),
  copyFrame('copyFrame'),
  delete('delete'),
  edit('edit'),
  enter('enter'),
;

  final String route;

  const MenuAction(this.route);
}

class MenuToolsWrapper<T> extends StatefulWidget {
  final Widget child;
  final T data;
  final VoidCallback? onTap;

  final ValueChanged<MenuAction> onMenuAction;

  const MenuToolsWrapper({
    super.key,
    required this.child,
    required this.onMenuAction,
    this.onTap,
    required this.data,
  });

  @override
  State<MenuToolsWrapper> createState() => _MenuToolsWrapperState();
}

class _MenuToolsWrapperState extends State<MenuToolsWrapper> {
  PopoverController? ctrl;

  @override
  Widget build(BuildContext context) {
    if (!kIsWeb && (Platform.isAndroid || Platform.isIOS)) {
      return widget.child;
    }
    DropMenuCellStyle lightStyle = const DropMenuCellStyle(
      padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      borderRadius: BorderRadius.all(Radius.circular(6)),
      foregroundColor: Color(0xffcfd3dc),
      backgroundColor: Colors.transparent,
      hoverBackgroundColor: Color(0xff3f4042),
      disableColor: Color(0xffbfbfbf),
      hoverForegroundColor: Color(0xffe6f7ff),
      textStyle: TextStyle(fontSize: 12)
    );

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: TolyDropMenu(
        onSelect: onSelect,
        style: lightStyle,
        decorationConfig: const DecorationConfig(
            isBubble: false, backgroundColor: Color(0xff292a2d), radius: Radius.circular(8)),
        // placement: Placement.topStart,
        menuItems: [
          // ActionMenu(MenuMeta(
          //   router: MenuAction.disturb.route,
          //   icon: CupertinoIcons.folder_open,
          //   label: '打开',
          // )),

          ActionMenu(MenuMeta(
            router: MenuAction.newFrame.route,
            icon: CupertinoIcons.add_circled,
            label: '新建记录',
          )),
          ActionMenu(MenuMeta(
            router: MenuAction.copyFrame.route,
            icon: CupertinoIcons.doc_on_clipboard,
            label: '创建副本',
          )),
          ActionMenu(MenuMeta(
            router: MenuAction.enter.route,
            icon: CupertinoIcons.text_append,
            label: '选择',
          )),

          ActionMenu(MenuMeta(
            router: MenuAction.edit.route,
            icon: CupertinoIcons.pencil_circle,
            label: '修改',
          )),
          ActionMenu(MenuMeta(
            router: MenuAction.delete.route,
            icon: CupertinoIcons.delete,
            label: '删除',
          )),
          // ActionMenu(MenuMeta(
          //     router: MenuAction.clear.route, label: TIM_t("清除消息"), icon: Icons.clear_all)),
          // ActionMenu(MenuMeta(
          //   router: MenuAction.pinned.route,
          //   icon: isPinned ? Icons.vertical_align_bottom : Icons.vertical_align_top,
          //   label: isPinned ? TIM_t("取消置顶") : TIM_t("置顶"),
          // )),
          // // if (PlatformUtils().isMacOS) //SDK 目前Mac 测试通过
          //   ActionMenu(MenuMeta(
          //     router: MenuAction.markUnRead.route,
          //     icon: isMarkUnRead ? Icons.mark_chat_read_outlined : Icons.mark_chat_unread_outlined,
          //     label: isMarkUnRead || conversation.unreadCount != 0 ? TIM_t("标记已读") : TIM_t("标记未读"),
          //   )),
          // ActionMenu(MenuMeta(
          //     router: MenuAction.delete.route, label: TIM_t("删除会话"), icon: Icons.delete_outline)),
        ],
        // width: 140,
        childBuilder: _childBuilder,
      ),
    );
  }

  int timeRecord = 0;

  Widget _childBuilder(_, PopoverController ctrl, __) {
    this.ctrl = ctrl;

    return GestureDetector(
      onTap: widget.onTap,
      onTapDown: (detail) {
        print("=======onTapDown============");
        // _onShowMenu(detail.localPosition, ctrl);
      },
      onSecondaryLongPressDown: (detail) => _onShowMenu(detail.localPosition, ctrl),
      onSecondaryTapDown: (detail) => _onShowMenu(detail.localPosition, ctrl),
      child: widget.child,
    );
  }

  void _onShowMenu(Offset position, PopoverController ctrl) async {
    int cur = DateTime.now().millisecondsSinceEpoch;
    int dt = cur - timeRecord;
    if (dt < 200) {
      return;
    }
    if (ctrl.isOpen) {
      ctrl.close();
      await Future.delayed(const Duration(milliseconds: 200));
    }
    ctrl.open(position: position);
    timeRecord = cur;
  }

  void onSelect(MenuMeta menu) async {
    MenuAction action = MenuAction.values.singleWhere((e) => e.route == menu.router);
    widget.onMenuAction(action);
  }
}
