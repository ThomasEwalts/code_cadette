import 'package:code_cadette/Components/StandardComponentLibrary.dart';
import 'package:code_cadette/Components/DynamicTextField.dart';
import 'package:code_cadette/Model/AnswerModel.dart';
import 'package:code_cadette/Model/DatabaseClasses/DatabaseClassLibrary.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AnswerBox extends StatefulWidget {
  final Color backgroundcolor;
  final int vraagId;
  final AnswerModel answerModel;

  AnswerBox({Key key, this.backgroundcolor, this.vraagId, this.answerModel})
      : super(key: key);

  @override
  _AnswerBoxState createState() => _AnswerBoxState();
}

class _AnswerBoxState extends State<AnswerBox> {
  List<Widget> widgetList = [Text('Laden...')];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var _answerModel = context.watch<AnswerModel>();

    _answerModel.initializeCorrectAntwoordList(
        this.widget.answerModel.correctAntwoordList);
    _answerModel.initializeAntwoordList(this.widget.answerModel.antwoordList);
    _createAnswerBoxContent(_answerModel);

    return Container(
        padding: EdgeInsets.all(5),
        height: 100,
        width: MediaQuery.of(context).size.width * 0.8,
        decoration: BoxDecoration(
            color: widget.backgroundcolor,
            borderRadius: BorderRadius.all(Radius.circular(5))),
        child: Container(
          child: Wrap(children: widgetList),
          height: 50,
        ));
  }

  _specificTextField(TextEditingController _controller, Antwoord _antwoord) {
    return DynamicTextField(
      width: 50,
      height: 25,
      readOnly: true,
      showCursor: true,
      controller: _controller,
    );
  }

  _createAnswerBoxContent(AnswerModel answerModel) {
    var answerList = answerModel.antwoordList;
    List<Widget> widgetListTemp = [];

    try {
      answerList.sort((a, b) => a.positie.compareTo(b.positie));

      answerList.forEach((antwoord) {
        if (antwoord.filledIn) {
          widgetListTemp.add(StandardFlatTextBox(
            content: antwoord.antwoord,
            fontSize: 20.0,
            height: 25,
            padding: 0,
          ));
        } else {
          var controller = new TextEditingController();
          controller.addListener(() {
            antwoord.antwoord = controller.text;
            debugPrint(antwoord.antwoord);
            answerModel.antwoordList[antwoord.positie - 1].antwoord =
                antwoord.antwoord;
          });
          widgetListTemp.add(_specificTextField(controller, antwoord));
        }
      });
    } catch (NoSuchMethod) {
      widgetListTemp = [Text('ERROR')];
    }

    widgetList = widgetListTemp;
  }
}
