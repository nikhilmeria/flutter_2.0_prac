import 'package:coffee_shop_ui/colors/color_palette.dart';
import 'package:coffee_shop_ui/screens/black_gold.dart';
import 'package:coffee_shop_ui/screens/cold_brew.dart';
import 'package:coffee_shop_ui/screens/gold_brew.dart';
import 'package:coffee_shop_ui/screens/mccafe.dart';
import 'package:coffee_shop_ui/screens/nescafe.dart';
//import 'package:coffee_shop_ui/screens/black_gold.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  ColorPalette colorPalette = ColorPalette();
  var _selectedOption = 0;
  var previousIndex;
  List isSelected = [true, false, false, false, false];
  List widgetToRender = [
    BlackGold(),
    ColdBrew(),
    Nescafe(),
    McCafe(),
    GoldBrew()
  ];

  @override
  Widget build(BuildContext context) {
    var scrWidth = MediaQuery.of(context).size.width;
    var scrHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: scrHeight,
            width: scrWidth,
            color: Colors.transparent,
          ),
          Container(
            height: scrHeight,
            width: scrWidth / 5,
            color: colorPalette.leftBarColor,
          ),
          Positioned(
            left: scrWidth / 5,
            child: Container(
              height: scrHeight,
              width: scrWidth - (scrWidth / 5),
              color: Colors.white,
            ),
          ),
          Positioned(
            top: 35.0,
            left: 20.0,
            child: Icon(Icons.menu),
          ),
          Positioned(
            top: 35.0,
            right: 20.0,
            child: Icon(Icons.shopping_bag_rounded),
          ),
          Positioned(
            top: scrHeight - (scrHeight - 100),
            left: (scrWidth / 5) + 25.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Coffee House',
                  style: GoogleFonts.bigShouldersText(
                      color: Color(0xFF23163D), fontSize: 40.0),
                ),
                Text(
                  'A lot can happen over coffee',
                  style: GoogleFonts.bigShouldersText(
                      color: Color(0xFFA59FB0), fontSize: 15.0),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Container(
                  height: 40.0,
                  width: 225.0,
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: BorderSide(
                          color: Colors.grey.withOpacity(0.4),
                        ),
                      ),
                      contentPadding: EdgeInsets.only(top: 10.0, left: 10.0),
                      hintText: 'search...',
                      hintStyle: GoogleFonts.bigShouldersText(
                          color: Color(0xFFA59FB0), fontSize: 15.0),
                      suffixIcon: Icon(
                        Icons.search,
                        color: Colors.grey.withOpacity(0.4),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          buildSideNavigator(),
          Positioned(
            top: (scrHeight / 3) + 5.0,
            left: (scrWidth / 5) + 25.0,
            child: Container(
              height: scrHeight - ((scrHeight / 3) + 50.0),
              width: scrWidth - ((scrWidth / 5) + 40.0),
              child: widgetToRender[_selectedOption],
            ),
          )
        ],
      ),
    );
  }

  buildSideNavigator() {
    return Positioned(
      top: 75.0,
      child: RotatedBox(
        quarterTurns: 3,
        child: Container(
          width: MediaQuery.of(context).size.height - 100.0,
          height: MediaQuery.of(context).size.width / 5,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              buildOption('Black Gold', 0),
              buildOption('Cold Brew', 1),
              buildOption('Nescafe', 2),
              buildOption('McCafe', 3),
              buildOption('Gold Brew', 4),
            ],
          ),
        ),
      ),
    );
  }

  buildOption(String title, int index) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        isSelected[index]
            ? Container(
                height: 8.0,
                width: 8.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFF23163D),
                ),
              )
            : Container(
                height: 8.0,
                width: 8.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.transparent,
                ),
              ),
        SizedBox(height: 5.0),
        GestureDetector(
          onTap: () {
            setState(() {
              _selectedOption = index;
              previousIndex = isSelected.indexOf(true);
              print('previousIndex : $previousIndex');
              isSelected[index] = true;
              isSelected[previousIndex] = false;
            });
          },
          child: Text(
            title,
            style: isSelected[index]
                ? GoogleFonts.bigShouldersText(
                    color: Color(0xFF23163D), fontSize: 25.0)
                : GoogleFonts.bigShouldersText(
                    color: Color(0xFFA59FB0), fontSize: 20.0),
          ),
        )
      ],
    );
  }
}
