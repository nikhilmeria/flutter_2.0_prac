import 'dart:convert';

import 'package:coffee_shop_ui/learn-state-mngt-provider/models/cart.dart';
import 'package:coffee_shop_ui/learn-state-mngt-provider/models/order.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class OrderProvider with ChangeNotifier {
  List<Order> _orderItem = [];

  List<Order> get orderItem {
    return [..._orderItem];
  }

  double get getOrderTotal {
    double tempTotal = 0.0;
    _orderItem.forEach((ei) {
      tempTotal += ei.total!;
    });
    return double.parse(tempTotal.toStringAsFixed(2)); //1
  }

  Future<void> addOrderToDB(List<Cart> cartItems, double total) async {
    // adding new order to firebase database
    final url = Uri.parse(
        "https://we2-cowax-default-rtdb.asia-southeast1.firebasedatabase.app/orders.json");
    final timeStamp = DateTime.now();

    try {
      await http.post(
        url,
        body: json.encode(
          {
            "total": total,
            " dateAndTime": timeStamp.toIso8601String(),
            "products": cartItems
                .map((ei) => {
                      "id": ei.id,
                      "price": ei.price,
                      "quantity": ei.quantity,
                      "title": ei.title,
                    })
                .toList(),
          },
        ),
      );

      notifyListeners();
      //
    } catch (err) {
      print("Error in addOrder  => ${err.toString()}");
      throw err;
    }
  } //addOrder

  Future<void> fetchOrderData() async {
    // users wants to see past orders, than we can fetch it from order db.

    //following code will be used to add update local app state.
    //  _orderItem.insert(
    //       0,
    //       Order(
    //         id: json.decode(resp.body)['name'],
    //         total: total,
    //         dateAndTime: timeStamp,
    //         products: cartItems,
    //       ));

    notifyListeners();
  } //fetchOrderData
}

//1. "toStringAsFixed" sets 2 decimal places to a double.
