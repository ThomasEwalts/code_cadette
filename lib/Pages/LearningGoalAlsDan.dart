import 'package:code_cadette/Components/AnswerBox.dart';
import 'package:code_cadette/Components/StandardComponentLibrary.dart';
import 'package:code_cadette/Components/LearningGoalAlsDanChoiceBox.dart';
import 'package:code_cadette/Model/DatabaseModel.dart';
import 'package:flutter/material.dart';
import 'package:code_cadette/Themes/ColorClass.dart';

class LearningGoalAlsDan extends StatefulWidget {
  final int vraagId;

  LearningGoalAlsDan({
    Key key,
    this.vraagId = 2,
  }) : super(key: key);

  @override
  _LearningGoalAlsDanState createState() => _LearningGoalAlsDanState();
}

class _LearningGoalAlsDanState extends State<LearningGoalAlsDan> {
  String vraagtekst = "Laden...";
  int vraagtypeKeyboard = 4;
  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    _retrieveQuestion(this.widget.vraagId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: StandardAppBar(
            color: ColorClass.alsDanAppBar, title: 'Als/dan-logica'),
        backgroundColor: ColorClass.alsDanBackground,
        body: Column(children: [
          SizedBox(
            height: 20,
          ),
          StandardFlatTextBox(
            backgroundcolor: ColorClass.alsDanSecondary,
            width: MediaQuery.of(context).size.width * 0.8,
            height: 200,
            content: vraagtekst,
          ),
          SizedBox(
            height: 40,
          ),
          AnswerBox(
              backgroundcolor: ColorClass.alsDanSecondary,
              vraagId: this.widget.vraagId,
              controller: _controller),
          Spacer(),
          LearningGoalAlsDanChoiceBox(
              lineColor: ColorClass.alsDanLineColor,
              backgroundColor: ColorClass.alsDanSecondary,
              questionType: vraagtypeKeyboard,
              controller: _controller,
              onTextInput: (myText) {
                _insertText(myText);
              }),
        ]));
  }

  void _insertText(String myText) {
    final text = _controller.text;
    final textSelection = _controller.selection;
    final newText = text.replaceRange(
      textSelection.start,
      textSelection.end,
      myText,
    );
    final myTextLength = myText.length;
    _controller.text = newText;
    _controller.selection = textSelection.copyWith(
      baseOffset: textSelection.start + myTextLength,
      extentOffset: textSelection.start + myTextLength,
    );
  }

  _retrieveQuestion(int vraagId) async {
    var questionState = await DatabaseModel.getVraag(vraagId);
    setState(() {
      vraagtekst = questionState.vraagtekst;
      vraagtypeKeyboard = questionState.vraagtypeKeyboard;
    });
  }
}
