import 'package:code_cadette/Components/StandardComponentLibrary.dart';
import 'package:code_cadette/Themes/ColorClass.dart';
import 'package:flutter/material.dart';

class LearningGoalCompletedScreen extends StatelessWidget {
  final int leerdoelId;

  LearningGoalCompletedScreen({Key key, this.leerdoelId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color appBarColor;
    Color backgroundColor;

    switch (leerdoelId) {
      case 1:
        {
          appBarColor = ColorClass.alsDanAppBar;
          backgroundColor = ColorClass.alsDanBackground;
        }
        break;
      case 2:
        {
          appBarColor = ColorClass.binairAppBarr;
          backgroundColor = ColorClass.binairBackground;
        }
    }

    return Scaffold(
      appBar: StandardAppBar(showBackButton: false, title: 'Uitgeleerd!', color: appBarColor,),
      backgroundColor: backgroundColor,
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 100,), 
            StandardFlatTextBox(
              padding: 20, 
              fontSize: 16, 
              width:  MediaQuery.of(context).size.width * 0.8, 
              height: 150,
              content: "Goed gedaan! je hebt het leerdoel afgerond",
              backgroundcolor: Color(0xff42FF94),),
            Spacer(),
            StandardTextButton(
              title: 'Ga naar hoofdmenu',
              textColor: Colors.white,
              width: 200,
              textSize: 20,
              border: Border(bottom: BorderSide(width: 1, color: Colors.white)),
              onPressed: () => Navigator.of(context).popUntil((route) => route.isFirst),
            ),
            SizedBox(
              height: 50,
            )
            ],)
      )
    );
  }
}
