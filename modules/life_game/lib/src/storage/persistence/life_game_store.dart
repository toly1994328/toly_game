import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import '../bean/world.dart';
import '../database/database.dart';
import 'frame/frame_dao.dart';
import 'frame/frame_store.dart';


class LifeGameDbStore extends DbStore with DbOpenMixin {
  late FrameDao _frameDao;

  FrameStore get frameStore => _frameDao;

  @override
  String get dbname => 'life_game_store.db';

  @override
  int get version => 1;

  @override
  Future<void> onCreate(Database db, int version) async {
    await db.execute('''
CREATE TABLE frame (
  uuid TEXT NOT NULL,
  data TEXT NOT NULL,
  title TEXT NOT NULL,
  description TEXT,
  create_at INTEGER NOT NULL,
  update_at INTEGER NOT NULL,
  PRIMARY KEY("uuid")
);

CREATE INDEX idx_frames_title ON frame(title);
CREATE INDEX idx_frames_description ON frame(description);
''');
  }

  @override
  void afterOpen(String dbpath) {
    super.afterOpen(dbpath);
    _frameDao = FrameDao(database);
    print("====Opend:$dbpath===========");
  }
}
