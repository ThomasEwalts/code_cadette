import 'package:code_cadette/Pages/ContentControlScreen.dart';
import 'package:code_cadette/Pages/LearningGoalAlsDan.dart';
import 'package:flutter/material.dart';
import 'package:code_cadette/Components/StandardComponentLibrary.dart';
import 'package:code_cadette/Themes/ColorClass.dart';
import 'package:code_cadette/Components/HomeScreenButton.dart';
import 'package:code_cadette/Pages/ExplanationScreen.dart';

//dit is de startpagina van de applicatie
class Homepage extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: StandardAppBar(
          color: ColorClass.mainScreenAppbar,
          title: 'CodeCadette',
        ),
        backgroundColor: ColorClass.mainScreenBackground,
        body: Center(
            child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          child: ListView(
            shrinkWrap: true,
            children: [
              HomeScreenButton(
                title: 'Als/dan-logica',
                destination: ExplanationScreen(
                  title: 'Als/dan-logica',
                  leerdoel: 1,
                  backgroundcolor: ColorClass.alsDanBackground,
                  secondarycolor: ColorClass.alsDanSecondary,
                  appbarcolor: ColorClass.alsDanAppBar,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ContentControlScreen()));
                  },
                ),
              ),
              HomeScreenButton(title: 'Binair rekenen'),
            ],
          ),
        )));
  }
}
