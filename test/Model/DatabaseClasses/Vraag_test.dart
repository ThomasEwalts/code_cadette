import 'package:flutter_test/flutter_test.dart';
import 'package:code_cadette/Model/DatabaseClasses/Vraag.dart';

void main() {
  test(
      'VRAAG: Als in de constructor de waarden: 1, 2, 3, "testvraag" worden ingevuld dan moeten deze ook terugkomen in de nieuwe variabele',
      () async {
    //Arrange
    var testvraag = Vraag(
        id: 1,
        leerdoelId: 2,
        vraagtypeKeyboard: 3,
        vraagtekst: 'testvraag');

    //Assert

    expect(testvraag.id, 1);
    expect(testvraag.leerdoelId, 2);
    expect(testvraag.vraagtypeKeyboard, 3);
    expect(testvraag.vraagtekst, 'testvraag');
  });
}
