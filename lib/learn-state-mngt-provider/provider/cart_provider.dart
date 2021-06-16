import 'package:coffee_shop_ui/learn-state-mngt-provider/models/cart.dart';
import 'package:flutter/cupertino.dart';

class CartProvider with ChangeNotifier {
  Map<String, Cart>? _cartItem = {};

  Map<String, Cart> get cartItem {
    return {..._cartItem!};
  }

  int get cartCount {
    // getter to find no of products in the cart
    return _cartItem!.length;
  }

  double get getTotal {
    var total = 0.0;
    _cartItem?.forEach((key, value) {
      print("getTotal  values => ${value.price} ");
      total += value.price! * value.quantity!;
    });

    return total;
  }

  void addItemToCart(String prodId, double price, String title) {
    //chk if the item being add, is already in the cart, if yes than we just increment the quantity count and dnt add a new item in the cart.

    if (_cartItem!.containsKey(prodId)) {
      //we already hv the item in cart .than just update the quantity
      _cartItem?.update(
        prodId,
        (existingValueOfTheKey) => Cart(
          id: existingValueOfTheKey.id,
          title: existingValueOfTheKey.title,
          quantity: existingValueOfTheKey.quantity! + 1,
          price: existingValueOfTheKey.price,
        ),
      );
    } else {
      //add new entry in the cart
      _cartItem?.putIfAbsent(
        prodId,
        () => Cart(
          id: DateTime.now().toString(),
          title: title,
          price: price,
          quantity: 1,
        ),
      );
      _cartItem?.forEach((key, value) {
        print("add keys => $key ");
        print("add  values => ${value.title} ");
      });
    }

    notifyListeners();
  }

  void removeItemFromCart(String prodId) {
    _cartItem?.remove(prodId);
    notifyListeners();
  }

  void get clearCart {
    _cartItem = {};
    notifyListeners();
  } // clear the cart after an order has been placed.
}
