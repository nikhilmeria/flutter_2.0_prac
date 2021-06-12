import 'package:flutter/material.dart';

class ProductDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context)?.settings.arguments as Map<String, String?>;
    String productTitle = routeArgs['title']!;
    print("productTitle = $productTitle");
    return Scaffold(
      appBar: AppBar(
        title: Text(" Title => $productTitle"),
      ),
    );
  }
}
