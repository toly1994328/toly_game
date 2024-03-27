import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:path/path.dart' as path;
import 'package:toly_game/bricks/05/model/level.dart';

////    tiles: [
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

void main() {
  // List<int> line = formLine(9);
  List<Level> levels = [];

  for (int i = 0; i < 30; i++) {
    levels.add(gen(i+1));
  }
  String data = json.encode(levels);
  String filePath = path.join(Directory.current.path,'assets','data','bricks_levels.json');
  File(filePath).writeAsString(data);
}

Random random = Random(100);

List<int> formLine(int count) {
  List<int> line = [];
  int half = count ~/ 2;
  for (int i = 0; i <= half; i++) {
    line.add(random.nextInt(2));
  }
  line.addAll(line.sublist(0, half).reversed);
  return line;
}

Level gen(int index) {
  List<List<int>> tiles = [];
  for (int i = 0; i < 10; i++) {
    tiles.add(formLine(9));
  }
  return Level(
    id: index,
    tiles: tiles,
    ballSpeed: 350 + 10.0 * index,
  );
}
