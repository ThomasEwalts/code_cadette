import 'package:code_cadette/Pages/LearningGoalAlsDan.dart';
import 'package:code_cadette/Pages/LoadingScreen.dart';
import 'package:flutter/material.dart';
import 'package:code_cadette/Model/DatabaseModel.dart';
import 'package:code_cadette/Model/AnswerModel.dart';
import 'package:code_cadette/Model/DatabaseClasses/DatabaseClassLibrary.dart';

class ContentControlScreen extends StatefulWidget {
  final int vraagId;
  final int leerDoel;

  ContentControlScreen({Key key, this.vraagId = 2, this.leerDoel})
      : super(key: key);

  @override
  _ContentControlScreenState createState() => _ContentControlScreenState();
}

class _ContentControlScreenState extends State<ContentControlScreen> {
  bool loaded = false;
  AnswerModel answerModel;
  String vraagtekst;
  int vraagtypeKeyboard;
  List<Vraag> vraaglistLeerdoel;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance
        .addPostFrameCallback((_) => _retrieveAnswers(this.widget.vraagId));
  }

  @override
  Widget build(BuildContext context) {
    return loaded ? _learningGoal(this.widget.leerDoel) : LoadingScreen();
  }

  _retrieveVraagList(int leerdoel) async {
    List<Vraag> _vraaglistLeerdoel;

    _vraaglistLeerdoel = await DatabaseModel.getVraagListForLeerdoel(leerdoel);

    return _vraaglistLeerdoel;
  }

  _learningGoal(int leerdoel) {
    return LearningGoalAlsDan(
      answerModel: answerModel,
      vraagtekst: vraagtekst,
      vraagtypekeyboard: vraagtypeKeyboard,
      leerDoel: leerdoel,
    );
  }

  _retrieveAnswers(int vraagId) async {
    AnswerModel _answerModel = new AnswerModel();

    _answerModel.correctAntwoordList =
        await DatabaseModel.getAntwoordList(vraagId);

    var questionState = await DatabaseModel.getVraag(vraagId);

    _answerModel.antwoordList = [];

    _answerModel.correctAntwoordList.forEach((antwoord) {
      _answerModel.antwoordList.add(new Antwoord(
          id: antwoord.id,
          vraagId: antwoord.vraagId,
          positie: antwoord.positie,
          filledIn: antwoord.filledIn,
          antwoord: antwoord.filledIn == true ? antwoord.antwoord : ""));
    });

    setState(() {
      answerModel = _answerModel;
      vraagtekst = questionState.vraagtekst;
      vraagtypeKeyboard = questionState.vraagtypeKeyboard;
      loaded = true;
    });
  }
}
