import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:path/path.dart' as p;

import 'interface.dart';

mixin DbOpenMixin on DbStore {
  Database? _database;

  Database get database => _database!;

  @override
  Future<String> get dbpath async {
    return p.join(await databasePath, dbname);
  }

  String get dbname;

  Future<void> open() async {
    if (kIsWeb) return;
    beforeOpen();
    String dbPath = await dbpath;
    _database = await openDatabase(
      dbPath,
      version: version,
      onCreate: onCreate,
      onUpgrade: onUpgrade,
      onOpen: onOpen,
    );
    afterOpen(dbPath);
  }

  Future<String> get databasePath async {
    Directory docDir = await getApplicationSupportDirectory();
    String dirPath;

    if (Platform.isWindows || Platform.isLinux) {
      dirPath = p.join(docDir.path, 'databases');
    } else {
      dirPath = await getDatabasesPath();
    }

    Directory result = Directory(dirPath);
    if (!result.existsSync()) {
      result.createSync(recursive: true);
    }
    return dirPath;
  }

  void afterOpen(String dbpath) {}

  void beforeOpen() {
    if (Platform.isWindows || Platform.isLinux) {
      sqfliteFfiInit();
      databaseFactory = databaseFactoryFfi;
    }
  }
  @override
  FutureOr<void> onOpen(Database db) {}

  @override
  FutureOr<void> onUpgrade(Database db, int oldVersion, int newVersion) {}

  @override
  Future<void> close() async {
    await _database?.close();
  }
}
