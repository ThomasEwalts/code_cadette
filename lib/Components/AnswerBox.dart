import 'package:code_cadette/Components/StandardComponentLibrary.dart';
import 'package:code_cadette/Model/AnswerModel.dart';
import 'package:flutter/material.dart';

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
    _createAnswerBoxContent(this.widget.vraagId);
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

  _specificTextField(TextEditingController _controller) {
    return StandardTextField(
      width: 50,
      height: 25,
      readOnly: true,
      showCursor: true,
      controller: _controller,
    );
  }

  _createAnswerBoxContent(int vraagIdTemp) {
    var answerList = this.widget.answerModel.correctAntwoordList;
    List<Widget> widgetListTemp = [];
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

        widgetListTemp.add(_specificTextField(controller));
      }
    });

    setState(() {
      widgetList = widgetListTemp;
    });
  }
}
