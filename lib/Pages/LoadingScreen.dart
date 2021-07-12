import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {
  final Color backgroundColor;

  LoadingScreen({
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [CircularProgressIndicator(color: Colors.white,), Text("Loading", style: TextStyle(color: Colors.white),)],
        ),
      ),
    );
  }
}
