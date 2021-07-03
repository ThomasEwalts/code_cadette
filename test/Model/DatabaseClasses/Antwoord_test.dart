import 'package:flutter_test/flutter_test.dart';
import 'package:code_cadette/Model/DatabaseClasses/Antwoord.dart';

void main() {
  test(
      'ANTWOORD: Als in de constructor de waarden: 1, 2, 3, "testantwoord", true worden ingevuld dan moeten deze ook terugkomen in de nieuwe variabele',
      () async {
    //Arrange
    var testantwoord = Antwoord(
        id: 1,
        vraagId: 2,
        positie: 3,
        antwoord: 'testantwoord',
        filledIn: true);

    //Assert

    expect(testantwoord.id, 1);
    expect(testantwoord.vraagId, 2);
    expect(testantwoord.positie, 3);
    expect(testantwoord.antwoord, 'testantwoord');
    expect(testantwoord.filledIn, true);
  });
}
