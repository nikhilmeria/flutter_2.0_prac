import 'package:coffee_shop_ui/learn-state-mngt-provider/provider/auth-provider.dart';
import 'package:coffee_shop_ui/learn-state-mngt-provider/provider/cart_provider.dart';
import 'package:coffee_shop_ui/learn-state-mngt-provider/provider/product_provider.dart';
import 'package:coffee_shop_ui/learn-state-mngt-provider/screens/productsScreen.dart';
import 'package:coffee_shop_ui/learn-state-mngt-provider/widgets/app_drawer.dart';
import 'package:coffee_shop_ui/learn-state-mngt-provider/widgets/badge.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyAppScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "we2",
        ),
        centerTitle: true,
        backgroundColor: Colors.lightBlue,
        actions: [
          Consumer(
            builder: (_, CartProvider cartData, Widget? child) => Badge(
              value: cartData.cartCount.toString(),
              child: child,
            ),
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/cartDetails');
              },
              icon: Icon(
                Icons.shopping_bag_rounded,
              ),
            ),
          ),
          PopupMenuButton(
            itemBuilder: (ctx) => [
              PopupMenuItem(child: Text('Profile'), value: 0),
              PopupMenuItem(child: Text('Settings'), value: 1),
              PopupMenuItem(child: Text('Logout'), value: 2),
            ],
            onSelected: (int valueSelected) async {
              print("popup item selectede => $valueSelected");
              if (valueSelected == 2) {
                await AuthProvider.signOutFn();
                print("Sign out done ");
              }
            },
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: RefreshIndicator(
        onRefresh: () {
          return Provider.of<ProductProvider>(context, listen: false)
              .fetchProductsFromDB();
        },
        child: ProductsScreen(),
      ),
    );
  }
}
