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

    return FutureBuilder(
      future: productsData.fetchProductsFromDB(),
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
            return GridView.builder(
              padding: const EdgeInsets.all(10.0),
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
                childAspectRatio: 3 / 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
            );
          }
        } //else
      }, // builder
    );
  }
}
