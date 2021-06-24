import 'package:coffee_shop_ui/learn-state-mngt-provider/provider/product_provider.dart';
import 'package:coffee_shop_ui/learn-state-mngt-provider/widgets/product_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductsScreen extends StatefulWidget {
  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  bool isLoading = false;

  @override
  void initState() {
    print("ProductsScreen initState =>");
    setState(() {
      isLoading = true;
    });
    Provider.of<ProductProvider>(context, listen: false)
        .fetchProductsFromDB()
        .then((_) => {
              setState(() {
                isLoading = false;
              })
            });
    super.initState();
  } // do not use async/await in life cycle methods. bcoz they cant handle futures as they return void data type, use then and catch.

  @override
  Widget build(BuildContext context) {
    print("inside product screen");
    ProductProvider productsData =
        Provider.of<ProductProvider>(context, listen: true);
    final productItems = productsData.products;

    // final idData = productsData.findById(productItems[1].id!);
    // print("idData = ${idData.description}");

    return isLoading
        ? Center(
            child: CircularProgressIndicator(
              strokeWidth: 10.0,
            ),
          )
        : productItems.length == 0
            ? Center(child: Text('No Products in the DB'))
            : GridView.builder(
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
