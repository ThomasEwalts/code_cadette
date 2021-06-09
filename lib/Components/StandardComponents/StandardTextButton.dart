import 'package:flutter/material.dart';

class StandardTextButton extends StatelessWidget {
  final String title;
  final Function onPressed;
  final Color splashColor;
  final Color textColor;
  final double textSize;
  final double width;
  final double height;
  final Border border;

  StandardTextButton(
      {this.title,
      this.onPressed,
      this.splashColor,
      this.textColor,
      this.textSize,
      this.width,
      this.height,
      this.border});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
          width: this.width,
          height: this.height,
          child: Center(
            child: Text(this.title,
                style: TextStyle(
                  color: textColor,
                  fontFamily: 'Raleway',
                  fontWeight: FontWeight.w600,
                  fontSize: this.textSize,
                )),
          ),
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(border: this.border)),
      onTap: this.onPressed,
      splashColor: this.splashColor,
    );
  }
}
