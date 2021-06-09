import 'package:flutter/material.dart';

class StandardTextField extends StatefulWidget {
  final double height;
  final double width;
  final bool readOnly;
  final bool showCursor;
  final TextEditingController controller;
  final double fontSize;
  final int maxLength;
  final FocusNode focusnode;
  final Function onchanged;

  StandardTextField(
      {this.height,
      this.width,
      this.readOnly = false,
      this.showCursor = true,
      this.controller,
      this.fontSize = 16.0,
      this.maxLength,
      this.focusnode,
      this.onchanged});

  @override
  _StandardTextFieldState createState() => _StandardTextFieldState();
}

class _StandardTextFieldState extends State<StandardTextField> {
  @override
  void initState() {
    super.initState();
  }

  final Color backgroundcolor = Color(0x00FFFFFF);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(top: 15),
        height: this.widget.height,
        width: this.widget.width,
        child: Container(
          width: 100,
          child: TextField(
              onChanged: this.widget.onchanged,
              focusNode: this.widget.focusnode,
              controller: this.widget.controller,
              readOnly: widget.readOnly,
              showCursor: widget.showCursor,
              maxLength: this.widget.maxLength,
              style: TextStyle(
                  fontSize: this.widget.fontSize,
                  fontFamily: 'Raleway',
                  color: Colors.black,
                  fontWeight: FontWeight.w600)),
        ));
  }
}
