
import '../overlays/shop_page/goods.dart';

class BuyGoods {
  final Goods goods;
  final int count;

  BuyGoods({
   required this.goods,
   required this.count,
  });

  factory BuyGoods.fromMap(dynamic map) {
    return BuyGoods(
      count: map['count'] ?? 0,
      goods: Goods.fromMap(map['goods']),
    );
  }

  Map<String, dynamic> toJson() => {
    'goods': goods,
    'count': count,
  };
}
