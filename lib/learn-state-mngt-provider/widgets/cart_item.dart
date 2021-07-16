import 'package:coffee_shop_ui/learn-state-mngt-provider/provider/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartItem extends StatelessWidget {
  final String id;
  final String prodId;
  final double price;
  final int quantity;
  final String title;

  CartItem(
    this.id,
    this.prodId,
    this.price,
    this.quantity,
    this.title,
  );

  @override
  Widget build(BuildContext context) {
    print("cart_item  => $quantity = $price");

    return Dismissible(
      key: ValueKey(id),
      direction: DismissDirection.endToStart,
      background: Container(
        margin: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
        padding: EdgeInsets.only(
          right: 20.0,
        ),
        color: Colors.red,
        child: Icon(
          Icons.delete,
          size: 40.0,
          color: Colors.white70,
        ),
        alignment: Alignment.centerRight,
      ),
      child: Card(
        margin: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: ListTile(
            leading: CircleAvatar(
              child: Padding(
                padding: EdgeInsets.all(3),
                child: FittedBox(
                  child: Text(
                    '\$$price',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                    ),
                  ),
                ),
              ),
            ),
            title: Text(
              title,
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
            subtitle: Text(
              'Total : \$${(price * quantity)}',
              style: TextStyle(
                color: Colors.black45,
                fontSize: 15.0,
              ),
            ),
            trailing: Text(
              '$quantity x',
              style: TextStyle(
                color: Colors.black45,
                fontSize: 20.0,
              ),
            ),
          ),
        ),
      ),
      onDismissed: (direction) {
        Provider.of<CartProvider>(context, listen: false)
            .removeItemFromCart(prodId);
      },
      confirmDismiss: (dismissDirection) {
        return showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('Confirm Delete ? '),
            content: Text('Product will be deleted from Cart'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(true),
                child: Text('OK'),
              ),
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(false),
                child: Text('Cancel'),
              ),
            ],
          ),
        );
      },
    );
  }
}
