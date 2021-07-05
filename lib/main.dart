import 'package:coffee_shop_ui/learn-state-mngt-provider/provider/auth-provider.dart';
import 'package:coffee_shop_ui/learn-state-mngt-provider/provider/cart_provider.dart';
import 'package:coffee_shop_ui/learn-state-mngt-provider/provider/order_provider.dart';
import 'package:coffee_shop_ui/learn-state-mngt-provider/provider/product_provider.dart';
import 'package:coffee_shop_ui/learn-state-mngt-provider/screens/addProductScreen.dart';
import 'package:coffee_shop_ui/learn-state-mngt-provider/screens/authScreen.dart';
import 'package:coffee_shop_ui/learn-state-mngt-provider/screens/cartScreen.dart';
import 'package:coffee_shop_ui/learn-state-mngt-provider/screens/myAppScreen.dart';
import 'package:coffee_shop_ui/learn-state-mngt-provider/screens/orderScreen.dart';
import 'package:coffee_shop_ui/learn-state-mngt-provider/screens/productDetailsScreen.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: Color(0x000000), // navigation bar color
    statusBarColor: Color(0xFF21BFBD), // status bar color
  ));
  runApp(
    MultiProvider(
      providers: [
        StreamProvider(
          create: (ctx) => AuthProvider.user,
          initialData: null,
        ),
        ChangeNotifierProvider(
          create: (ctx) => ProductProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => CartProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => OrderProvider(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
          accentColor: Colors.orangeAccent,
          primaryColor: Colors.purpleAccent,
        ),
        home: Consumer<String?>(
          builder: (context, authData, child) =>
              authData == null ? AuthScreen() : MyAppScreen(),
        ),
        title: "we2 Shop",
        debugShowCheckedModeBanner: false,
        routes: {
          "/productDetails": (ctx) => ProductDetailsScreen(),
          "/cartDetails": (ctx) => CartScreen(),
          "/orderDetails": (ctx) => OrderScreen(),
          "/addProduct": (ctx) => AddProductScreen(),
          "/productScreen": (ctx) => MyAppScreen()
        },
      ),
    ),
  );
}
