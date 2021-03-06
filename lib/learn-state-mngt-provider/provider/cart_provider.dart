import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee_shop_ui/learn-state-mngt-provider/models/cart.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

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
    double total = 0.0;
    _cartItem?.forEach((key, value) {
      print("getTotal  values => ${value.price} ");
      total += value.price! * value.quantity!;
    });

    return double.parse(total.toStringAsFixed(2)); //round a double to 2 digit
  }

  Future<void> addItemToCartDB(String userId, String prodId, double price,
      String title, int quantity) async {
    //chk if the item being add, is already in the cart, if yes than we just increment the quantity count and dnt add a new item in the cart.
    String cartDBId = "";
    var oldQuantity;
    print(
        "addItemToCart => $prodId = $price = $title = $quantity & length = ${_cartItem!.length}");

    if (_cartItem!.containsKey(prodId)) {
      //we already hv the item in cart .than just update the quantity
      print("addItemToCart in if length => ${_cartItem!.length}");

      _cartItem!.forEach((key, value) {
        print("id chk => $key = ${value.id}");
        if (prodId == key) {
          cartDBId = value.id!;
          oldQuantity = value.quantity!;
        }
      });

      print("cartDBId & oldQuantity  => $cartDBId = $oldQuantity");

      try {
        await FirebaseFirestore.instance
            .collection('Users')
            .doc(userId)
            .collection("Cart")
            .doc(cartDBId)
            .update({
          'quantity': oldQuantity + quantity,
        });

        // updating cart entry in local app state
        _cartItem?.update(
          prodId,
          (existingValueOfTheKey) => Cart(
            id: existingValueOfTheKey.id,
            title: existingValueOfTheKey.title,
            quantity: existingValueOfTheKey.quantity! + quantity,
            price: existingValueOfTheKey.price!,
          ),
        );
        notifyListeners();
      } catch (err) {
        print("Error while updating product in cartDB => ${err.toString()}");
        throw err;
      }
    } else {
      // adding first  product  to cart DB
      try {
        await FirebaseFirestore.instance
            .collection('Users')
            .doc(userId)
            .collection("Cart")
            .add({
          "product": prodId,
          "price": price,
          "title": title,
          "quantity": quantity,
        });

        notifyListeners();
      } catch (err) {
        print("Error while adding product to cart => ${err.toString()}");
        throw err;
      }
    }
  } // addItemToCartDB

  Future<void> fetchProductsFromCartDB(String uid) async {
    try {
      QuerySnapshot<Map<String, dynamic>> fetchProducts =
          await FirebaseFirestore.instance
              .collection("Users")
              .doc(uid)
              .collection("Cart")
              .get();

      if (fetchProducts.size == 0) {
        //We hv no products in the Cart DB.
        print("no products in cart db");
        _cartItem = {};
        notifyListeners();
      } else {
        print("products found in cart db");
        fetchProducts.docs.forEach((ei) {
          _cartItem!.putIfAbsent(
              ei.data()['product'],
              () => Cart(
                    id: ei.id,
                    title: ei.data()["title"],
                    quantity: ei.data()["quantity"],
                    price: ei.data()["price"],
                  ));
        });
        notifyListeners();
      }
    } catch (err) {
      print("Error in fetchProductsFromCartDB => ${err.toString()}");
      throw err;
    }
  } //fetchProductsFromCartDB

  Future<void> removeSingleItemFromCart(String userId, String prodId) async {
    // first remove item from cart DB
    var cartDBId;
    _cartItem!.forEach((key, value) {
      print("id in remove => $key = ${value.id}");
      if (prodId == key) {
        cartDBId = value.id!;
      }
    });
    print("removeSingleItemFromCart cartDBId  => $cartDBId ");

    try {
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(userId)
          .collection("Cart")
          .doc(cartDBId)
          .delete();

      // than remove from local app state
      _cartItem?.remove(prodId);
      notifyListeners();
    } catch (err) {
      print("Error while deleting product in cartDB => ${err.toString()}");
      throw err;
    }
  } //removeSingleItemFromCart

  //this fn is used in orders section
  Future<void> removeAllItemsFromCart(String userId) async {
    try {
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(userId)
          .collection("Cart")
          .get()
          .then((querySnapshot) {
        querySnapshot.docs.forEach((ei) {
          ei.reference.delete();
        });
        print("delete all items in cart db done !!!");
        notifyListeners();
      });
    } catch (err) {
      print("Error while deleting all product in cartDB => ${err.toString()}");
      throw err;
    }
  } //removeAllItemsFromCart

  void get clearCart {
    _cartItem = {};
    notifyListeners();
  } // clear the cart after an order has been placed.
}
