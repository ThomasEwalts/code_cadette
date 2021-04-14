import 'package:code_cadette/Components/StandardFlatTextBox.dart';
import 'package:code_cadette/Components/StandardAppBar.dart';
import 'package:code_cadette/Components/StandardTextButton.dart';
import 'package:flutter/material.dart';
import 'package:code_cadette/Model/DatabaseModel.dart';

//deze class bevat het screen tussen het hoofdmenu en de leerdoelen, waarin uitleg wordt gegeven over het leerdoel, de uitleg wordt uit de SQLite database gehaald
class ExplanationScreen extends StatelessWidget {
  final String title;
  final Color backgroundcolor;
  final Color secondarycolor;
  final Color appbarcolor;

  ExplanationScreen(
      {this.title,
      this.backgroundcolor,
      this.secondarycolor,
      this.appbarcolor});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StandardAppBar(
        color: appbarcolor,
        title: this.title,
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            StandardFlatTextBox(content: DataBaseModel.lorumIpsum, backgroundcolor: secondarycolor, height: MediaQuery.of(context).size.height * 0.6, width: MediaQuery.of(context).size.width * 0.8,),
            SizedBox(height: 20,),
            StandardTextButton(title: 'Ga verder', onPressed: null, backgroundColor: appbarcolor, textcolor: Colors.white,)
          ],
        )
      ),
      backgroundColor: backgroundcolor,
    );
  }
}
