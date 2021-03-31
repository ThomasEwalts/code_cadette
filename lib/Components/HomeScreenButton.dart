import 'package:flutter/material.dart';
import 'package:code_cadette/Components/ColorClass.dart';


//Deze klasse bevat de homescreen buttons voor de verschillende leerdoelen
class HomeScreenButton extends StatelessWidget {
  final String title;
  final Widget destination; //linkt de juiste page

  HomeScreenButton({this.title, this.destination});
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () => debugPrint('testtrigger'),
        child: Container(
          padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
          child: SizedBox(
            height: 200,
            child: DecoratedBox(
              decoration: BoxDecoration(
                  color: ColorClass.mainScreenButtonBackground,
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              child: Center(
                  child: Text(
                this.title,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 40.0, fontFamily: 'NickelodeonNF'),
              )),
            ),
          ),
        ));
  }
}
