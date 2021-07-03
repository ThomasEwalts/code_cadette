import 'package:code_cadette/Components/StandardComponentLibrary.dart';
import 'package:flutter/material.dart';
import 'package:code_cadette/Model/DatabaseModel.dart';

//deze class bevat het screen tussen het hoofdmenu en de leerdoelen, waarin uitleg wordt gegeven over het leerdoel, de uitleg wordt uit de SQLite database gehaald
class ExplanationScreen extends StatefulWidget {
  final String title;
  final Color backgroundcolor;
  final Color secondarycolor;
  final Color appbarcolor;
  final Function onPressed;
  final int leerdoel;

  ExplanationScreen(
      {Key key,
      this.title,
      this.backgroundcolor,
      this.secondarycolor,
      this.appbarcolor,
      this.onPressed,
      this.leerdoel})
      : super(key: key);

  @override
  _ExplanationScreenState createState() => _ExplanationScreenState();
}

class _ExplanationScreenState extends State<ExplanationScreen> {
  String leerdoelExplanation = "Laden...";

  @override
  void initState() {
    _retrieveExplanation(this.widget.leerdoel);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StandardAppBar(
        color: widget.appbarcolor,
        title: this.widget.title,
      ),
      body: Center(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          StandardFlatTextBox(
            content: leerdoelExplanation,
            backgroundcolor: widget.secondarycolor,
            height: MediaQuery.of(context).size.height * 0.6,
            width: MediaQuery.of(context).size.width * 0.8,
          ),
          SizedBox(
            height: 20,
          ),
          StandardTextButton(
            title: 'Ga verder',
            width: 100,
            onPressed: this.widget.onPressed,
            textColor: Colors.white,
            textSize: 20.0,
            splashColor: Colors.white,
            border: Border(
                bottom: BorderSide(
              width: 1.0,
              color: Colors.white,
            )),
          )
        ],
      )),
      backgroundColor: widget.backgroundcolor,
    );
  }

  _retrieveExplanation(int leerdoel) async {
    try {
      var leerdoelState = await DatabaseModel.getLeerDoel(leerdoel);
      setState(() {
        leerdoelExplanation = leerdoelState.explanation;
      });
    } catch (NoSuchMethod) {
      setState(() {
        leerdoelExplanation = "Database connection error. Please contact the developer";
      });
    }
  }
}
