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
  final int leerDoel;

  LearningGoalAlsDan(
      {Key key,
      this.vraagId = 2,
      this.answerModel,
      this.vraagtekst,
      this.vraagtypekeyboard,
      this.leerDoel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color appBarColor;
    Color backgroundColor;
    Color secondaryColor;
    Color linecolorColor;

    switch (leerDoel) {
      case 1:
        {
          appBarColor = ColorClass.alsDanAppBar;
          backgroundColor = ColorClass.alsDanBackground;
          secondaryColor = ColorClass.alsDanSecondary;
          linecolorColor = ColorClass.alsDanLineColor;
        }
        break;
      case 2:
        {
          appBarColor = ColorClass.binairAppBarr;
          backgroundColor = ColorClass.binairBackground;
          secondaryColor = ColorClass.binairSecondary;
          linecolorColor = ColorClass.binairLineColor;
        }
        break;
    }

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => DynamicTextFieldModel()),
        ChangeNotifierProvider(create: (context) => AnswerModel())
      ],
      child: Scaffold(
          appBar: StandardAppBar(
              color: appBarColor, title: 'Als/dan-logica'),
          backgroundColor: backgroundColor,
          body: Column(children: [
            SizedBox(
              height: 20,
            ),
            StandardFlatTextBox(
              backgroundcolor: secondaryColor,
              width: MediaQuery.of(context).size.width * 0.8,
              height: 100,
              content: vraagtekst,
            ),
            SizedBox(
              height: 40,
            ),
            AnswerBox(
              backgroundcolor: secondaryColor,
              vraagId: vraagId,
              answerModel: answerModel,
            ),
            Spacer(),
            Consumer2<DynamicTextFieldModel, AnswerModel>(
                builder: (context, txtController, _answerModel, child) {
              return ChoiceBoxKeyboard(
                lineColor: linecolorColor,
                backgroundColor: secondaryColor,
                questionType: vraagtypekeyboard,
                controller: txtController.textEditingController,
                answerModel: _answerModel,
              );
            }),
          ])),
    );
  }
}
