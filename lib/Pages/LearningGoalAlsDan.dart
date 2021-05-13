import 'package:code_cadette/Components/AnswerBox.dart';
import 'package:code_cadette/Components/StandardComponentLibrary.dart';
import 'package:code_cadette/Components/ChoiceBoxKeyboard.dart';
import 'package:code_cadette/Model/AnswerModel.dart';
import 'package:code_cadette/Model/DatabaseModel.dart';
import 'package:code_cadette/Model/DynamicTextFieldModel.dart';
import 'package:flutter/material.dart';
import 'package:code_cadette/Themes/ColorClass.dart';
import 'package:provider/provider.dart';

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
  AnswerModel answerModel = new AnswerModel(correctAntwoordList: [], antwoordList: [] );

  @override
  void initState() {
    _retrieveQuestion(this.widget.vraagId);
    _retrieveAnswers(this.widget.vraagId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => DynamicTextFieldModel()),
      ],
      child: Scaffold(
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
              height: 100,
              content: vraagtekst,
            ),
            SizedBox(
              height: 40,
            ),
            AnswerBox(
              backgroundcolor: ColorClass.alsDanSecondary,
              vraagId: this.widget.vraagId,
              answerModel: answerModel,
            ),
            Spacer(),
            Consumer<DynamicTextFieldModel>(
                builder: (context, txtController, child) {
              return ChoiceBoxKeyboard(
                lineColor: ColorClass.alsDanLineColor,
                backgroundColor: ColorClass.alsDanSecondary,
                questionType: vraagtypeKeyboard,
                controller: txtController.textEditingController,
              );
            }),
          ])),
    );
  }

  _retrieveAnswers(int vraagId) async {
    AnswerModel _answerModel = new AnswerModel();
    _answerModel.correctAntwoordList =
        await DatabaseModel.getAntwoordList(vraagId);
    setState(() {
      answerModel = _answerModel;
    });
  }

  _retrieveQuestion(int vraagId) async {
    var questionState = await DatabaseModel.getVraag(vraagId);
    setState(() {
      vraagtekst = questionState.vraagtekst;
      vraagtypeKeyboard = questionState.vraagtypeKeyboard;
    });
  }
}