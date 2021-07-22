import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee_shop_ui/learn-state-mngt-provider/models/product.dart';
import 'package:flutter/cupertino.dart';

class ProductProvider with ChangeNotifier {
  List<Product> _products = [];

  List<Product> get products {
    return [..._products];
  }

  Future<void> fetchProductsFromDB() async {
    final List<Product> tempProductData = [];
    try {
      QuerySnapshot<Map<String, dynamic>> fetchProducts =
          await FirebaseFirestore.instance.collection("Products").get();

      fetchProducts.docs.forEach((ei) {
        tempProductData.add(Product(
          id: ei.id,
          title: ei.data()['title'],
          description: ei.data()['description'],
          price: ei.data()['price'],
          imageUrl: ei.data()['imageUrl'],
        ));
      });
      // print("tempProductData  => ${tempProductData.first.title}");
      _products = tempProductData;

      notifyListeners();
      //
    } catch (err) {
      print("Error in fetchProductsFromDB => $err");
      throw err;
    }
  } //fetchProductsFromDB

  Future<void> addProduct(Product recdProduct) async {
    try {
      DocumentReference docRef =
          await FirebaseFirestore.instance.collection('Products').add({
        "title": recdProduct.title,
        "description": recdProduct.description,
        " price": recdProduct.price,
        "imageUrl": recdProduct.imageUrl,
      });

      print("addProduct resp => ${docRef.id}");
      notifyListeners();
      //
    } catch (err) {
      print("Error in post => ${err.toString()}");
      throw err;
    }
  } //addProduct

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
