import 'package:flutter/material.dart';

class StandardTextButton extends StatelessWidget {
  final String title;
  final Function onPressed;
  final Color backgroundColor;
  final Color textcolor;

  StandardTextButton({this.title, this.onPressed, this.backgroundColor, this.textcolor});

  @override
  Widget build(BuildContext context) {
    return TextButton(
        child: Text(
          this.title,
          style: TextStyle(
            color: textcolor,
            fontFamily: 'Raleway',
            fontWeight: FontWeight.w600,
            fontSize: 20,
          )
          ),
        onPressed: this.onPressed,
        style: TextButton.styleFrom(
          backgroundColor: backgroundColor,
        )
      );
  }
}
