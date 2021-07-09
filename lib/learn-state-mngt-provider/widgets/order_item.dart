import 'dart:math';
import 'package:coffee_shop_ui/learn-state-mngt-provider/models/order.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrderItem extends StatefulWidget {
  final Order orderData;
  OrderItem(this.orderData);

  @override
  _OrderItemState createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    print("order_item => ${widget.orderData.products!.length}");

    return Card(
      margin: EdgeInsets.all(10.0),
      child: Column(
        children: [
          ListTile(
            title: Text(
              'Product Details',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            subtitle: Text(
              DateFormat("dd/MM/yyyy - hh:mm")
                  .format(widget.orderData.dateAndTime!),
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            trailing: IconButton(
              icon: _isExpanded
                  ? Icon(Icons.expand_less)
                  : Icon(Icons.expand_more),
              onPressed: () {
                setState(() {
                  _isExpanded = !_isExpanded;
                });
              },
            ),
          ),
          _isExpanded
              ? Container(
                  margin: EdgeInsets.all(10.0),
                  height:
                      min(widget.orderData.products!.length * 20.0 + 100, 180),
                  child: ListView(
                    children: widget.orderData.products!
                        .map(
                          (ei) => Column(
                            children: [
                              Divider(
                                color: Colors.black,
                                thickness: 5.0,
                              ),
                              Row(
                                children: [
                                  Text(
                                    ei.title!,
                                    style: TextStyle(
                                      fontSize: 26,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  Text(
                                    "${ei.price} x ${ei.quantity}",
                                    style: TextStyle(
                                      fontSize: 26,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                        .toList(),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
