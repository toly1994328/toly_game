


import '../../game/model/types.dart';


List<String> get extraSvg {
  List<String> result = [
    'images/pressed.svg',
    'images/closed.svg',
    'images/flag.svg',
    'images/d0.svg',
    'images/face_pressed.svg',
    'images/mine_red.svg',
  ];
  result.addAll(CellType.values.map((e) => e.src));
  result.addAll(FaceType.values.map((e) => e.src));
  result.addAll(DigitalType.values.map((e) => e.src));

  return result;
}