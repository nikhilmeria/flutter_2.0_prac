import 'dart:convert';

import 'package:coffee_shop_ui/learn-state-mngt-provider/models/product.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class ProductProvider with ChangeNotifier {
  List<Product> _products = [];

  List<Product> get products {
    return [..._products];
  }

  Future<void> fetchProductsFromDB() async {
    try {
      final url = Uri.parse(
          "https://we2-cowax-default-rtdb.asia-southeast1.firebasedatabase.app/products.json");

      final resp = await http.get(url);
      Map<String, dynamic>? fetchProducts = json.decode(resp.body);
      //  final fetchProducts = json.decode(resp.body);
      final List<Product> tempList = [];

      if (fetchProducts == null) {
        //We hv no products in the DB.
        _products = [];
        notifyListeners();
      } else {
        // final fetchProducts = json.decode(resp.body) as Map<String, dynamic>;
        fetchProducts.forEach((key, value) {
          tempList.add(Product(
            id: key,
            title: value['title'],
            description: value['description'],
            price: value[' price'],
            imageUrl: value['imageUrl'],
          ));
        });
        _products = tempList;
        notifyListeners();
      }
      //
    } catch (err) {
      print("Error in fetchProductsFromDB => ${err.toString()}");
      throw err;
    }
  }

  Future<void> addProduct(Product recdProduct) async {
    // adding new product to firebase database
    final url = Uri.parse(
        "https://we2-cowax-default-rtdb.asia-southeast1.firebasedatabase.app/products.json");

    try {
      final resp = await http.post(
        url,
        body: json.encode(
          {
            "title": recdProduct.title,
            "description": recdProduct.description,
            " price": recdProduct.price,
            "imageUrl": recdProduct.imageUrl,
          },
        ),
      );
      print("addProduct resp => ${resp.body}");
      Product newProduct = Product(
        id: json.decode(resp.body)["name"],
        title: recdProduct.title,
        description: recdProduct.description,
        price: recdProduct.price,
        imageUrl: recdProduct.imageUrl,
      );

      _products.add(newProduct);
      notifyListeners();
      //
    } catch (err) {
      print("Error in post => ${err.toString()}");
      throw err;
    }
  }

  void deleteProduct(String productId) {
    _products.removeWhere((ei) => ei.id == productId);
    notifyListeners();
  }

  Product findById(String id) {
    return products.firstWhere((ei) => ei.id == id);
  }

  //fn to toggle favorite status
  // void toggleFavoriteStatus(String id) {
  //   findById(id).isFavorite = !findById(id).isFavorite;
  //   notifyListeners();
  // }
}

//
//1. 4 is used bcoz not able to do null chk & "resp.body.length" returns the value of 4
