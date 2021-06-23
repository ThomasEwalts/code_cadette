import 'package:code_cadette/Components/StandardComponentLibrary.dart';
import 'package:code_cadette/Model/AnswerModel.dart';
import 'package:code_cadette/Pages/VerifyScreen.dart';
import 'package:code_cadette/Themes/ColorClass.dart';
import 'package:flutter/material.dart';
import 'package:code_cadette/Components/numericKeyboard.dart';

class ChoiceBoxKeyboard extends StatefulWidget {
  final Color backgroundColor;
  final Color lineColor;
  final int questionType;
  final TextEditingController controller;
  final Color numPadColor;
  final AnswerModel answerModel;
  final Function enterOnPressed;

  ChoiceBoxKeyboard(
      {this.backgroundColor,
      this.lineColor,
      this.questionType,
      this.controller,
      this.numPadColor = Colors.white,
      this.answerModel,
      this.enterOnPressed});

  @override
  _ChoiceBoxKeyboardState createState() => _ChoiceBoxKeyboardState();
}

class _ChoiceBoxKeyboardState extends State<ChoiceBoxKeyboard> {
  bool numPadVisible = false;

  @override
  Widget build(BuildContext context) {
    if (!numPadVisible) {
      return choiceBox();
    } else {
      return numPad();
    }
  }

  onTextInput(myText) {
    _insertText(myText);
  }

  showHideNumPad(bool futureState) {
    if (futureState) {
      setState(() {
        numPadVisible = true;
      });
    } else {
      setState(() {
        numPadVisible = false;
      });
    }
  }

  void _textInputHandler(String text) => onTextInput?.call(text);

  void _insertText(String myText) {
    final text = this.widget.controller.text;
    final textSelection = this.widget.controller.selection;
    final newText = text.replaceRange(
      textSelection.start,
      textSelection.end,
      myText,
    );

    final myTextLength = myText.length;
    this.widget.controller.text = newText;
    this.widget.controller.selection = textSelection.copyWith(
      baseOffset: textSelection.start + myTextLength,
      extentOffset: textSelection.start + myTextLength,
    );
  }

  void _backspace() {
    final text = this.widget.controller.text;
    final textSelection = this.widget.controller.selection;
    final selectionLength = textSelection.end - textSelection.start;
    // There is a selection.
    if (selectionLength > 0) {
      final newText = text.replaceRange(
        textSelection.start,
        textSelection.end,
        '',
      );
      this.widget.controller.text = newText;
      this.widget.controller.selection = textSelection.copyWith(
        baseOffset: textSelection.start,
        extentOffset: textSelection.start,
      );
      return;
    }
    // The cursor is at the beginning.
    if (textSelection.start == 0) {
      return;
    }
    // Delete the previous character
    final previousCodeUnit = text.codeUnitAt(textSelection.start - 1);
    final offset = _isUtf16Surrogate(previousCodeUnit) ? 2 : 1;
    final newStart = textSelection.start - offset;
    final newEnd = textSelection.start;
    final newText = text.replaceRange(
      newStart,
      newEnd,
      '',
    );
    this.widget.controller.text = newText;
    this.widget.controller.selection = textSelection.copyWith(
      baseOffset: newStart,
      extentOffset: newStart,
    );
  }

  bool _isUtf16Surrogate(int value) {
    return value & 0xF800 == 0xD800;
  }

  Column choiceBox() {
    switch (widget.questionType) {
      case 1:
        {
          return Column(
            children: [
              Table(
                border: TableBorder(
                    verticalInside:
                        BorderSide(width: 1, color: this.widget.lineColor),
                    horizontalInside:
                        BorderSide(width: 1, color: this.widget.lineColor)),
                children: <TableRow>[
                  _kleinerGroter(),
                  _backspaceEnterButton(context)
                ],
              ),
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
                          BorderSide(width: 1, color: this.widget.lineColor),
                      horizontalInside:
                          BorderSide(width: 1, color: this.widget.lineColor)),
                  children: <TableRow>[
                    _kleinerGroter(),
                    _backspaceEnterButton(context)
                  ]),
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
                          BorderSide(width: 1, color: this.widget.lineColor),
                      horizontalInside:
                          BorderSide(width: 1, color: this.widget.lineColor)),
                  children: <TableRow>[
                    _kleinerGroter(),
                    _alsDan(),
                    _backspaceEnterButton(context)
                  ]),
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

  NumericKeyboard numPad() {
    return new NumericKeyboard(
      textColor: this.widget.numPadColor,
      onKeyboardTap: (value) {
        _textInputHandler(value);
      },
      leftIcon: Icon(Icons.arrow_circle_down,
          color: this.widget.numPadColor, size: 30),
      leftButtonFn: () => showHideNumPad(false),
      rightIcon: Icon(Icons.backspace_rounded,
          color: this.widget.numPadColor, size: 30),
      rightButtonFn: () => _backspace(),
    );
  }

  Row _getal(BuildContext context) {
    return Row(
      children: [
        Ink(
          child: _specificTextButton('Getal',
              onPressed: () => showHideNumPad(true)),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: this.widget.backgroundColor,
              border: Border(
                  bottom: BorderSide(color: this.widget.lineColor, width: 1))),
        )
      ],
    );
  }

  TableRow _kleinerGroter() {
    return TableRow(children: <Widget>[
      Ink(
          child: _specificTextButton(
            'Kleiner',
            onPressed: () {
              _textInputHandler('<');
            },
          ),
          color: this.widget.backgroundColor),
      Ink(
          child: _specificTextButton(
            'Groter',
            onPressed: () {
              _textInputHandler('>');
            },
          ),
          color: this.widget.backgroundColor),
    ]);
  }

  TableRow _alsDan() {
    return TableRow(children: <Widget>[
      Ink(
          child: _specificTextButton('Als', onPressed: () {
            _textInputHandler('als');
          }),
          color: this.widget.backgroundColor),
      Ink(
          child: _specificTextButton('Dan', onPressed: () {
            _textInputHandler('dan');
          }),
          color: this.widget.backgroundColor),
    ]);
  }

  TableRow _backspaceEnterButton(BuildContext context) {
    return TableRow(
      children: [
        Ink(
          child:
              _specificIconButton(Icon(Icons.backspace_sharp), onPressed: () {
            _backspace();
          }),
          decoration: BoxDecoration(
            color: this.widget.backgroundColor,
          ),
        ),
        Ink(
          child: _specificIconButton(Icon(Icons.check), onPressed: () {
            bool verify = this.widget.answerModel.checkAnswers();

            if (verify) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => VerifyScreen(verify)));
            } else {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => VerifyScreen(verify)));
            }
          }),
          decoration: BoxDecoration(
            color: this.widget.backgroundColor,
          ),
        )
      ],
    );
  }

  StandardTextButton _specificTextButton(String title, {Function onPressed}) {
    return StandardTextButton(
      title: title,
      textColor: Colors.black,
      textSize: 16.0,
      onPressed: onPressed,
      splashColor: ColorClass.alsDanBackground,
      height: 40,
    );
  }

  StandardIconButton _specificIconButton(Icon icon, {Function onPressed}) {
    return StandardIconButton(
      icon: icon,
      onPressed: onPressed,
      splashColor: ColorClass.alsDanBackground,
      height: 40,
    );
  }
}
