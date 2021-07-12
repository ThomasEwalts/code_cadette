import 'package:code_cadette/Components/StandardComponentLibrary.dart';
import 'package:code_cadette/Model/DynamicTextFieldModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DynamicTextField extends StatefulWidget {
  final double height;
  final double width;
  final bool readOnly;
  final bool showCursor;
  final TextEditingController controller;
  final double fontSize;
  final int maxLength;

  DynamicTextField(
      {this.height,
      this.width,
      this.readOnly = false,
      this.showCursor = true,
      this.controller,
      this.fontSize = 16.0,
      this.maxLength});

  @override
  _DynamicTextFieldState createState() => _DynamicTextFieldState();
}

class _DynamicTextFieldState extends State<DynamicTextField> {
  FocusNode _focus = FocusNode();

  @override
  void initState() {
    super.initState();
  }

  final Color backgroundcolor = Color(0x00FFFFFF);

  @override
  Widget build(BuildContext context) {
    var dynamicTextFieldModel = context.watch<DynamicTextFieldModel>();

    _focus.addListener(() {
      if (_focus.hasFocus) {
        setState(() {
          dynamicTextFieldModel.textEditingController = this.widget.controller;
        });
      }
    });

    return StandardTextField(
      height: this.widget.height,
      width: this.widget.width,
      readOnly: this.widget.readOnly,
      showCursor: this.widget.showCursor,
      controller: this.widget.controller,
      fontSize: this.widget.fontSize,
      maxLength: this.widget.maxLength,
      focusnode: _focus,
      centered: true,
    );
  }
}
