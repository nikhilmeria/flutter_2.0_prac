import 'package:coffee_shop_ui/learn-state-mngt-provider/provider/auth-provider.dart';
import 'package:coffee_shop_ui/learn-state-mngt-provider/provider/cart_provider.dart';
import 'package:coffee_shop_ui/learn-state-mngt-provider/widgets/cart_item.dart';
import 'package:coffee_shop_ui/learn-state-mngt-provider/widgets/order_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CartProvider cartObj = Provider.of<CartProvider>(context);
    CartProvider cartData = cartObj;
    print("carttttt => ${cartData.cartItem.length}");

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('My Cart '),
        centerTitle: true,
        backgroundColor: Color(0xFF21BFBD),
      ),
      body: Column(
        children: <Widget>[
          Flexible(
            child: ListView.builder(
              itemCount: cartData.cartItem.length,
              itemBuilder: (ctx, index) => cartData.cartItem.length == 0
                  ? Container(
                      height: 50.0,
                      width: 50.0,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/emptycart.png'),
                          fit: BoxFit.contain,
                        ),
                      ),
                    )
                  : CartItem(
                      AuthProvider.userData.uid,
                      cartData.cartItem.values.toList()[index].id!,
                      cartData.cartItem.keys.toList()[index],
                      cartData.cartItem.values.toList()[index].price!,
                      cartData.cartItem.values.toList()[index].quantity!,
                      cartData.cartItem.values.toList()[index].title!,
                    ),
            ),
          ),
          SizedBox(height: 10),
          Card(
            margin: EdgeInsets.all(15),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Chip(
                    backgroundColor: Colors.grey[300],
                    elevation: 3.0,
                    label: Text(
                      'Total',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  Spacer(),
                  Text(
                    "\$ ${cartData.getTotal}",
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 10),
                  OrderButton(cartData: cartData),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

//${cartData.cartItem.values.toList()[index].title}
