import 'package:code_cadette/Model/DatabaseClasses/Antwoord.dart';
import 'package:flutter/foundation.dart';

class AnswerModel {
  List<Antwoord> correctAntwoordList;
  List<Antwoord> antwoordList;

  AnswerModel(
      {this.correctAntwoordList, this.antwoordList});

  bool checkAnswers() {
    return listEquals(correctAntwoordList, antwoordList);
  }
}
