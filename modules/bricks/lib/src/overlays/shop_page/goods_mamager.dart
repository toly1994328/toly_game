import 'dart:convert';

import 'package:flutter/services.dart';

import 'goods.dart';

class GoodsManager {
  List<Goods> _goods = [];
  Goods? showMenuGoods;


  List<Goods> goods(GoodsType type) =>
      _goods.where((e) => e.type == type).toList();

  Future<void> loadGoods() async {
    String goodsStr = await rootBundle.loadString('packages/bricks/assets/data/goods.json');
    List data = jsonDecode(goodsStr) as List;
    _goods = data.map(Goods.fromMap).toList();
  }
}

