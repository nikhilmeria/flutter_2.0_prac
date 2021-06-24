import 'package:coffee_shop_ui/learn-state-mngt-provider/provider/cart_provider.dart';
import 'package:coffee_shop_ui/learn-state-mngt-provider/provider/order_provider.dart';
import 'package:coffee_shop_ui/learn-state-mngt-provider/widgets/app_drawer.dart';
import 'package:coffee_shop_ui/learn-state-mngt-provider/widgets/order_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    OrderProvider orderObj = Provider.of<OrderProvider>(context);
    OrderProvider orderData = orderObj;
    double? total = 0;
    orderData.orderItem.map((ei) {
      print("OrderScreen => ${ei.total}");
      if (total == 0) total = ei.total;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Order Details'),
      ),
      drawer: AppDrawer(),
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
                    "\$ ${orderData.getOrderTotal}",
                    style: TextStyle(fontSize: 20),
                  ),
                  TextButton(
                    child: Text(
                      'PAY NOW',
                      style: TextStyle(
                        color: Colors.black87,
                      ),
                    ),
                    onPressed: () {
                      //clear the cart
                      Provider.of<CartProvider>(context, listen: false)
                          .clearCart;

                      //TODO: add the order details in order db here
                    },
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: orderData.orderItem.length,
              itemBuilder: (ctx, index) => OrderItem(
                orderData.orderItem[index],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
