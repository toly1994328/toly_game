import 'package:sqflite/sqflite.dart';
import '../../bean/world.dart';
import 'frame_store.dart';

class FrameDao implements FrameStore {
  final Database database;

  FrameDao(this.database);

  @override
  Future<int> insert(FramePo frame) {
    return database.insert('frame', frame.toJson());
  }

  @override
  Future<int> deleteById(String? id) {
    return database.rawDelete('DELETE FROM frame WHERE uuid = ?',[id]);
  }

  @override
  Future<List<FramePo>> query({FrameQueryArgs args = const FrameQueryArgs()}) async {
    var (sqlStr, sqlArgs) = args.parserSql;
    String sql = 'SELECT uuid,title,description,create_at,update_at FROM frame $sqlStr';
    List<Map<String, Object?>> data = await database.rawQuery(sql, sqlArgs);
    return data.map(FramePo.fromMap).toList();
  }

  @override
  Future<FramePo> queryById(String id) async{
    String sql = 'SELECT * FROM frame WHERE uuid = ? LIMIT 1';
    List<Map<String, Object?>> data = await database.rawQuery(sql, [id]);
    if(data.isNotEmpty){
      return FramePo.fromMap(data.first);
    }
    throw 'No uuid by [$id]';
  }

  @override
  Future<int> updateInfo(String id, FramePayload frame) {
    String sql = 'UPDATE frame SET title = ?, description = ? WHERE uuid = ?';
    return database.rawUpdate(sql,[frame.title,frame.description,id]);
  }

  @override
  Future<int> updateData(String id, String data) {
    String sql = 'UPDATE frame SET data = ? WHERE uuid = ?';
    return database.rawUpdate(sql,[data,id]);
  }
}
