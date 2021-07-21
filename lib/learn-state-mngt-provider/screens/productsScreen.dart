import 'package:coffee_shop_ui/learn-state-mngt-provider/provider/auth-provider.dart';
import 'package:coffee_shop_ui/learn-state-mngt-provider/provider/product_provider.dart';
import 'package:coffee_shop_ui/learn-state-mngt-provider/widgets/product_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductsScreen extends StatelessWidget {
  //
  @override
  Widget build(BuildContext context) {
    print("inside product screen");
    ProductProvider productsData =
        Provider.of<ProductProvider>(context, listen: false);

    print("ProductsScreen UID => ${AuthProvider.userData.uid}");

    // for "FutureBuilder" see video no 262
    return FutureBuilder(
      future: productsData.fetchProductsFromDB(AuthProvider.userToken),
      builder: (ctx, dataSnapshot) {
        if (dataSnapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(
              strokeWidth: 10.0,
            ),
          );
        } else {
          if (dataSnapshot.error != null) {
            return Center(
              child: Text('Error fetching Data, refresh...'),
            );
          } else {
            final productItems = productsData.products;
            return productItems.length == 0
                ? Center(child: Text('No Products in the DB'))
                : GridView.builder(
                    padding: const EdgeInsets.all(40.0),
                    itemCount: productItems.length,
                    itemBuilder: (ctx, index) => ProductItem(
                      productItems[index].id,
                      productItems[index].title,
                      productItems[index].price,
                      productItems[index].imageUrl,
                      productItems[index].description,
                    ),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1.8 / 2,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 10,
                    ),
                  );
          } //else
        } //else
      }, // builder
    );
  }
}
