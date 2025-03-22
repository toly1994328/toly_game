class GamePo {
  final String title;
  final String id;
  final String logo;
  final String image;
  final String? github;
  final String? article;
  final String createAt;

  String get route => '/game/$id';

  GamePo( {
    required this.title,
    required this.id,
    required this.image,
    required this.logo,
    required this.createAt,
     this.github,
     this.article,
  });

  factory GamePo.fromMap(dynamic map) {
    return GamePo(
      title: map['title'] ?? '',
      logo: map['logo'] ?? '',
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
      'logo': logo,
      'image': image,
      'article': article,
      'github': github,
      'create_at': createAt,
    };
  }
}