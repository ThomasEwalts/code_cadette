import 'package:flutter/material.dart';

class StandardIconButton extends StatelessWidget {
  final Icon icon;
  final Function onPressed;
  final Color splashColor;
  final double width;
  final double height;
  final Border border;
  final bool canRequestFocus;

  StandardIconButton(
      {this.icon,
      this.onPressed,
      this.splashColor,
      this.width,
      this.height,
      this.border,
      this.canRequestFocus = true});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        width: this.width,
        height: this.height,
        child: Center(child: this.icon),
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(border: this.border),
      ),
      onTap: this.onPressed,
      splashColor: this.splashColor,
      canRequestFocus: this.canRequestFocus,
    );
  }
}
