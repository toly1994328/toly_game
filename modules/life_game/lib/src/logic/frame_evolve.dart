// Copyright 2014 The 张风捷特烈 . All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// Author:      张风捷特烈
// CreateTime:  2024-07-09
// Contact Me:  1981462002@qq.com

import 'package:flutter/cupertino.dart';

import '../model/evolve.dart';
import '../view/action_toolbar.dart';
import 'frame.dart';

enum EvolveStatus {
  evolving,
  stopped,
}

class FrameEvolve with ChangeNotifier {
  EvolveSpeed _speed = EvolveSpeed.initial;

  EvolveSpeed get speed => _speed;

  set speed(EvolveSpeed value) {
    _speed = value;
    notifyListeners();
  }

  EvolveStatus _status = EvolveStatus.stopped;

  EvolveStatus get status => _status;

  set status(EvolveStatus value) {
    _status = value;
    notifyListeners();
  }

  int _generationCount = 1;

  int get generationCount => _generationCount;

  set generationCount(int value) {
    _generationCount = value;
    notifyListeners();
  }

  bool get seeWorld => _selectedActionMap[ToolAction.see] ?? false;
  bool get paintMode => _selectedActionMap[ToolAction.paint] ?? false;
  bool get moveMode => _selectedActionMap[ToolAction.move] ?? false;
  bool get deleteMode => _selectedActionMap[ToolAction.eraser] ?? false;

  List<ToolAction> get actions => _selectedActionMap.keys.toList();

  final Map<ToolAction, bool> _selectedActionMap = {
    ToolAction.see : true,
    ToolAction.move : true,
  };

  void handleAction(ToolAction action) {
    switch (action) {
      case ToolAction.see:
        _toggleAndRemove(action);
        break;
      case ToolAction.paint:
        _toggleAndRemove(action, [ToolAction.eraser, ToolAction.move]);
        break;
      case ToolAction.eraser:
        _toggleAndRemove(action, [ToolAction.paint, ToolAction.move]);
        break;
      case ToolAction.move:
        _toggleAndRemove(action, [ToolAction.eraser, ToolAction.paint]);
        break;
      case ToolAction.save:
        _toggleAndRemove(action,[ToolAction.list]);
        break;
      case ToolAction.list:
        _toggleAndRemove(action,[ToolAction.save]);
        break;
      default:
    }
    notifyListeners();
  }

  /// [action] 激活时，需要取消激活 [removeList]
  /// 比如: 画笔激活时，需要取消激活 [移动] 和 [橡皮擦]
  void _toggleAndRemove(ToolAction action, [List<ToolAction>? removeList]) {
    bool select = _selectedActionMap[action] ?? false;
    if (select) {
      _selectedActionMap.remove(action);
    } else {
      _selectedActionMap[action] = true;
      removeList?.forEach(_selectedActionMap.remove);
    }
  }

  late Frame frame;
  int _timeRecord = 0;

  FrameEvolve() {
    reset();
  }

  void reset() {
    frame = Frame();
    generationCount = 1;
    status = EvolveStatus.stopped;
    _timeRecord = 0;
  }

  void clear() {
    reset();
    frame.clear();
  }

  void evolve([ValueChanged<Frame>? onEvolved]) {
    int cur = DateTime.now().millisecondsSinceEpoch;
    bool timeSkip = cur - _timeRecord < _speed.time;
    bool evolving = status == EvolveStatus.evolving;
    if (timeSkip && evolving) return;
    frame.evolve();
    onEvolved?.call(frame);
    _generationCount++;
    notifyListeners();
    _timeRecord = DateTime.now().millisecondsSinceEpoch;
  }
}
