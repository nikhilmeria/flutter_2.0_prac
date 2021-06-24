import 'package:coffee_shop_ui/learn-state-mngt-provider/provider/cart_provider.dart';
import 'package:coffee_shop_ui/learn-state-mngt-provider/provider/order_provider.dart';
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
                  OrderButton(cartData: cartData),
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

class OrderButton extends StatefulWidget {
  const OrderButton({
    Key? key,
    required this.cartData,
  }) : super(key: key);

  final CartProvider cartData;

  @override
  _OrderButtonState createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: isLoading
          ? CircularProgressIndicator()
          : Text(
              'ORDER NOW',
              style: TextStyle(
                color: Colors.black87,
              ),
            ),
      onPressed: widget.cartData.getTotal <= 0 || isLoading == true
          ? null
          : () {
              setState(() {
                isLoading = true;
              });
              Provider.of<OrderProvider>(context, listen: false).addOrder(
                  widget.cartData.cartItem.values.toList(),
                  widget.cartData.getTotal);

              // print(
              //     "OrderDetails => ${Provider.of<OrderProvider>(context, listen: false).orderItem[0].products![0].title}");

              setState(() {
                isLoading = false;
              });
              //push to orders screen
              Navigator.of(context).pushNamed("/orderDetails");
            },
    );
  }
}

//${cartData.cartItem.values.toList()[index].title}
