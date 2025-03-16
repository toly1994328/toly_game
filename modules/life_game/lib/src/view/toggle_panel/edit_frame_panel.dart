import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tolyui/tolyui.dart';

import '../../storage/bean/world.dart';

enum SubmitType {
  add,
  update,
  cancel,
}

typedef OnSubmit<T> = Future<bool> Function(SubmitType type, T data);

class EditFramePanel extends StatefulWidget {
  final FramePo? model;
  final OnSubmit<FramePayload?> onSubmit;

  const EditFramePanel({
    Key? key,
    this.model,
    required this.onSubmit,
  }) : super(key: key);

  @override
  _EditFramePanelState createState() => _EditFramePanelState();
}

class _EditFramePanelState extends State<EditFramePanel> {
  final TextEditingController contentCtrl = TextEditingController();
  final TextEditingController titleCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    contentCtrl.text = widget.model?.description ?? '';
    titleCtrl.text = widget.model?.title ?? '';
  }

  @override
  void dispose() {
    contentCtrl.dispose();
    titleCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        AsyncDialogBar(
          onCancel: widget.model == null?null:()=>widget.onSubmit(SubmitType.cancel,null),
          title: widget.model == null ? "添加记录" : "修改记录",
          conformText: "确定",
          onConform: _onConform,
        ),
        Divider(
          height: 0.5,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
          child: CustomIconInput(
            fontSize: 12,
            height: 32,
            controller: titleCtrl,
            hintText: "输入名称...",
            icon: Icons.drive_file_rename_outline,
          ),
        ),
        const SizedBox(height: 8),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            child: CustomInputPanel(
              fontSize: 12,
              controller: contentCtrl,
              hintText: '输入描述(选填)',
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _onConform(BuildContext context) async {
    if (!checkAllow()) return;
    SubmitType type = widget.model == null ? SubmitType.add : SubmitType.update;
    bool success = await widget.onSubmit(type, FramePayload(title: titleCtrl.text, description: contentCtrl.text));
    if(success){
      // Navigator.of(context).pop();
    }
  }

  bool checkAllow() {
    if (titleCtrl.text.isEmpty) {
      $message.warning(message: "标题不能为空!");
      return false;
    }
    return true;
  }
}

class AsyncDialogBar extends StatelessWidget {
  final String conformText;
  final Widget? leading;
  final String title;
  final AsyncTask onConform;
  final VoidCallback? onCancel;
  final Color? color;

  const AsyncDialogBar({
    super.key,
    this.leading,
    this.conformText = "确定",
    this.color,
    this.onCancel,
    this.title = "添加记录",
    required this.onConform,
  });

  @override
  Widget build(BuildContext context) {
    ButtonStyle style = ElevatedButton.styleFrom(
      backgroundColor: color,
      elevation: 0,
      padding: EdgeInsets.zero,
      shape: const StadiumBorder(),
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // const SizedBox(width: 6),
          if(onCancel!=null)
            TolyAction(
                style: ActionStyle.dark(backgroundColor: Color(0xff36343b), padding: EdgeInsets.all(2)),
                onTap: onCancel,
                child: const Icon(
                  Icons.arrow_back,
                  size: 18,
                )),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              title,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            width: 30,
            height: 30,
            child: AsyncButton(
              conformText: conformText,
              task: onConform,
              style: style,
            ),
          ),
        ],
      ),
    );
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
    if (_loading) {
      return const CupertinoActivityIndicator(radius: 8);
    } else {
      return Align(
        child: TolyAction(
            style: ActionStyle.dark(backgroundColor: Color(0xff36343b), padding: EdgeInsets.all(2)),
            onTap: _doTask,
            child: const Icon(
              Icons.check,
              size: 18,
            )),
      );
    }

    // ElevatedButton(
    //   onPressed: _loading ? null : _doTask,
    //   style: widget.style??ElevatedButton.styleFrom(
    //       elevation: 0,
    //       padding: EdgeInsets.zero,
    //       shape: const StadiumBorder()),
    //   child: ;
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

class CustomInputPanel extends StatelessWidget {
  final TextEditingController controller;

  const CustomInputPanel({
    Key? key,
    required this.controller,
    this.color = Colors.lightBlue,
    this.minLines = 30,
    this.maxLines = 500,
    this.fontSize = 14,
    this.onChange,
    this.onSubmitted,
    this.hintText = "写点什么...",
  }) : super(key: key);

  final Color color; //字颜色
  final int minLines; //最小行数
  final int maxLines; //最大行数
  final double fontSize; //字号
  final String hintText; //提示字
  final ValueChanged<String>? onChange; //提交监听
  final ValueChanged<String>? onSubmitted; //提交监听

  @override
  Widget build(BuildContext context) {
    Color? backgroundColor = Theme.of(context).inputDecorationTheme.fillColor;

    // const Color backgroundColor = Colors.white;
    InputBorder border = UnderlineInputBorder(
      borderSide: BorderSide(color: backgroundColor ?? Colors.transparent),
      borderRadius: BorderRadius.circular(5),
    );
    return TextField(
      controller: controller,
      keyboardType: TextInputType.text,
      textAlign: TextAlign.start,
      minLines: minLines,
      maxLines: maxLines,
      style: TextStyle(
        fontSize: fontSize,
        // color: color,
        height: 1.2,
        // backgroundColor: Colors.white,
      ),
      decoration: InputDecoration(
        filled: true,
        hoverColor: Colors.transparent,
        fillColor: backgroundColor,
        hintText: hintText,
        hintStyle: TextStyle(fontSize: fontSize),
        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
        focusedBorder: border,
        enabledBorder: border,
      ),
      onChanged: onChange,
      onSubmitted: onSubmitted,
    );
  }
}

class CustomIconInput extends StatelessWidget {
  final TextEditingController? controller;
  final String hintText;
  final IconData icon;
  final double height;
  final double fontSize;
  final ValueChanged<String>? onChanged;

  const CustomIconInput({
    super.key,
    this.controller,
    required this.icon,
    this.onChanged,
    this.hintText = "请输入...",
    this.height = 30,
    this.fontSize = 12,
  });

  @override
  Widget build(BuildContext context) {
    Color? backgroundColor = Theme.of(context).inputDecorationTheme.fillColor;

    return TextField(
      onChanged: onChanged,
      controller: controller,
      style: TextStyle(fontSize: fontSize),
      maxLines: 1,
      decoration: InputDecoration(
          filled: true,
          hoverColor: Colors.transparent,
          isDense: true,
          contentPadding: const EdgeInsets.only(top: 10, bottom: 10, left: 12, right: 12),
          fillColor: backgroundColor,
          // prefixIcon:  Icon(icon, size: 18),
          border: const UnderlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(Radius.circular(4)),
          ),
          hintText: hintText,
          hintStyle: TextStyle(fontSize: fontSize)),
    );
  }
}
