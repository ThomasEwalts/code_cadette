import 'package:code_cadette/Components/AnswerBox.dart';
import 'package:code_cadette/Components/StandardComponentLibrary.dart';
import 'package:code_cadette/Components/ChoiceBoxKeyboard.dart';
import 'package:code_cadette/Model/AnswerModel.dart';
import 'package:code_cadette/Model/DynamicTextFieldModel.dart';
import 'package:flutter/material.dart';
import 'package:code_cadette/Themes/ColorClass.dart';
import 'package:provider/provider.dart';

class LearningGoalAlsDan extends StatelessWidget {
  final int vraagId;
  final AnswerModel answerModel;
  final String vraagtekst;
  final int vraagtypekeyboard;

  LearningGoalAlsDan({
    Key key,
    this.vraagId = 2,
    this.answerModel,
    this.vraagtekst,
    this.vraagtypekeyboard
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => DynamicTextFieldModel()),
        ChangeNotifierProvider(create: (context) => AnswerModel())
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
              vraagId: vraagId,
              answerModel: answerModel,
            ),
            Spacer(),
            Consumer2<DynamicTextFieldModel, AnswerModel>(
                builder: (context, txtController, _answerModel, child) {
              return ChoiceBoxKeyboard(
                lineColor: ColorClass.alsDanLineColor,
                backgroundColor: ColorClass.alsDanSecondary,
                questionType: vraagtypekeyboard,
                controller: txtController.textEditingController,
                answerModel: _answerModel,
              );
            }),
          ])),
    );
  }
}
