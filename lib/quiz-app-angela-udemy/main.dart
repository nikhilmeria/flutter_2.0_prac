import 'package:coffee_shop_ui/quiz-app-angela-udemy/quiz.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      home: MyApp(),
      title: "Flutter 2.2",
      debugShowCheckedModeBanner: false,
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
      body: Quiz(),
    );
  }
}
