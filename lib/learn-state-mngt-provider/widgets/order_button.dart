import 'package:coffee_shop_ui/learn-state-mngt-provider/provider/cart_provider.dart';
import 'package:coffee_shop_ui/learn-state-mngt-provider/provider/order_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderButton extends StatefulWidget {
  final CartProvider cartData;
  const OrderButton({required this.cartData});

  @override
  _OrderButtonState createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  bool isLoading = false;

  void handleOrder() {
    setState(() {
      isLoading = true;
    });
    // Provider.of<OrderProvider>(context, listen: false).addOrderToDB(
    //     widget.cartData.cartItem.values.toList(), widget.cartData.getTotal);

    // print(
    //     "OrderDetails => ${Provider.of<OrderProvider>(context, listen: false).orderItem[0].products![0].title}");

    setState(() {
      isLoading = false;
    });
    //push to orders screen
    Navigator.of(context).pushNamed("/orderDetails",
        arguments: widget.cartData.cartItem.values.toList());
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: widget.cartData.cartItem.length == 0
            ? Colors.grey[400]
            : Color(0xFF21BFBD),
        onSurface: Colors.grey,
        primary: Colors.white,
        elevation: 3.0,
        shape: const BeveledRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
        ),
      ),
      child: isLoading
          ? CircularProgressIndicator()
          : Text(
              'ORDER NOW',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
                fontStyle: FontStyle.italic,
              ),
            ),
      onPressed: widget.cartData.cartItem.length == 0 ? null : handleOrder,
    );
  }
}
