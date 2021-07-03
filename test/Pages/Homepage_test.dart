import 'package:code_cadette/Components/StandardComponents/StandardAppBar.dart';
import 'package:code_cadette/Pages/ExplanationScreen.dart';
import 'package:flutter/material.dart';
import 'package:code_cadette/Components/HomeScreenButton.dart';
import 'package:code_cadette/Pages/Homepage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

void main() {
  group('HOMEPAGE', () {
    testWidgets(
        'Controleer of homepage alle correcte widgets toont (2 HomescreenButtons, 1 StandardAppBar)',
        (tester) async {

      await tester.pumpWidget(new MaterialApp(
        home: Homepage(),
      ));

      expect(find.byType(HomeScreenButton), findsNWidgets(2));
      expect(find.byType(StandardAppBar), findsOneWidget);

    });

    testWidgets('Controleer of navigation naar ExplanationScreen werkt',
        (tester) async {
      final mockObserver = MockNavigatorObserver();

      await tester.pumpWidget(new MaterialApp(
        home: Homepage(),
        navigatorObservers: [mockObserver],
      ));

      await tester.tap(find.byKey(Homepage.navigateToExplanationKey).last);
      await tester.pumpAndSettle();
      verify(mockObserver.didPush(any, any));

      expect(find.byType(ExplanationScreen), findsOneWidget);   
    });
  });
}
