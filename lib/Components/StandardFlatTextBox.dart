import 'package:flutter/material.dart';

class StandardFlatTextBox extends StatelessWidget {
  final Color backgroundcolor;
  final String content;
  final double height;
  final double width;

  StandardFlatTextBox({this.backgroundcolor, this.content, this.height, this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      height: this.height,
      width: this.width,
      decoration: BoxDecoration(
        color: backgroundcolor
      ),
      child: Text(content, style: TextStyle(
        fontSize: 16.0, fontFamily: 'Raleway', color: Colors.black, fontWeight: FontWeight.w600)
        )
      );
  }
}
