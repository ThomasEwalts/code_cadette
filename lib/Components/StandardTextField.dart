import 'package:flutter/material.dart';

class StandardTextField extends StatefulWidget {
  final double height;
  final double width;
  final bool readOnly;
  final bool showCursor;
  final TextEditingController controller;

  StandardTextField(
      {this.height,
      this.width,
      this.readOnly = false,
      this.showCursor = true,
      this.controller});

  @override
  _StandardTextFieldState createState() => _StandardTextFieldState();
}

class _StandardTextFieldState extends State<StandardTextField> {
  FocusNode _focus = FocusNode();
  TextEditingController _controller;
  bool _enabled = true;
  @override
  void initState() {
    super.initState();
    _focus.addListener(_onFocusChange);
    _controller = this.widget.controller;
  }

  void _onFocusChange() {
    if (_focus.hasFocus) {
      setState(() {
        _controller = this.widget.controller;
      });
    } else {
      setState(() {
        _controller = new TextEditingController();
      });
    }
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
              enabled: _enabled,
              focusNode: _focus,
              controller: _controller,
              readOnly: widget.readOnly,
              showCursor: widget.showCursor,
              style: TextStyle(
                  fontSize: 12.0,
                  fontFamily: 'Raleway',
                  color: Colors.black,
                  fontWeight: FontWeight.w600)),
        ));
  }
}
