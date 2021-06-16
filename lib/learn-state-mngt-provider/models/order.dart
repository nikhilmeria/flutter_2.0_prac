import 'package:coffee_shop_ui/learn-state-mngt-provider/models/cart.dart';
import 'package:flutter/cupertino.dart';

class Order {
  String? id;
  double? total;
  DateTime? dateAndTime;
  List<Cart>? products;

  Order({
    @required this.id,
    @required this.total,
    @required this.dateAndTime,
    @required this.products,
  });
}
