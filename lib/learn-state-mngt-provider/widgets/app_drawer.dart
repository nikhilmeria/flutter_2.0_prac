import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: Text("we2"),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.shop),
            title: Text('Shop'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed("/");
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.payment),
            title: Text('Payments'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed("/orderDetails");
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.add_box),
            title: Text('Add Product'),
            onTap: () {
              Navigator.of(context).pushNamed("/addProduct");
            },
          ),
        ],
      ),
    );
  }
}
