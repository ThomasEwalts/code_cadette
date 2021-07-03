import 'package:flutter_test/flutter_test.dart';
import 'package:code_cadette/Model/DatabaseClasses/Leerdoel.dart';

void main() {
  test(
      'LEERDOEL: Als in de constructor de waarden: 1, "testleerdoel", "testuitleg", worden ingevuld dan moeten deze ook terugkomen in de nieuwe variabele',
      () async {
    //Arrange
    var testleerdoel = Leerdoel(
        id: 1,
        name: 'testleerdoel',
        explanation: 'testuitleg');

    //Assert

    expect(testleerdoel.id, 1);
    expect(testleerdoel.name, 'testleerdoel');
    expect(testleerdoel.explanation, 'testuitleg');
  });
}
