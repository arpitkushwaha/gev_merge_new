import 'package:flutter/material.dart';
import 'package:gev_app/views/home.dart';

class FloatingHomeButton extends StatefulWidget {
  @override
  _FloatingHomeButtonState createState() => _FloatingHomeButtonState();
}

class _FloatingHomeButtonState extends State<FloatingHomeButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 15),
      child: new FloatingActionButton(
        elevation: 0.0,
        child: Padding(
          padding: const EdgeInsets.all(2),
          child: Image.asset(
            "assets/icons/home.png",
            scale: 0.7,
          ),
        ),
        backgroundColor: Colors.amber[300],
        onPressed: () {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => MyHomePage()));
        },
      ),
    );
  }
}
