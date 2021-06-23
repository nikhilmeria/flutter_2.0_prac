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
            leading: Icon(Icons.shopping_cart),
            title: Text('Cart'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed("/cartDetails");
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
