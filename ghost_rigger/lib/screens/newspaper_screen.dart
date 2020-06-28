import 'package:flutter/material.dart';

class NewspaperScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.expand(),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/newspaper.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: OutlineButton(
        padding: EdgeInsets.all(0.0),
        onPressed: () => Navigator.pop(context),
        borderSide: BorderSide(color: Colors.cyanAccent),
        shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(0.0)),
        child: null,
      ),
    );
  }
}
