import 'package:coffee_shop_ui/learn-state-mngt-provider/provider/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductItem extends StatelessWidget {
  final String? id;
  final String? title;
  final double? price;
  final String? imageUrl;
  final String? description;
  ProductItem(this.id, this.title, this.price, this.imageUrl, this.description);

  @override
  Widget build(BuildContext context) {
    CartProvider cartObj = Provider.of<CartProvider>(context, listen: false);
    CartProvider cartData = cartObj;

    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed("/productDetails", arguments: {
          "title": title,
          "price": price,
          "imageUrl": imageUrl,
          "description": description,
        });
      },
      child: GridTile(
        child: Image.network(
          imageUrl!,
          fit: BoxFit.cover,
        ),
        footer: ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: GridTileBar(
            leading: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.favorite,
              ),
            ),
            backgroundColor: Colors.black54,
            title: Text(
              title!,
              style: TextStyle(
                fontSize: 20.0,
              ),
              textAlign: TextAlign.center,
            ),
            trailing: IconButton(
              onPressed: () => cartData.addItemToCart(id!, price!, title!),
              icon: Icon(
                Icons.shopping_cart,
              ),
              color: Theme.of(context).accentColor,
            ),
          ),
        ),
      ),
    );
  }
}
