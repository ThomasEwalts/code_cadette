import 'package:code_cadette/Model/DatabaseModel.dart';
import 'package:code_cadette/Pages/IntroPage.dart';
import 'package:code_cadette/Pages/LoadingScreen.dart';
import 'package:code_cadette/Themes/ColorClass.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sqflite/sqlite_api.dart';

//Dit is het entrypoint van de applicatie
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) => runApp(MyApp()));
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _initialized = false;
  bool _error = false;

  void initializeDatabase() async {
    if (kIsWeb) {
      //await Firebase.initializeApp();
      await DatabaseModel().setDatabase();
      setState(() {
        _initialized = true;
      });
    } else {
      await DatabaseModel().setDatabase();
      setState(() {
        _initialized = true;
      });
    }
  }

  @override
  void initState() {
    initializeDatabase();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    if (!_initialized) {
      return MaterialApp(
          title: 'CodeCadette',
          home: LoadingScreen(
            backgroundColor: ColorClass.mainScreenBackground,
          ));
    }

    return MaterialApp(title: 'CodeCadette', home: IntroPage());
  }
}
