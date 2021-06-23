import 'dart:convert';

import 'package:coffee_shop_ui/learn-state-mngt-provider/models/product.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class ProductProvider with ChangeNotifier {
  List<Product> _products = [
    // Product(
    //   id: 'p1',
    //   title: 'Red Shirt',
    //   description: 'A red shirt - it is pretty red!',
    //   price: 29.99,
    //   imageUrl:
    //       'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    // ),
    // Product(
    //   id: 'p2',
    //   title: 'Trousers',
    //   description: 'A nice pair of trousers.',
    //   price: 59.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    // ),
    // Product(
    //   id: 'p3',
    //   title: 'Yellow Scarf',
    //   description: 'Warm and cozy - exactly what you need for the winter.',
    //   price: 19.99,
    //   imageUrl:
    //       'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    // ),
    // Product(
    //   id: 'p4',
    //   title: 'A Pan',
    //   description: 'Prepare any meal you want.',
    //   price: 49.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    // ),
  ];

  List<Product> get products {
    return [..._products];
  }

  Future<void> fetchProductsFromDB() async {
    print("Working fine .....");
    try {
      final url = Uri.parse(
          "https://we2-cowax-default-rtdb.asia-southeast1.firebasedatabase.app/products.json");

      http.Response resp = await http.get(url);
      print("Working fine again .....");
      print("fetchProductsFromDB  resp => ${resp.body.length}"); //1

      if (resp.body.length == 4) {
        print("inside if");
        _products = [];
        notifyListeners();
        return;
      } else {
        Map<String, dynamic> fetchedProducts = json.decode(resp.body);
        fetchedProducts.values.forEach((ei) {
          print("my data 1 => $ei");
        });
        List<Product> tempList = [];

        fetchedProducts.forEach((key, value) {
          print("my data 2 => $value");
          tempList.add(Product(
            id: key,
            title: value['title'],
            description: value['description'],
            price: value['price'],
            imageUrl: value['imageUrl'],
          ));
        });
        tempList.forEach((ei) {
          print("tempList  price => ${ei.price}");
        });
        _products = tempList;
        _products.forEach((ei) {
          print("_products price  => ${ei.price}");
        });

        notifyListeners();
        //
      }
    } catch (err) {
      print("Error in get => ${err.toString()}");
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

      print("Products after addProduct done  => $products");
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
