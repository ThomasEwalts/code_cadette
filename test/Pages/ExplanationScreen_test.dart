import 'package:code_cadette/Components/StandardComponentLibrary.dart';
import 'package:code_cadette/Pages/ContentControlScreen.dart';
import 'package:code_cadette/Pages/ExplanationScreen.dart';
import 'package:code_cadette/Pages/GameScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

void main() {
  group('EXPLANATIONSCREEN', () {
    testWidgets('Controleer of explanationscreen alle correcte widgets toont',
        (tester) async {
      await tester
          .pumpWidget(new MaterialApp(home: ExplanationScreen(title: 'test')));

      expect(find.byType(StandardFlatTextBox), findsOneWidget);
      expect(find.byType(StandardTextButton), findsOneWidget);
      expect(find.byType(StandardAppBar), findsOneWidget);
    });

    testWidgets('Controleer of navigation naar ContentControlScreen werkt',
        (tester) async {
      final mockObserver = MockNavigatorObserver();

      await tester.pumpWidget(new MaterialApp(
        home: ExplanationScreen(
          title: 'test',
          onPressed: () {
                    Navigator.push(
                        tester.element(find.byType(Scaffold)),
                        MaterialPageRoute(
                            builder: (context) => ContentControlScreen(
                                  leerdoelId: 1,
                                )));
                  },),
        navigatorObservers: [mockObserver],
      ));

      await tester.tap(find.byType(StandardTextButton));
      await tester.pumpAndSettle();
      verify(mockObserver.didPush(any, any));

      expect(find.byType(GameScreen), findsOneWidget);
    });
  });
}
