import 'package:flutter/material.dart';

class GameScreen extends StatelessWidget {
  Widget build(context) {
    return Container(
      margin: EdgeInsets.all(0.0),
      child: new Stack(
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 3,
                child: Image.asset(
                  'assets/images/left.png',
                  fit: BoxFit.cover,
                ),
              ),
              AspectRatio(
                aspectRatio: 1.75333,
                child: Image.asset('assets/images/main.png'),
              ),
              Expanded(
                flex: 3,
                child: Image.asset(
                  'assets/images/right.png',
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
          new Center(
            child: new Text(
              "Hello",
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}
