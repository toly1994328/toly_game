enum GoodsType {
  paddle, /// 挡板
  rune, /// 符文
  function, // 功能道具
}

class Goods {
  final String title; // 标题
  final String desc; // 描述
  final String src; // 资源图片
  final GoodsType type; // 类型
  final int? coin; // 所需金币
  final int? crystal; // 所需水晶

  const Goods({
    required this.title,
    required this.src,
    required this.type,
    required this.desc,
    required this.coin,
    required this.crystal,
  });

  factory Goods.fromMap(dynamic map) {
    return Goods(
        title: map['title'],
        src: map['src'],
        desc: map['desc'],
        coin: map['coin'],
        crystal: map['crystal'],
        type: GoodsType.values[map['type']]);
  }

  Map<String, dynamic> toJson() => {
        "title": title,
        "desc": desc,
        "type": type.index,
        "src": src,
        "coin": coin,
        "crystal": crystal,
      };
}
