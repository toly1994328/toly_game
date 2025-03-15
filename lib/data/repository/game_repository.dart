import 'dart:convert';

import 'package:flutter/services.dart';

import '../data.dart';

class GameRepository {
  Future<List<GamePo>> queryGame() async {
    String data = await rootBundle.loadString("assets/data/game.json");

    return jsonDecode(data).map<GamePo>(GamePo.fromMap).toList();
  }
}
