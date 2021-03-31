import 'package:flutter/material.dart';
import 'package:code_cadette/Components/StandardAppBar.dart';
import 'package:code_cadette/Components/ColorClass.dart';
import 'package:code_cadette/Components/HomeScreenButton.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
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
            children: [
              HomeScreenButton(title: 'Als/dan-logica'),
              HomeScreenButton(title: 'Binair rekenen'),
              HomeScreenButton(title: 'Klasses')
              ],
          ),
        )
      )
    );
  }
}
