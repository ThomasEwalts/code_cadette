import 'package:flutter/material.dart';
import 'package:code_cadette/Components/StandardAppBar.dart';
import 'package:code_cadette/Components/ColorClass.dart';
import 'package:code_cadette/Components/HomeScreenButton.dart';
import 'package:code_cadette/Pages/ExplanationScreen.dart';

//dit is de startpagina van de applicatie
class Homepage extends StatelessWidget{
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
              HomeScreenButton(title: 'Als/dan-logica', destination: ExplanationScreen(title: 'Als/dan-logica', backgroundcolor: ColorClass.alsDanBackground, secondarycolor: ColorClass.alsDanSecondary, appbarcolor: ColorClass.alsDanAppBar,),),
              HomeScreenButton(title: 'Binair rekenen'),
              HomeScreenButton(title: 'Klasses')
              ],
          ),
        )
      )
    );
  }
}
