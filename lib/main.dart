import 'package:code_cadette/Model/DatabaseModel.dart';
import 'package:code_cadette/Pages/IntroPage.dart';
import 'package:code_cadette/Pages/LoadingScreen.dart';
import 'package:code_cadette/Themes/ColorClass.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

//Dit is het entrypoint van de applicatie
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
        future: DatabaseModel.setDatabase(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return MaterialApp(
                title: 'CodeCadette',
                home: LoadingScreen(
                  backgroundColor: ColorClass.mainScreenBackground,
                ));
          } else {
            return MaterialApp(
              title: 'CodeCadette',
              home: IntroPage(),
            );
          }
        });
  }
}
