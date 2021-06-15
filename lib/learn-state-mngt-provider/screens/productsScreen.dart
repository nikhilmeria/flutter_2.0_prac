import 'package:coffee_shop_ui/learn-state-mngt-provider/provider/product_provider.dart';
import 'package:coffee_shop_ui/learn-state-mngt-provider/widgets/product_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ProductProvider productsData =
        Provider.of<ProductProvider>(context, listen: true);
    final productItems = productsData.products;
    // final idData = productsData.findById(productItems[1].id!);
    // print("idData = ${idData.description}");

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
}
