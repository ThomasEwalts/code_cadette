import 'package:flutter/material.dart';
import 'package:code_cadette/Themes/ColorClass.dart';

//Deze bevat de homescreen button voor de verschillende leerdoelen
class HomeScreenButton extends StatelessWidget {
  final String title;
  final Widget destination; //linkt de juiste page

  HomeScreenButton({this.title, this.destination});
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => this.destination,
              ));
        },
        child: Container(
          padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.2,
            child: DecoratedBox(
              decoration: BoxDecoration(
                  color: ColorClass.mainScreenSecondary,
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
