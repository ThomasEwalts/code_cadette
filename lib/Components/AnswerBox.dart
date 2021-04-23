import 'package:code_cadette/Components/StandardComponentLibrary.dart';
import 'package:flutter/material.dart';
import 'package:code_cadette/Model/DatabaseModel.dart';

class AnswerBox extends StatefulWidget {
  final Color backgroundcolor;
  final int vraagId;
  final TextEditingController controller;

  AnswerBox({Key key, this.backgroundcolor, this.vraagId, this.controller}) : super(key: key);

  @override
  _AnswerBoxState createState() => _AnswerBoxState();
}

class _AnswerBoxState extends State<AnswerBox> {
  List<Widget> widgetList = [Text('Laden...')];

  @override
  void initState() {
    _createAnswerBoxContent(this.widget.vraagId);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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

  _createAnswerBoxContent(int vraagIdTemp) async {
    var databaseAnswerList = await DatabaseModel.getAntwoordList(vraagIdTemp);

    List<Widget> widgetListTemp = [];
    databaseAnswerList.sort((a, b) => a.positie.compareTo(b.positie));

    databaseAnswerList.forEach((antwoord) {
      if (antwoord.filledIn) {
        widgetListTemp.add(StandardFlatTextBox(
          content: antwoord.antwoord,
          fontSize: 12.0,
        ));
      } else {
        widgetListTemp.add(StandardTextField(
          width: 50,
          height: 20,
          readOnly: true,
          showCursor: true,
          controller: this.widget.controller,
        ));
      }
    });

    setState(() {
      widgetList = widgetListTemp;
    });
  }
}
