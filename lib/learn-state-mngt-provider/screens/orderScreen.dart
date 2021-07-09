import 'package:coffee_shop_ui/learn-state-mngt-provider/provider/cart_provider.dart';
import 'package:coffee_shop_ui/learn-state-mngt-provider/provider/order_provider.dart';
import 'package:coffee_shop_ui/learn-state-mngt-provider/widgets/app_drawer.dart';
import 'package:coffee_shop_ui/learn-state-mngt-provider/widgets/order_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderScreen extends StatelessWidget {
  void handlePayment(BuildContext context) {
    //clear the cart
    Provider.of<CartProvider>(context, listen: false).clearCart;

    //TODO: add the order details in order db here
  }

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
        centerTitle: true,
        backgroundColor: Color(0xFF21BFBD),
      ),
      drawer: AppDrawer(),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: orderData.orderItem.length,
              itemBuilder: (ctx, index) => OrderItem(
                orderData.orderItem[index],
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
                    "\$ ${orderData.getOrderTotal}",
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 10),
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Color(0xFF21BFBD),
                      onSurface: Colors.grey,
                      primary: Colors.white,
                      elevation: 3.0,
                      shape: const BeveledRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(8),
                        ),
                      ),
                    ),
                    child: Text(
                      'PAY NOW',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    onPressed: () => handlePayment(context),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
