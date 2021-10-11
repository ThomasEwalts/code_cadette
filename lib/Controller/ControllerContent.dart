import 'package:code_cadette/Model/DatabaseModel.dart';
import 'package:code_cadette/Pages/GameScreen.dart';
import 'package:code_cadette/Pages/LearningGoalCompletedScreen.dart';
import 'package:code_cadette/Pages/LoadingScreen.dart';
import 'package:code_cadette/Pages/VerifyScreen.dart';
import 'package:code_cadette/Themes/ColorClass.dart';
import 'package:flutter/material.dart';
import 'package:code_cadette/Model/AnswerModel.dart';
import 'package:code_cadette/Model/DatabaseClasses/DatabaseClassLibrary.dart';

class ControllerContent extends StatefulWidget {
  final int vraagId;
  final int leerdoelId;
  final DatabaseModel db = DatabaseModel();

  ControllerContent({Key key, this.vraagId, this.leerdoelId}) : super(key: key);

  @override
  _ControllerContentState createState() => _ControllerContentState();
}

class _ControllerContentState extends State<ControllerContent> {
  AnswerModel answerModel;
  User user;
  String vraagtekst;
  int vraagtypeKeyboard;
  int vraagListPosition;
  int vraagListLengthAdjusted;
  List<Vraag> vraaglistLeerdoel;
  bool verify;

  int gameState;

  /*
  GameStates:
  0 = loading
  1 = playing
  2 = checking
  3 = learning goal completed
  */

  @override
  void initState() {
    super.initState();
    vraagListPosition = 0;
    gameState = 0;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeUserVraagAntwoord();
    });
  }

  @override
  Widget build(BuildContext context) {
    Color loadingScreenBackground;

    switch (this.widget.leerdoelId) {
      case 1:
        loadingScreenBackground = ColorClass.alsDanBackground;
        break;
      case 2:
        loadingScreenBackground = ColorClass.binairBackground;
        break;
    }

    switch (gameState) {
      case 0:
        return LoadingScreen(
          backgroundColor: loadingScreenBackground,
        );
      case 1:
        return _learningGoal(this.widget.leerdoelId);
      case 2:
        {
          if (verify) {
            return VerifyScreen(
                leerdoelId: this.widget.leerdoelId,
                verify: true,
                onPressed: () {
                  setState(() {
                    gameState = 0;
                    vraagListPosition++;
                    _retrieveAnswers(vraaglistLeerdoel[vraagListPosition].id);
                  });
                });
          } else {
            return VerifyScreen(
                leerdoelId: this.widget.leerdoelId,
                verify: false,
                onPressed: () {
                  setState(() {
                    gameState = 1;
                  });
                });
          }
        }
        break;
      case 3:
        return LearningGoalCompletedScreen(leerdoelId: this.widget.leerdoelId);
      default:
        return LoadingScreen();
    }
  }

  _initializeUserVraagAntwoord() async {
    User _user = await this.widget.db.getCurrentUser();
    user = _user;

    switch (this.widget.leerdoelId) {
      case 1:
        vraagListPosition = _user.alsDanPosition;
        break;
      case 2:
        vraagListPosition = _user.binairPosition;
        break;
      default:
        debugPrint('error: ' + this.widget.leerdoelId.toString());
    }

    _retrieveVraagList(this.widget.leerdoelId);
  }

  _learningGoal(int leerdoel) {
    return GameScreen(
      answerModel: answerModel,
      vraagtekst: vraagtekst,
      vraagtypekeyboard: vraagtypeKeyboard,
      leerdoelId: leerdoel,
      enterOnPressedTrue: _verifyTrue,
      enterOnPressedFalse: _verifyFalse,
    );
  }

  _verifyFalse() {
    setState(() {
      gameState = 2;
      verify = false;
    });
  }

  _verifyTrue() {
    if (vraagListPosition < vraagListLengthAdjusted) {
      switch (this.widget.leerdoelId) {
        case 1:
          user.alsDanPosition++;
          break;
        case 2:
          user.binairPosition++;
          break;
      }
      this.widget.db.updateUser(user);
      setState(() {
        gameState = 2;
        verify = true;
      });
    } else {
      setState(() {
        gameState = 3;
      });
    }
  }

  _retrieveVraagList(int leerdoel) async {
    List<Vraag> _vraaglistLeerdoel;
    _vraaglistLeerdoel = await this.widget.db.getVraagListForLeerdoel(leerdoel);
    vraagListLengthAdjusted = _vraaglistLeerdoel.length - 1;

    vraaglistLeerdoel = _vraaglistLeerdoel;

    debugPrint(vraagListPosition.toString());

    _retrieveAnswers(vraaglistLeerdoel[vraagListPosition].id);
  }

  _retrieveAnswers(int vraagId) async {
    try {
      AnswerModel _answerModel = new AnswerModel();

      _answerModel.correctAntwoordList =
          await this.widget.db.getAntwoordList(vraagId);

      var questionState = await this.widget.db.getVraag(vraagId);

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
        gameState = 1;
      });
    } catch (noSuchMethod) {
      setState(() {
        vraagtekst =
            'A database error has ocurred, please contact the developer';
        gameState = 1;
        answerModel = new AnswerModel();
      });
    }
  }
}
