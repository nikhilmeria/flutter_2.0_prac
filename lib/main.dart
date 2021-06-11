import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      home: MyApp(),
      title: "we2 Shop",
      debugShowCheckedModeBanner: false,
      routes: {},
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // return Dashboard();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "we2",
        ),
        centerTitle: true,
        backgroundColor: Colors.lightBlue,
      ),
      body: 
    );
  }
}
