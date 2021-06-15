import 'package:flutter/cupertino.dart';

class Order {
  String? id;
  String? title;
  int? quantity;
  double? price;

  Order({
    @required this.id,
    @required this.title,
    @required this.quantity,
    @required this.price,
  });
}
