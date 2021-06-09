import 'package:code_cadette/Model/DatabaseModel.dart';
import 'package:code_cadette/Pages/Homepage.dart';
import 'package:flutter/material.dart';

//Dit is het entrypoint van de applicatie
void main() {
  runApp(MyApp());
  DatabaseModel.setDatabase();
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CodeCadette',
      home: Homepage(),
    );
  }
}
