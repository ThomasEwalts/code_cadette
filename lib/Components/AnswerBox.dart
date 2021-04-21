import 'package:flutter/material.dart';
import 'package:code_cadette/Model/DatabaseClasses/DatabaseClassLibrary.dart';

class AnswerBox extends StatefulWidget {
  final Color backgroundcolor;
  final List<Antwoord> antwoordList;

  AnswerBox({
    this.backgroundcolor,
    this.antwoordList
  });

  @override
  _AnswerBoxState createState() => _AnswerBoxState();
}

class _AnswerBoxState extends State<AnswerBox> {
  void initState(){
    
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(5),
        height: 100,
        width: MediaQuery.of(context).size.width * 0.8,
        decoration: BoxDecoration(
            color: widget.backgroundcolor,
            borderRadius: BorderRadius.all(Radius.circular(5))));
    // child: Text(content,
    //     style: TextStyle(
    //         fontSize: 16.0,
    //         fontFamily: 'Raleway',
    //         color: Colors.black,
    //         fontWeight: FontWeight.w600)));
  }
}
