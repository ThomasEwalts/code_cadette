import 'package:code_cadette/Components/StandardComponentLibrary.dart';
import 'package:code_cadette/Themes/ColorClass.dart';
import 'package:flutter/material.dart';

class LearningGoalAlsDanChoiceBox extends StatelessWidget {
  final Color backgroundColor;
  final Color lineColor;
  final int questionType;
  final ValueSetter<String> onTextInput;
  final TextEditingController controller;

  LearningGoalAlsDanChoiceBox(
      {this.backgroundColor,
      this.lineColor,
      this.questionType,
      this.onTextInput,
      this.controller});

  void _textInputHandler(String text) => onTextInput?.call(text);

  @override
  Widget build(BuildContext context) {
    switch (questionType) {
      case 1:
        {
          return Column(
            children: [
              Table(
                  border: TableBorder(
                      verticalInside:
                          BorderSide(width: 1, color: this.lineColor),
                      horizontalInside:
                          BorderSide(width: 1, color: this.lineColor)),
                  children: <TableRow>[_kleinerGroter()]),
            ],
          );
        }
        break;

      case 2:
        {
          return Column(
            children: [
              _getal(context),
              Table(
                  border: TableBorder(
                      verticalInside:
                          BorderSide(width: 1, color: this.lineColor),
                      horizontalInside:
                          BorderSide(width: 1, color: this.lineColor)),
                  children: <TableRow>[_kleinerGroter()]),
            ],
          );
        }
        break;
      case 3:
        {
          return Column(
            children: [
              _getal(context),
              Table(
                  border: TableBorder(
                      verticalInside:
                          BorderSide(width: 1, color: this.lineColor),
                      horizontalInside:
                          BorderSide(width: 1, color: this.lineColor)),
                  children: <TableRow>[_kleinerGroter(), _alsDan()]),
            ],
          );
        }
        break;
      default:
        {
          return Column(
            children: [
              Row(
                children: [
                  Container(
                      color: Colors.red,
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      child: Center(
                        child: Text(
                          'an error has occurred, please contact the developer',
                        ),
                      ))
                ],
              )
            ],
          );
        }
        break;
    }
  }

  Row _getal(BuildContext context) {
    return Row(
      children: [
        Ink(
          child: _specificTextButton('Getal',
              onPressed: () => MediaQuery.of(context).viewInsets.bottom),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: this.backgroundColor,
              border:
                  Border(bottom: BorderSide(color: this.lineColor, width: 1))),
        )
      ],
    );
  }

  TableRow _kleinerGroter() {
    return TableRow(children: <Widget>[
      Ink(
          child: _specificTextButton('Kleiner', onPressed: () {
            _textInputHandler('<');
          },),
          color: this.backgroundColor),
      Ink(child: _specificTextButton('Groter'), color: this.backgroundColor),
    ]);
  }

  TableRow _alsDan() {
    return TableRow(children: <Widget>[
      Ink(child: _specificTextButton('Als'), color: this.backgroundColor),
      Ink(child: _specificTextButton('Dan'), color: this.backgroundColor),
    ]);
  }

  StandardTextButton _specificTextButton(String title, {Function onPressed}) {
    return StandardTextButton(
      title: title,
      textColor: Colors.black,
      textSize: 16.0,
      onPressed: onPressed,
      splashColor: ColorClass.alsDanBackground,
      height: 50,
    );
  }
}
