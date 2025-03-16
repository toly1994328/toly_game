// Copyright 2014 The 张风捷特烈 . All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// Author:      张风捷特烈
// CreateTime:  2024-07-06
// Contact Me:  1981462002@qq.com

import 'dart:convert';
import 'dart:ui';

import '../view/ruler/area_range.dart';

typedef XY = (int, int);
typedef Range = ({XY min, XY max});

extension RangeCheck on Range {
  bool contains(XY point,{double cache=0}) {
    bool inXRange = point.$1 >= this.min.$1-cache && point.$1 <= this.max.$1+cache;
    bool inYRange = point.$2 >= this.min.$2-cache && point.$2 <= this.max.$2+cache;
    return inXRange && inYRange;
  }
}

class Frame {
  /// 地图数据
  Map<XY, bool> spaces = {};

  /// 拥挤度关系
  Map<XY, int> spaceValueMap = {};

  Frame() {
    reset();
  }

  int spaceValue(XY key) => spaceValueMap[key] ?? 0;

  String get store{
    Range? range = getRange();
    int minX = range?.min.$1??0;
    int minY = range?.min.$2??0;
    List<int> result =[];
    spaces.forEach((k,v){
      result.add(k.$1-minX);
      result.add(k.$2-minY);
    });
    // List<int> data = spaces.keys.map((e)=>[e.$1-minX,e.$2-minY]).toList();
    return json.encode(result);
  }

  Frame clone() {
    Frame frame = Frame();
    frame.spaces = spaces.map((k, v) => MapEntry(k, v));
    frame.spaceValueMap = spaceValueMap.map((k, v) => MapEntry(k, v));
    return frame;
  }

  Range? getRange() => _rangeOfPoints(spaces.keys);

  XY get size{
    Range? range = getRange();
    if(range==null) return (0,0);
    return (range.max.$1-range.min.$1, range.max.$2-range.min.$2);
  }

  Range? _rangeOfPoints(Iterable<XY> points) {
    if (points.isEmpty) return null;
    var (minX, minY) = points.first;
    var (maxX, maxY) = points.first;
    for (XY point in points) {
      if (point.$1 < minX) {
        minX = point.$1;
      }
      if (point.$1 > maxX) {
        maxX = point.$1;
      }
      if (point.$2 < minY) {
        minY = point.$2;
      }
      if (point.$2 > maxY) {
        maxY = point.$2;
      }
    }
    return (min: (minX, minY), max: (maxX, maxY));
  }

  void birth(XY position) {
    spaces[position] = true;
    _calcSpaceValue();
  }

  void died(XY position) {
    spaces.remove(position);
    _calcSpaceValue();
  }

  void evolve() {
    spaceValueMap.forEach(_evolveAt);
    _calcSpaceValue();
    if (spaces.isEmpty) {
      spaceValueMap.clear();
    }
  }

  void _evolveAt(XY key, int value) {
    bool live = spaces[key] == true;
    if (live) {
      bool keepAlive = (value == 2 || value == 3);
      if (!keepAlive) spaces.remove(key);
    } else {
      if (value == 3) spaces[key] = true;
    }
  }

  void _calcSpaceValue() {
    Range? range = getRange();
    if (range == null) return;
    int cache = 1;
    int startX = range.min.$1 - cache;
    int startY = range.min.$2 - cache;
    int endX = range.max.$1 + cache;
    int endY = range.max.$2 + cache;
    for (int y = startY; y <= endY; y++) {
      for (int x = startX; x <= endX; x++) {
        int count = _calculate(x, y);
        spaceValueMap[(x, y)] = count;
      }
    }
    // 每次演化完后，移除  range 之外的无用数据
    spaceValueMap.removeWhere((e,v)=>!range.contains(e,cache: cache+1));
  }

  int _calculate(int x, int y) {
    int count = 0;
    for (int i = y - 1; i <= y + 1; i++) {
      for (int j = x - 1; j <= x + 1; j++) {
        if ((x, y) == (j, i)) continue;
        if (spaces[(j, i)] == true) count++;
      }
    }
    return count;
  }

  void reset() {
    spaces = {};
    _calcSpaceValue();
  }

  void clear() {
    spaces.clear();
    spaceValueMap.clear();
  }

  void setData(List<XY> points) {
    clear();
    for(XY point in points){
      spaces[point] = true;
    }
    _calcSpaceValue();
  }
}
