import 'package:coffee_shop_ui/learn-state-mngt-provider/models/cart.dart';
import 'package:coffee_shop_ui/learn-state-mngt-provider/models/order.dart';
import 'package:flutter/cupertino.dart';

class OrderProvider with ChangeNotifier {
  List<Order> _orderItem = [];

  List<Order> get orderItem {
    return [..._orderItem];
  }

  void addOrder(List<Cart> cartItems, double total) {
    _orderItem.insert(
        0,
        Order(
          id: DateTime.now().toString(),
          total: total,
          dateAndTime: DateTime.now(),
          products: cartItems,
        ));
    notifyListeners();
  }
}
