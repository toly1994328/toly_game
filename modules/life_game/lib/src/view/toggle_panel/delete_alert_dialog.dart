import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';


/// create by 张风捷特烈 on 2020-04-23
/// contact me by email 1981462002@qq.com
/// 说明:
typedef InputAsyncTask = Future<void> Function(
    BuildContext context, String value);

class DeleteAlertDialog extends StatefulWidget {
  final String title;
  final String msg;
  final String conformText;
  final InputAsyncTask task;
  final String defaultInput;

  DeleteAlertDialog({
    Key? key,
    required this.title,
    required this.msg,
    required this.task,
    required this.defaultInput,
    this.conformText = '删除',
  }) : super(key: key);

  @override
  State<DeleteAlertDialog> createState() => _DeleteAlertDialogState();
}

class _DeleteAlertDialogState extends State<DeleteAlertDialog> {
  ButtonStyle style = ElevatedButton.styleFrom(
    backgroundColor: Colors.redAccent,
    foregroundColor: Colors.white,
    elevation: 0,
    minimumSize: Size(70, 35),
    padding: EdgeInsets.zero,
    shape: const StadiumBorder(),
  );
  bool get isDark => Theme.of(context).brightness == Brightness.dark;
  ButtonStyle mobileStyle = ElevatedButton.styleFrom(
    backgroundColor: Colors.redAccent,
    foregroundColor: Colors.white,
    elevation: 0,
    minimumSize: Size(70, 35),
    padding: EdgeInsets.zero,
    shape: const StadiumBorder(),
  );

  bool isDesk =
      kIsWeb || Platform.isMacOS || Platform.isWindows || Platform.isLinux;
  final TextEditingController _nameCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return _buildDesk(context);
  }

  Widget _buildDesk(BuildContext context) {
    Color? cancelTextColor = Theme.of(context).textTheme.displayMedium?.color;
    return SizedBox(
      width: 350,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(
              Icons.warning_amber_rounded,
              color: Colors.orange,
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    widget.title,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 15,
                      bottom: 15,
                    ),
                    child: Text(
                      widget.msg,
                      style: const TextStyle(fontSize: 14),
                    ),
                  ),
                  Row(
                    children: [
                      const Spacer(),
                      OutlinedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                            minimumSize: Size(76, 34),
                            elevation: 0,
                            padding: EdgeInsets.zero,
                          ),
                          child: Text(
                            '取消',
                            style:
                                TextStyle(fontSize: 12, color: cancelTextColor),
                          )),
                      const SizedBox(
                        width: 10,
                      ),
                      AsyncButton(
                        conformText: widget.conformText,
                        task: _save,
                        style:   OutlinedButton.styleFrom(
                            elevation: 0,
                            splashFactory: NoSplash.splashFactory,
                            enableFeedback: false,
                            backgroundColor: Colors.redAccent,
                            foregroundColor: Colors.white,
                            surfaceTintColor: Colors.transparent,
                            overlayColor: Colors.black12,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                            minimumSize: Size(76, 34),
                            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8)),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMobile(BuildContext context) {
    Color? cancelTextColor = isDark
        ? Colors.white
        : Theme.of(context).textTheme.displayMedium?.color;
    _nameCtrl.text = widget.defaultInput;
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // const SizedBox(
              //   width: 10,
              // ),
              Text(
                widget.title,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 15,
              bottom: 15,
            ),
            child: Text(
              widget.msg,
              style: const TextStyle(fontSize: 14,color: Color(0xff7d7d7d)),
            ),
          ),
          TextFormField(
            controller: _nameCtrl,
            style: TextStyle(fontSize: 13),

            decoration: InputDecoration(
                filled: true,

                hoverColor: Colors.transparent,
                isDense: true,
                contentPadding: EdgeInsets.only(top: 10, left: 20,bottom: 10),
                fillColor: isDark ? Color(0xff2F3033) : Color(0xffEEEEEE),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Theme.of(context).primaryColor),
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                hintText: "输入文件夹名称",
                hintStyle: TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            children: [
              const Spacer(),
              OutlinedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                    minimumSize: Size(76, 34),
                    elevation: 0,
                    padding: EdgeInsets.zero,
                    // shape: const StadiumBorder(),
                  ),

                  child: Text(
                    '取消',
                    style: TextStyle(fontSize: 12, color: cancelTextColor),
                  )),
              const SizedBox(
                width: 10,
              ),
              AsyncButton(
                conformText: widget.conformText,
                task: _save,
                style:   OutlinedButton.styleFrom(
                  elevation: 0,
                  splashFactory: NoSplash.splashFactory,
                  enableFeedback: false,
                  backgroundColor: Color(0xff267ef0),
                  foregroundColor: Colors.white,
                  surfaceTintColor: Colors.transparent,
                  overlayColor: Colors.black12,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                  minimumSize: Size(76, 34),
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8)),
              ),
            ],
          )
        ],
      ),
    );
  }

  Future<void> _save(BuildContext context) async {
    await widget.task.call(context, _nameCtrl.text);
  }
}


typedef AsyncTask = Future<void> Function(BuildContext context);

class AsyncButton extends StatefulWidget {
  final ButtonStyle? style;
  final AsyncTask task;
  final String conformText;

  const AsyncButton({
    super.key,
    required this.task,
    this.style,
    required this.conformText,
  });

  @override
  State<AsyncButton> createState() => _AsyncButtonState();
}

class _AsyncButtonState extends State<AsyncButton> {
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: _loading ? null : _doTask,
        style: widget.style ??
            ElevatedButton.styleFrom(
                elevation: 0,
                padding: EdgeInsets.zero,
                shape: const StadiumBorder()),
        child: _loading
            ? const CupertinoActivityIndicator(radius: 8,color: Colors.white,)
            : Text(
          widget.conformText,
          style: const TextStyle(fontSize: 12, height: 1),
        ));
  }

  void _doTask() async {
    setState(() {
      _loading = true;
    });
    await widget.task(context);
    setState(() {
      _loading = false;
    });
  }
}
