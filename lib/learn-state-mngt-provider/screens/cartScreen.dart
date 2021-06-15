import 'package:coffee_shop_ui/learn-state-mngt-provider/provider/cart_provider.dart';
import 'package:coffee_shop_ui/learn-state-mngt-provider/widgets/cart_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CartProvider cartObj = Provider.of<CartProvider>(context);
    CartProvider cartData = cartObj;

    return Scaffold(
      appBar: AppBar(
        title: Text('Cart Details'),
      ),
      body: Column(
        children: <Widget>[
          Card(
            margin: EdgeInsets.all(15),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Chip(
                    label: Text(
                      'Total',
                    ),
                  ),
                  Spacer(),
                  Text(
                    "\$ ${cartData.getTotal}",
                    style: TextStyle(fontSize: 20),
                  ),
                  TextButton(
                    child: Text(
                      'ORDER NOW',
                      style: TextStyle(
                        color: Colors.black87,
                      ),
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: cartData.cartItem.length,
              itemBuilder: (ctx, index) => CartItem(
                cartData.cartItem.values.toList()[index].id!,
                cartData.cartItem.keys.toList()[index],
                cartData.cartItem.values.toList()[index].price!,
                cartData.cartItem.values.toList()[index].quantity!,
                cartData.cartItem.values.toList()[index].title!,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

//${cartData.cartItem.values.toList()[index].title}
