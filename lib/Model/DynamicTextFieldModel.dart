import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class DynamicTextFieldModel extends ChangeNotifier {
  TextEditingController _textEditingController;

  set textEditingController(TextEditingController newTextEditingController) {
    _textEditingController = newTextEditingController;
    notifyListeners();
  }

  TextEditingController get textEditingController => _textEditingController;
}
