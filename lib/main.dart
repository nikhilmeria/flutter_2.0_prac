import 'package:coffee_shop_ui/learn-state-mngt-provider/provider/product_provider.dart';
import 'package:coffee_shop_ui/learn-state-mngt-provider/screens/productDetailsScreen.dart';
import 'package:coffee_shop_ui/learn-state-mngt-provider/screens/productsScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    ChangeNotifierProvider(
      create: (ctx) => ProductProvider(),
      child: MaterialApp(
        theme: ThemeData(
          accentColor: Colors.orangeAccent,
          primaryColor: Colors.purpleAccent,
        ),
        home: MyApp(),
        title: "we2 Shop",
        debugShowCheckedModeBanner: false,
        routes: {
          "/productDetails": (ctx) => ProductDetailsScreen(),
        },
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // return Dashboard();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "we2",
        ),
        centerTitle: true,
        backgroundColor: Colors.lightBlue,
        actions: [
          PopupMenuButton(
            itemBuilder: (ctx) => [
              PopupMenuItem(child: Text('Profile'), value: 0),
              PopupMenuItem(child: Text('Settings'), value: 1),
            ],
            onSelected: (int valueSelected) {
              print("popup item selectede => $valueSelected");
            },
          ),
        ],
      ),
      body: ProductsScreen(),
    );
  }
}
