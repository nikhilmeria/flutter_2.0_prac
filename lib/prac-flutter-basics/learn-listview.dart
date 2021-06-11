import 'package:flutter/material.dart';

class LearnListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final myList = [
      "Modi",
      "Sardar",
      "Subhash",
      "Shashtri",
      "Advani",
    ];

    return Container(
      height: 300.0,
      child: ListView(
        scrollDirection: Axis.vertical,
        children: myList.map(
          (ei) {
            return Text(
              ei,
              style: TextStyle(
                fontSize: 40.0,
              ),
            );
          },
        ).toList(), // '.toList()'  => this is very imp.
      ),
    );
  }
}
