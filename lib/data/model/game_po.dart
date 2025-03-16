class GamePo {
  final String title;
  final String id;
  final String image;
  final String? github;
  final String? article;
  final String createAt;

  GamePo( {
    required this.title,
    required this.id,
    required this.image,
    required this.createAt,
     this.github,
     this.article,
  });

  factory GamePo.fromMap(dynamic map) {
    return GamePo(
      title: map['title'] ?? '',
      id: map['id'] ?? '',
      image: map['image'] ?? '',
      createAt: map['create_at'] ?? '',
      article: map['article'],
      github: map['github'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'id': id,
      'image': image,
      'article': article,
      'github': github,
      'create_at': createAt,
    };
  }
}