import 'dart:convert';

import 'package:coffee_shop_ui/learn-state-mngt-provider/models/cart.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class CartProvider with ChangeNotifier {
  Map<String, Cart>? _cartItem = {};
  Map<String, dynamic>? fetchProducts;

  Map<String, Cart> get cartItem {
    return {..._cartItem!};
  }

  int get cartCount {
    // getter to find no of products in the cart
    return _cartItem!.length;
  }

  double get getTotal {
    double total = 0.0;
    _cartItem?.forEach((key, value) {
      print("getTotal  values => ${value.price} ");
      total += value.price!;
    });

    return double.parse(total.toStringAsFixed(2)); //round a double to 2 digit
  }

  Future<void> addItemToCartDB(
      String prodId, double price, String title, int quantity) async {
    //chk if the item being add, is already in the cart, if yes than we just increment the quantity count and dnt add a new item in the cart.
    String cartItemID = "";

    if (fetchProducts?.length != 0) {
      fetchProducts?.forEach((key, value) {
        print("test  => $key  and $value ");
        if (value["id"] == key) {
          cartItemID = key;
        }
        print("cartItemID => $key  and $cartItemID ");
      });
    }

    if (_cartItem!.containsKey(prodId)) {
      //we already hv the item in cart .than just update the quantity
      print("addItemToCart in if length => ${_cartItem!.length}");

      final url = Uri.parse(
          "https://we2-cowax-default-rtdb.asia-southeast1.firebasedatabase.app/cart.json");

      try {
        final resp = await http.put(
          url,
          body: json.encode({
            "product": prodId,
            "price": price,
            "title": title,
            "quantity": quantity,
          }),
        );

        print("addItemToCartDB if resp => $resp");
      } catch (err) {
        print("Error while adding product to cart => ${err.toString()}");
        throw err;
      }
      // _cartItem?.update(
      //   prodId,
      //   (existingValueOfTheKey) => Cart(
      //     id: existingValueOfTheKey.id,
      //     title: existingValueOfTheKey.title,
      //     quantity: existingValueOfTheKey.quantity! + quantity,
      //     price: existingValueOfTheKey.price! + (price * quantity),
      //   ),
      // );
    } else {
      // first add product to cart DB
      final url = Uri.parse(
          "https://we2-cowax-default-rtdb.asia-southeast1.firebasedatabase.app/cart.json");

      try {
        final resp = await http.post(
          url,
          body: json.encode({
            "product": prodId,
            "price": price,
            "title": title,
            "quantity": quantity,
          }),
        );

        print("addItemToCartDB resp => $resp");

        //add new entry in the cart for internal use.
        // _cartItem?.putIfAbsent(
        //   prodId,
        //   () => Cart(
        //     id: DateTime.now().toString(),
        //     title: title,
        //     price: price,
        //     quantity: quantity,
        //   ),
        // );
      } catch (err) {
        print("Error while adding product to cart => ${err.toString()}");
        throw err;
      }
    }

    notifyListeners();
  } // addItemToCartDB

  Future<void> fetchProductsFromCartDB() async {
    try {
      final url = Uri.parse(
          "https://we2-cowax-default-rtdb.asia-southeast1.firebasedatabase.app/cart.json");

      final resp = await http.get(url);
      fetchProducts = json.decode(resp.body);

      if (fetchProducts == null) {
        //We hv no products in the Cart DB.
        print("no products in cart db");
        _cartItem = {};
        notifyListeners();
      } else {
        print("products found in cart db");
        fetchProducts!.forEach((key, value) {
          print("fetchProducts => $key = $value");
          _cartItem!.putIfAbsent(
              value["product"],
              () => Cart(
                    id: value["product"],
                    title: value["title"],
                    quantity: value["quantity"],
                    price: value["price"],
                  ));
        });

        _cartItem!.forEach((key, value) {
          print("_cartItem from Cart DB => $key = ${value.id}");
        });

        notifyListeners();
      }
    } catch (err) {
      print("Error in fetchProductsFromCartDB => ${err.toString()}");
      throw err;
    }
  } //fetchProductsFromCartDB

  void removeItemFromCart(String prodId) {
    _cartItem?.remove(prodId);
    notifyListeners();
  }

  void get clearCart {
    _cartItem = {};
    notifyListeners();
  } // clear the cart after an order has been placed.
}
