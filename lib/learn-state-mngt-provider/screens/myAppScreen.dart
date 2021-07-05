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
      backgroundColor: Color(0xFF21BFBD),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xFF21BFBD),
        title: Text(
          "we2",
        ),
        centerTitle: true,
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
        child: Column(
          children: [
            SizedBox(height: 25.0),
            Padding(
              padding: EdgeInsets.only(left: 40.0),
              child: Row(
                children: <Widget>[
                  Text(
                    'Games',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 25.0,
                    ),
                  ),
                  SizedBox(width: 10.0),
                  Text(
                    'World',
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        color: Colors.white,
                        fontSize: 25.0),
                  )
                ],
              ),
            ),
            SizedBox(height: 40.0),
            Container(
              height: MediaQuery.of(context).size.height - 175.0,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(75.0)),
              ),
              child: ProductsScreen(),
            ),
          ],
        ),
      ),
    );
  }
}
