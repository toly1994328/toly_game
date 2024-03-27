class Level {
  final int id;
  final List<List<int>> tiles;
  final double ballSpeed;

  const Level({
    required this.id,
    required this.tiles,
    required this.ballSpeed,
  });

  factory Level.fromMap(dynamic map) {
    List<dynamic> tilesData = map['tiles'];
    List<List<int>> tiles = [];
    for (int i = 0; i < tilesData.length; i++) {
      List<dynamic> line = tilesData[i];
      tiles.add(line.map<int>((e) => e).toList());
    }
    return Level(
      id: map['id'],
      tiles: tiles,
      ballSpeed: map['ballSpeed'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'tiles': tiles,
        'ballSpeed': ballSpeed,
      };
}

// const Map<int, Level> kLevels = {
//   0: Level(
//     id: 0,
//     tiles: [
//       [0, 0, 0, 0, 0, 0, 0, 1, 0],
//       [0, 0, 0, 0, 0, 0, 0, 0, 0],
//       [0, 0, 0, 0, 0, 0, 0, 0, 0],
//       [0, 0, 0, 0, 0, 0, 0, 0, 0],
//       [0, 0, 0, 0, 0, 0, 0, 0, 0],
//       [0, 0, 0, 0, 0, 0, 0, 0, 0],
//       [0, 0, 0, 0, 0, 0, 0, 0, 0],
//       [0, 0, 0, 0, 0, 0, 0, 0, 0],
//       [0, 0, 0, 0, 0, 0, 0, 0, 0],
//       [0, 0, 0, 0, 0, 0, 0, 0, 0],
//     ],
//     ballSpeed: 350,
//   ),
//   1: Level(
//     id: 1,
//     tiles: [
//       [0, 0, 1, 0, 1, 0, 1, 0, 0],
//       [1, 1, 0, 0, 0, 0, 0, 1, 1],
//       [0, 0, 1, 1, 1, 1, 1, 0, 0],
//       [1, 1, 0, 1, 1, 1, 0, 1, 1],
//       [0, 1, 0, 0, 0, 0, 0, 1, 0],
//       [0, 0, 0, 1, 0, 1, 0, 0, 0],
//       [0, 0, 1, 1, 1, 1, 1, 0, 0],
//       [0, 1, 1, 0, 0, 0, 1, 1, 0],
//       [1, 1, 1, 0, 1, 0, 1, 1, 1],
//       [1, 1, 1, 0, 1, 0, 1, 1, 1]
//     ],
//     ballSpeed: 350,
//   ),
//   2: Level(
//     id: 2,
//     tiles: [
//       [1, 1, 1, 1, 0, 1, 1, 1, 1],
//       [1, 1, 1, 1, 0, 1, 1, 1, 1],
//       [1, 1, 1, 1, 0, 1, 1, 1, 1],
//       [0, 1, 1, 0, 0, 1, 0, 0, 1],
//       [0, 1, 1, 0, 0, 1, 0, 0, 1],
//       [0, 1, 1, 0, 0, 1, 0, 0, 1],
//       [0, 1, 1, 0, 0, 1, 0, 0, 1],
//       [0, 1, 1, 0, 0, 1, 1, 1, 1],
//       [0, 1, 1, 0, 0, 1, 1, 1, 1],
//       [0, 1, 1, 0, 0, 1, 1, 1, 1],
//     ],
//     ballSpeed: 360,
//   ),
// };
