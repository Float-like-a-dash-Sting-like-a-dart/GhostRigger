import 'package:flutter/material.dart';

class GameScreen extends StatelessWidget {
  Widget build(context) {
    return Container(
      margin: EdgeInsets.all(0.0),
      child: new Stack(
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/left.png',
                fit: BoxFit.fill,
              ),
              AspectRatio(
                aspectRatio: 1.6,
                child: Image.asset('assets/images/main.png'),
              ),
              Image.asset(
                'assets/images/right.png',
                fit: BoxFit.fill,
              ),
            ],
          ),
          new Center(
            child: new Text("Hello "),
          )
        ],
      ),
    );
  }
}
