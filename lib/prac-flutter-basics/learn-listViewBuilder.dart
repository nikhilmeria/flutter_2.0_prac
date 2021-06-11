import 'package:flutter/material.dart';

class LearnListViewBuilder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final myList = [
      "Modi",
      "Sardar",
      "Subhash",
      "Shashtri",
      "Advani",
      "Tatiya Tope",
    ];

    return Container(
      child:
          MyListBuilder(myList: myList), //ex of how a widget can be extracted
    );
  }
}

class MyListBuilder extends StatelessWidget {
  const MyListBuilder({
    Key? key,
    required this.myList,
  }) : super(key: key);

  final List<String> myList;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: myList.length,
      itemBuilder: (ctx, index) => Text(
        myList[index],
        style: TextStyle(
          fontSize: 40.0,
        ),
      ),
    );
  }
}

//inside of a column or a row every item is as big as it needs to be or as you tell it to be
