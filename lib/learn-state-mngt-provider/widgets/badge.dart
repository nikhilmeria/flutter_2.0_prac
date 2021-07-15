import 'package:coffee_shop_ui/learn-state-mngt-provider/provider/cart_provider.dart';
import 'package:flutter/material.dart';

class Badge extends StatefulWidget {
  final Widget? child;
  final Color? color;
  final CartProvider cartData;

  const Badge({
    @required this.child,
    this.color,
    required this.cartData,
  });

  @override
  _BadgeState createState() => _BadgeState();
}

class _BadgeState extends State<Badge> {
  @override
  void initState() {
    widget.cartData.fetchProductsFromCartDB();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int cartCount = widget.cartData.cartCount;

    return Stack(
      alignment: Alignment.center,
      children: [
        widget.child!,
        Positioned(
          right: 8,
          top: 8,
          child: Container(
            padding: EdgeInsets.all(2.0),
            // color: Theme.of(context).accentColor,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: widget.color != null
                  ? widget.color
                  : Theme.of(context).accentColor,
            ),
            constraints: BoxConstraints(
              minWidth: 16,
              minHeight: 16,
            ),
            child: Text(
              "$cartCount",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 10,
              ),
            ),
          ),
        )
      ],
    );
  }
}
