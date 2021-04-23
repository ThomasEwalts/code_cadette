import 'package:flutter/material.dart';

class StandardFlatTextBox extends StatelessWidget {
  final Color backgroundcolor;
  final String content;
  final double height;
  final double width;
  final double fontSize;

  StandardFlatTextBox(
      {this.backgroundcolor,
      this.content,
      this.height,
      this.width,
      this.fontSize = 16.0});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(5),
        height: this.height,
        width: this.width,
        decoration: BoxDecoration(
            color: backgroundcolor,
            borderRadius: BorderRadius.all(Radius.circular(5))),
        child: Text(content,
            style: TextStyle(
                fontSize: fontSize,
                fontFamily: 'Raleway',
                color: Colors.black,
                fontWeight: FontWeight.w600)));
  }
}
