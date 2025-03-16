import 'package:uuid/uuid.dart';

class FramePayload {
  final String title;
  final String description;

  FramePayload({required this.title, required this.description});
}

class FramePo {
  final String uuid;
  final String data;
  final String title;
  final String description;
  final int createAt;
  final int updateAt;

  const FramePo({
    required this.uuid,
    required this.data,
    required this.title,
    required this.description,
    required this.createAt,
    required this.updateAt,
  });


  factory FramePo.fromMap(dynamic map) {
    return FramePo(
      uuid: map['uuid'],
      data: map['data']??'[]',
      title: map['title'],
      description: map['description'],
      createAt: map['create_at'],
      updateAt: map['update_at'],
    );
  }

  factory FramePo.insert() {
    String uuid = const Uuid().v4();
    int time = DateTime.now().millisecondsSinceEpoch;
    return FramePo(
      uuid: uuid,
      data: '[]',
      title: 'untitled',
      description: '新建记录...',
      createAt: time,
      updateAt: time,
    );
  }

  Map<String, dynamic> toJson() => {
        "uuid": uuid,
        "data": data,
        "title": title,
        "description": description,
        "create_at": createAt,
        "update_at": updateAt,
      };
}
