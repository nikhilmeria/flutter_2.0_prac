import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
  final String? id;
  final String? title;
  final double? price;
  final String? imageUrl;
  final String? description;
  ProductItem(this.id, this.title, this.price, this.imageUrl, this.description);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed("/productDetails", arguments: {
          "id": id,
          "title": title,
          "price": price,
          "imageUrl": imageUrl,
          "description": description,
        });
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 3.0,
              blurRadius: 5.0,
            )
          ],
          color: Colors.white,
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(
                    Icons.favorite_border,
                    color: Color(0xFFEF7532),
                  ),
                ],
              ),
            ),
            Hero(
              tag: '$id',
              child: Container(
                height: 125.0,
                width: 1055.0,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/cookiemint.jpg'),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            SizedBox(height: 15.0),
            Text(
              title!,
              style: TextStyle(
                color: Color(0xFF575E67),
                fontSize: 18.0,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Container(
                color: Color(0xFFEBEBEB),
                height: 5.0,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 5.0, right: 5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.explore,
                    color: Color(0xFFD17E50),
                    size: 12.0,
                  ),
                  Text(
                    ' Explore Store',
                    style: TextStyle(
                      color: Color(0xFFD17E50),
                      fontSize: 15.0,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
