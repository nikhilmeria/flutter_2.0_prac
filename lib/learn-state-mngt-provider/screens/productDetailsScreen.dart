import 'package:coffee_shop_ui/learn-state-mngt-provider/provider/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class ProductDetailsScreen extends StatefulWidget {
  @override
  _ProductDetailsScreenState createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  int quantity = 1;

  void handleQuantity() {
    if (quantity > 1) {
      setState(() {
        quantity--;
      });
    }
  }

  void handleAddToCart(CartProvider cartData, String prodId, String title,
      double price, int quantity) async {
    await cartData.addItemToCartDB(prodId, price / quantity, title, quantity);
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Product added to cart ...',
          style: TextStyle(
            fontSize: 15.0,
          ),
        ),
      ),
    );
    Navigator.of(context).popAndPushNamed('/productScreen');
  }

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context)?.settings.arguments as Map<String, Object?>;
    final productPrice = routeArgs["price"];
    double? price = productPrice as double; // price with quantity
    price = price * quantity;

    CartProvider cartObj = Provider.of<CartProvider>(context, listen: false);
    CartProvider cartData = cartObj;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light, // to change status bar color
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.6,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage('${routeArgs['imageUrl']}'),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Positioned(
              top: 30 + MediaQuery.of(context).padding.top,
              left: 10,
              child: InkWell(
                onTap: () => Navigator.of(context)
                    .pushReplacementNamed("/productScreen"),
                child: ClipOval(
                  child: Container(
                    width: 42,
                    height: 41,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(.7),
                          offset: Offset(0, 4),
                          blurRadius: 8.0,
                        ),
                      ],
                    ),
                    child: Center(
                      child: Icon(Icons.arrow_back_ios),
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.4,
                decoration: BoxDecoration(
                  color: Colors.orange[100],
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40.0),
                    topRight: Radius.circular(40.0),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(.2),
                      offset: Offset(0, -4),
                      blurRadius: 8.0,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 20, top: 20, right: 20.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              '${routeArgs["title"]}',
                              style: TextStyle(
                                fontSize: 36,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          IconButton(
                            padding: EdgeInsets.only(bottom: 20.0),
                            onPressed: () {},
                            icon: Icon(
                              Icons.favorite_border_outlined,
                              size: 40.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 20, top: 20, right: 30.0),
                      child: Text(
                        '\$$productPrice',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 15, top: 20, right: 30.0),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 4,
                          horizontal: 8,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.deepPurple[400],
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Text(
                          '${routeArgs['description']}',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            child: Container(
                              height: 49,
                              width: 49,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(.7),
                                    offset: Offset(0, -1),
                                    blurRadius: 12.0,
                                  ),
                                ],
                              ),
                              child: Center(
                                child: Text(
                                  '-',
                                  style: TextStyle(
                                    fontSize: 45,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                            onTap: handleQuantity,
                          ),
                          Container(
                            height: 49,
                            width: 80,
                            decoration: BoxDecoration(
                              color: Colors.orange[100],
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Center(
                              child: Text(
                                '$quantity',
                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            child: Container(
                              height: 49,
                              width: 49,
                              decoration: BoxDecoration(
                                color: Colors.orange[400],
                                borderRadius: BorderRadius.circular(10.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(.7),
                                    offset: Offset(0, -1),
                                    blurRadius: 12.0,
                                  ),
                                ],
                              ),
                              child: Center(
                                child: Text(
                                  '+',
                                  style: TextStyle(
                                    fontSize: 45,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                            onTap: () => setState(() {
                              quantity++;
                            }),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.symmetric(
                        vertical: 20,
                        horizontal: 20,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.0),
                          topRight: Radius.circular(20.0),
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Total',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                  ),
                                ),
                                Text(
                                  '\$$price',
                                  style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Material(
                            color: Color.fromRGBO(243, 175, 45, 1),
                            borderRadius: BorderRadius.circular(10.0),
                            child: InkWell(
                              onTap: () => handleAddToCart(
                                cartData,
                                routeArgs["id"].toString(),
                                routeArgs["title"].toString(),
                                price!,
                                quantity,
                              ),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 10,
                                  horizontal: 20,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.orange[300],
                                  borderRadius: BorderRadius.circular(10.0),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(.7),
                                      offset: Offset(0, -1),
                                      blurRadius: 12.0,
                                    ),
                                  ],
                                ),
                                child: Text(
                                  'Add to Cart',
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
