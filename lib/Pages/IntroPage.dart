import 'package:code_cadette/Components/StandardComponentLibrary.dart';
import 'package:code_cadette/Model/DatabaseClasses/DatabaseClassLibrary.dart';
import 'package:code_cadette/Model/DatabaseModel.dart';
import 'package:code_cadette/Pages/LoadingScreen.dart';
import 'package:code_cadette/Themes/ColorClass.dart';
import 'package:flutter/material.dart';

import 'Homepage.dart';

class IntroPage extends StatefulWidget {
  IntroPage({
    Key key,
  }) : super(key: key);

  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  AppData appData;
  bool loading;

  @override
  void initState() {
    loading = true;
    super.initState();
    _retrieveAppData();
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return LoadingScreen(
        backgroundColor: ColorClass.mainScreenBackground,
      );
    } else if (!appData.firstStartUp) {
      return Homepage();
    } else {
      var controller = TextEditingController();

      return Scaffold(
          appBar: StandardAppBar(
            color: ColorClass.mainScreenAppbar,
            title: 'Welkom!',
            showBackButton: false,
          ),
          backgroundColor: ColorClass.mainScreenBackground,
          body: Center(
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                ),
                StandardFlatTextBox(
                    backgroundcolor: ColorClass.mainScreenSecondary,
                    padding: 20,
                    fontSize: 16,
                    width: MediaQuery.of(context).size.width * 0.8,
                    content:
                        'Welkom bij deze applicatie!\n\nHierin leer je wat basis programmeer concepten\n\nVoordat we beginnen wil ik graag weten hoe je heet:'),
                SizedBox(
                  height: 20,
                ),
                StandardTextField(
                  height: 30,
                  width: MediaQuery.of(context).size.width * 0.7,
                  fontColor: Colors.white,
                  cursorColor: Colors.white,
                  controller: controller,
                ),
                SizedBox(
                  height: 10,
                ),
                StandardTextButton(
                    textSize: 20.0,
                    title: 'Ga verder',
                    textColor: Colors.white,
                    onPressed: () =>
                        _buttonOnPressedFunction(context, controller.text)),
              ],
            ),
          ));
    }
  }

  _retrieveAppData() async {
    AppData _appData;
    _appData = await DatabaseModel.getAppData();
    if (mounted) {
      setState(() {
        appData = _appData;
        loading = false;
      });
    }
  }

  _buttonOnPressedFunction(BuildContext context, String name) {
    debugPrint(name);
    DatabaseModel.createUser(new User(name: name));
    DatabaseModel.setCurrentUser(1);
    DatabaseModel.setFirstStartUp(false);
    Navigator.pushReplacement(
        (context), MaterialPageRoute(builder: (context) => Homepage()));
  }
}
