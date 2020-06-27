import 'package:flutter/material.dart';

class GameScreen extends StatelessWidget {
  Widget build(context) {
    return Container(
      child: new Stack(
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
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
                child: Image.asset(
                  'assets/images/right.png',
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
          new Center(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 1.0, horizontal: 20.0),
              margin: EdgeInsets.symmetric(vertical: 1.0, horizontal: 25.0),
              child: AspectRatio(
                aspectRatio: 1.75333,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        FlatButton(
                          onPressed: () => {},
                          padding: EdgeInsets.all(0.0),
                          child: Image.asset('assets/images/button_info.png'),
                        ),
                        FlatButton(
                          onPressed: () => {},
                          padding: EdgeInsets.all(0.0),
                          child: Image.asset(
                              'assets/images/display_steps_and_status.png'),
                        ),
                        FlatButton(
                          onPressed: () => {},
                          padding: EdgeInsets.all(0.0),
                          child: Image.asset('assets/images/button_done.png'),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            FlatButton(
                              onPressed: () => {},
                              padding: EdgeInsets.all(0.0),
                              child:
                                  Image.asset('assets/images/button_run.png'),
                            ),
                            FlatButton(
                              onPressed: () => {},
                              padding: EdgeInsets.all(0.0),
                              child: Image.asset(
                                  'assets/images/button_next_step.png'),
                            ),
                            FlatButton(
                              onPressed: () => {},
                              padding: EdgeInsets.all(0.0),
                              child: Image.asset(
                                  'assets/images/button_restart.png'),
                            ),
                            FlatButton(
                              onPressed: () => {},
                              padding: EdgeInsets.all(0.0),
                              child:
                                  Image.asset('assets/images/display_goal.png'),
                            ),
                            FlatButton(
                              onPressed: () => {},
                              padding: EdgeInsets.all(0.0),
                              child: Image.asset(
                                  'assets/images/display_output.png'),
                            ),
                          ],
                        ),
                        Expanded(
                          child: AspectRatio(
                            aspectRatio: 1.56,
                            child: Image.asset('assets/images/board.png'),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        FlatButton(
                          onPressed: () => {},
                          padding: EdgeInsets.all(0.0),
                          child: Image.asset('assets/images/button_exit.png'),
                        ),
                        FlatButton(
                          onPressed: () => {},
                          padding: EdgeInsets.all(0.0),
                          child: Image.asset('assets/images/button_info.png'),
                        ),
                        FlatButton(
                          onPressed: () => {},
                          padding: EdgeInsets.all(0.0),
                          child: Image.asset('assets/images/button_info.png'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
