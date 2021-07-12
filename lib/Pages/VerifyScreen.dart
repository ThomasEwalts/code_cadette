import 'package:code_cadette/Components/StandardComponents/StandardAppBar.dart';
import 'package:code_cadette/Components/StandardComponentLibrary.dart';
import 'package:code_cadette/Themes/ColorClass.dart';
import 'package:flutter/material.dart';

class VerifyScreen extends StatelessWidget {
  final bool verify;
  final Function onPressed;
  final int leerdoelId;

  VerifyScreen({Key key, this.verify, this.onPressed, this.leerdoelId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color appBarColor;
    Color backgroundColor;
    Color secondaryColor;

    switch (leerdoelId) {
      case 1:
        {
          appBarColor = ColorClass.alsDanAppBar;
          backgroundColor = ColorClass.alsDanBackground;
          secondaryColor = ColorClass.alsDanSecondary;
        }
        break;
      case 2:
        {
          appBarColor = ColorClass.binairAppBarr;
          backgroundColor = ColorClass.binairBackground;
          secondaryColor = ColorClass.binairSecondary;
        }
        break;
    }


    return Scaffold(
        appBar: StandardAppBar(
          color: appBarColor,
          title: verify ? "Succes!" : "Jammer!",
          showBackButton: false,
        ),
        backgroundColor: backgroundColor,
        body: Center(
          child: Column(
            children: [
              SizedBox(height: 100),
              StandardFlatTextBox(
                padding: 20,
                fontSize: 16,
                width: MediaQuery.of(context).size.width * 0.8,
                height: 150,
                content: verify
                    ? "Heel goed! klik op verder om naar de volgende vraag te gaan"
                    : "Helaas, het antwoord is niet goed, druk op knop om het opnieuw te proberen",
                backgroundcolor: secondaryColor,
              ),
              Spacer(),
              StandardTextButton(
                title: verify ? "Volgende opgave" : "Opnieuw",
                textColor: Colors.white,
                width: 200,
                textSize: 20,
                border:
                    Border(bottom: BorderSide(width: 1, color: Colors.white)),
                onPressed: onPressed,
              ),
              SizedBox(
                height: 50,
              )
            ],
          ),
        ));
  }
}
