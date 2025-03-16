import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tolyui/basic/basic.dart';

import '../../storage/bean/world.dart';
import '../../storage/game_life_storage.dart';
import 'delete_alert_dialog.dart';
import 'menu_tools_wrapper.dart';

typedef OnMenuAction<T, E> = Future<bool> Function(T action, E item);

class ListFramePanel extends StatefulWidget {
  final OnMenuAction<MenuAction, FramePo?> onMenuAction;
  final ValueNotifier<String?> activeFrame;

  const ListFramePanel({
    super.key,
    required this.onMenuAction,
    required this.activeFrame,
  });

  @override
  State<ListFramePanel> createState() => _ListFramePanelState();
}

class _ListFramePanelState extends State<ListFramePanel> {
  List<FramePo>? data;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Widget buildPanel(BuildContext context) {
    if (data == null) return Center(child: CupertinoActivityIndicator());

    return ValueListenableBuilder(
      valueListenable: widget.activeFrame,
      builder: (BuildContext context, String? value, Widget? child) {
        return ListView.separated(
          separatorBuilder: (_, __) => Divider(
            height: 0.1,
          ),
          itemBuilder: (_, index) => MenuToolsWrapper<FramePo>(
            onMenuAction: (a) => _onMenuAction(a, data![index]),
            data: data![index],
            child: ListTile(
              splashColor: Colors.transparent,
              onTap: () {
                widget.onMenuAction(MenuAction.enter, data![index]);

              },
              selected: data![index].uuid==value,
              selectedColor: Colors.white,
              selectedTileColor: Color(0xff2d4066),
              dense: true,
              title: Text(
                data![index].title,
                style: TextStyle(fontSize: 12),
              ),
              subtitle: Text(
                data![index].description,
                style: TextStyle(fontSize: 12),
              ),
            ),
          ),
          itemCount: data!.length,
        );
      },

    );
  }

  void _loadData() async {
    data = await GameLifeStorage().frameStore.query();
    setState(() {});
  }

  void _onMenuAction(MenuAction value, FramePo frame) async {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    if (value == MenuAction.delete) {
      String msg = "删除记录后，数据将永久丢失，是否确定删除!";
      showDialog(
          context: context,
          builder: (ctx) => Dialog(
                elevation: 0,
                backgroundColor: isDark ? Color(0xff292a2d) : Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                child: DeleteAlertDialog(
                  title: '删除记录',
                  conformText: '确定',
                  msg: msg,
                  defaultInput: '',
                  task: (_, name) async {
                    bool success = await widget.onMenuAction(value, frame);
                    if (success) {
                      Navigator.of(ctx).pop();
                      _loadData();
                    }
                  },
                ),
              ));
    }

    if (value == MenuAction.newFrame) {
      bool success = await widget.onMenuAction(value, null);
      if (success) {
        _loadData();
      }
    }
    if (value == MenuAction.copyFrame) {
      bool success = await widget.onMenuAction(value, frame);
      if (success) {
        _loadData();
      }
    }
    if (value == MenuAction.enter||value == MenuAction.edit) {
    widget.onMenuAction(value, frame);

    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // const SizedBox(width: 6),
              Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Text(
                  '记录列表',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ),
              Spacer(),
              TolyAction(
                style: ActionStyle.dark(
                    backgroundColor: Color(0xff36343b), padding: EdgeInsets.all(2)),
                child: Icon(
                  CupertinoIcons.add,
                  size: 18,
                ),
                onTap: () async {
                  bool success = await widget.onMenuAction(MenuAction.newFrame, null);
                  if (success) {
                    _loadData();
                  }
                },
              )
            ],
          ),
        ),
        Divider(
          height: 0.5,
        ),
        Expanded(child: buildPanel(context))
      ],
    );
  }
}
