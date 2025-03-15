import 'package:path/path.dart' as path;

enum CellType {
  value0('images/type0.svg'),
  value1('images/type1.svg'),
  value2('images/type2.svg'),
  value3('images/type3.svg'),
  value4('images/type4.svg'),
  value5('images/type5.svg'),
  value6('images/type6.svg'),
  value7('images/type7.svg'),
  value8('images/type8.svg'),
  mine('images/mine.svg');
  final String src;
  const CellType(this.src);

  String get key => path.basename(src);
}

enum MarkType{
  flag('images/flag.svg');

  final String src;

  const MarkType(this.src);

  String get key => path.basename(src);
}

enum DigitalType{
  d0('images/d0.svg'),
  d1('images/d1.svg'),
  d2('images/d2.svg'),
  d3('images/d3.svg'),
  d4('images/d4.svg'),
  d5('images/d5.svg'),
  d6('images/d6.svg'),
  d7('images/d7.svg'),
  d8('images/d8.svg'),
  d9('images/d9.svg');

  final String src;

  const DigitalType(this.src);

  String get key => path.basename(src);
}

enum FaceType {
  active('images/face_active.svg'),
  lose('images/face_lose.svg'),
  common('images/face.svg')
  ;

  final String src;

  const FaceType(this.src);

  String get key => path.basename(src);
}

