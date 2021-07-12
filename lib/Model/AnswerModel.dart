import 'package:code_cadette/Model/DatabaseClasses/Antwoord.dart';
import 'package:flutter/foundation.dart';

class AnswerModel extends ChangeNotifier {
  List<Antwoord> _correctAntwoordList;
  List<Antwoord> _antwoordList;

  set correctAntwoordList(List<Antwoord> newCorrectAntwoordList) {
    _correctAntwoordList = newCorrectAntwoordList;
    notifyListeners();
  }

  set antwoordList(List<Antwoord> newAntwoordList) {
    _antwoordList = newAntwoordList;
    notifyListeners();
  }

  List<Antwoord> get correctAntwoordList => _correctAntwoordList;
  List<Antwoord> get antwoordList => _antwoordList;

  void initializeCorrectAntwoordList(List<Antwoord> initCorrectAntwoordList) {
    _correctAntwoordList = initCorrectAntwoordList;
  }

  void initializeAntwoordList(List<Antwoord> initAntwoordList) {
    _antwoordList = initAntwoordList;
  }

  bool checkAnswers() {
    bool correct = true;

    _correctAntwoordList.forEach((correctAnswer) {
      if (!(correctAnswer.antwoord ==
          _antwoordList[correctAnswer.positie - 1].antwoord)) {
        correct = false;
      }
    });
    return correct;
  }
}
