class GamePo {
  String title;
  String id;
  String image;
  String createAt;

  GamePo({
    required this.title,
    required this.id,
    required this.image,
    required this.createAt,
  });

  factory GamePo.fromMap(dynamic map) {
    return GamePo(
      title: map['title'] ?? '',
      id: map['id'] ?? '',
      image: map['image'] ?? '',
      createAt: map['create_at'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'id': id,
      'image': image,
      'create_at': createAt,
    };
  }
}