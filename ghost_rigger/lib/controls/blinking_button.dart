import 'package:flutter/material.dart';

class BlinkingButton extends StatefulWidget {
  @override
  _BlinkingButtonState createState() => _BlinkingButtonState();

  Function onPressed;
  BlinkingButton(this.onPressed) {}
}

class _BlinkingButtonState extends State<BlinkingButton>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  @override
  void initState() {
    _animationController =
        new AnimationController(vsync: this, duration: Duration(seconds: 1));
    _animationController.repeat();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animationController,
      child: OutlineButton(
        padding: EdgeInsets.all(12.0),
        onPressed: () => widget.onPressed?.call(),
        borderSide: BorderSide(color: Colors.cyanAccent),
        shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(0.0)),
        child: Text(
          'Send',
          style: TextStyle(
            color: Colors.cyanAccent,
            fontFamily: 'JetBrainsMono',
            fontSize: 20.0,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
