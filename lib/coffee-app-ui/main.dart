import 'package:coffee_shop_ui/coffee-app-ui/displayNo.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: MyApp(),
    title: "Flutter 2.2",
    debugShowCheckedModeBanner: false,
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int no = 10;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "we2",
        ),
        centerTitle: true,
        backgroundColor: Colors.redAccent,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(25.0),
          ),
          Demo(no),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print("updating no : $no");
          setState(() {
            no++;
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class Demo extends StatefulWidget {
  final int no1;
  Demo(this.no1);

  @override
  _DemoState createState() => _DemoState();
}

class _DemoState extends State<Demo> {
  void handleFn() => print("Fn called from displayNO");

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          children: [
            Text(
              'NO - ${widget.no1}',
              style: TextStyle(fontSize: 30.0),
            ),
            DisplayNo(handleFn)
          ],
        ),
      ),
    );
  }
}
