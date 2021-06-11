import 'package:flutter/material.dart';

class DisplayNo extends StatelessWidget {
  final Function callBkFn;
  DisplayNo(this.callBkFn);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ElevatedButton(
        onPressed: () => callBkFn(),
        child: Text(
          'Press',
          style: TextStyle(fontSize: 20.0),
        ),
      ),
    );
  }
}
