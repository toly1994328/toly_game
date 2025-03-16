import '../../bean/world.dart';

abstract class FrameStore {
  Future<List<FramePo>> query({FrameQueryArgs args = const FrameQueryArgs()});

  Future<FramePo> queryById(String id);

  Future<int> deleteById(String? id);

  Future<int> insert(FramePo frame);

  Future<int> updateInfo(String id, FramePayload frame);

  Future<int> updateData(String id, String data);
}

class FrameQueryArgs {
  final String? title;
  final String? subtitle;
  final int page;
  final int pageSize;

  const FrameQueryArgs({
    this.title,
    this.subtitle,
    this.page = 1,
    this.pageSize = 20,
  });

  (String,List<Object?>?) get parserSql {
    String args = '';
    List<String> conditions= [];
    List<Object?>? arguments = [];
    if(title!=null){
      conditions.add('title like ?');
      arguments.add('%$title%');
    }
    if(subtitle!=null){
      conditions.add('subtitle like ?');
      arguments.add('%$subtitle%');
    }
    if(conditions.isNotEmpty){
      args = 'WHERE ';
    }
    args+=conditions.join(' AND ');
    args+= ' ORDER BY update_at DESC LIMIT ? OFFSET ?';
    arguments.add(pageSize);
    arguments.add((page-1)*pageSize);
    return (args,arguments);
  }
}

