import 'package:flutter/material.dart';
import 'dart:async';

class ConsoleAnimatedTextKit extends StatefulWidget {
  /// List of [String] that would be displayed subsequently in the animation.
  final List<String> text;

  /// Gives [TextStyle] to the text strings.
  final TextStyle textStyle;

  /// The [Duration] of the delay between the apparition of each characters.
  ///
  /// By default it is set to 30 milliseconds
  final Duration speed;

  /// Define the [Duration] of the pause between texts
  ///
  /// By default it is set to 1000 milliseconds.
  final Duration pause;

  /// Adds the onTap [VoidCallback] to the animated widget.
  final VoidCallback onTap;

  /// Adds the onFinished [VoidCallback] to the animated widget.
  ///
  /// This method will run only if [isRepeatingAnimation] is set to false.
  final VoidCallback onFinished;

  /// Adds [AlignmentGeometry] property to the text in the widget.
  ///
  /// By default it is set to [AlignmentDirectional.topStart]
  final AlignmentGeometry alignment;

  /// Adds [TextAlign] property to the text in the widget.
  ///
  /// By default it is set to [TextAlign.start]
  final TextAlign textAlign;

  /// Should the animation ends up early and display full text if you tap on it ?
  ///
  /// By default it is set to false.
  final bool displayFullTextOnTap;

  ConsoleAnimatedTextKit({
    Key key,
    @required this.text,
    this.textStyle,
    this.speed,
    this.pause,
    this.displayFullTextOnTap = true,
    this.onTap,
    this.onFinished,
    this.alignment = AlignmentDirectional.topStart,
    this.textAlign = TextAlign.start,
  })  : assert(text != null, 'You must specify the list of text'),
        super(key: key);

  @override
  _ConsoleState createState() => _ConsoleState();
}

class _ConsoleState extends State<ConsoleAnimatedTextKit>
    with TickerProviderStateMixin {
  AnimationController _controller;

  Animation _consoleAnimation;
  List<Widget> textWidgetList = [];

  Duration _speed;
  Duration _pause;

  List<String> _lines = [];

  bool _isCurrentlyPausing = false;
  bool _isFirstRun = true;
  int _blinkTime = 20;
  int _lastAnimationValue = 0;
  int _blinkCursorCount = 0;
  Timer _timer;

  int _endValue;

  @override
  void initState() {
    super.initState();
    _speed = widget.speed ?? const Duration(milliseconds: 5);
    _pause = widget.pause ?? const Duration(milliseconds: 1000);
    _lines = widget.text;
    _nextAnimation();
  }

  @override
  void didUpdateWidget(ConsoleAnimatedTextKit oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.text[0] != oldWidget.text[0]) {
      _lines = widget.text;

      _isCurrentlyPausing = false;
      _isFirstRun = true;
      _blinkTime = 20;
      _lastAnimationValue = 0;
      _blinkCursorCount = 0;
      _nextAnimation();
    }
  }

  @override
  void dispose() {
    _controller?.stop();
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: _onTap,
        child: _isCurrentlyPausing || !_controller.isAnimating
            ? RichText(
                text: TextSpan(children: [
                  TextSpan(
                    text: _lines.join(''),
                    style: widget.textStyle,
                  ),
                  TextSpan(
                      text: '_',
                      style:
                          widget.textStyle.copyWith(color: Colors.transparent))
                ], style: widget.textStyle),
                textAlign: widget.textAlign,
              )
            : AnimatedBuilder(
                animation: _controller,
                builder: (BuildContext context, Widget child) {
                  String visibleString = _lines.join('');
                  var cursorColor = Colors.transparent;
                  try {
                    if (_consoleAnimation.value == 0) {
                      visibleString = "";
                    } else if (cursorBlinking(_consoleAnimation.value)) {
                      cursorColor = _consoleAnimation.value % 2 == 0
                          ? widget.textStyle.color
                          : Colors.transparent;

                      visibleString =
                          visibleString.substring(0, _lastAnimationValue);
                      _blinkCursorCount =
                          _consoleAnimation.value - _lastAnimationValue;
                    } else {
                      _lastAnimationValue =
                          _consoleAnimation.value - _blinkCursorCount;
                      cursorColor = _lastAnimationValue % 2 == 0
                          ? widget.textStyle.color
                          : Colors.transparent;
                      visibleString =
                          visibleString.substring(0, _lastAnimationValue);
                    }
                  } catch (e) {
                    visibleString = visibleString;
                  }

                  return RichText(
                    text: TextSpan(children: [
                      TextSpan(text: visibleString),
                      TextSpan(
                          text: '_',
                          style: widget.textStyle.copyWith(color: cursorColor))
                    ], style: widget.textStyle),
                    textAlign: widget.textAlign,
                  );
                },
              ));
  }

  bool cursorBlinking(int value) {
    var offset = 0;
    if (value < _lines[0].length + 1) {
      return false;
    }
    for (var line in _lines) {
      var minVal = offset + line.length;
      var maxVal = offset + line.length + _blinkTime;
      if (inRange(value, minVal, maxVal)) {
        return true;
      }
      offset = offset + line.length + _blinkTime;
    }

    if (value > _endValue - _blinkTime - 1) {
      return true;
    }
    return false;
  }

  bool inRange(int value, int min, int max) => value >= min && value < max;

  void _nextAnimation() {
    _isCurrentlyPausing = false;

    if (!_isFirstRun) {
      widget.onFinished?.call();
      return;
    }

    var duration = _lines.fold(
        Duration(), (prev, next) => (_speed * next.length) + _pause + prev);

    _controller = AnimationController(
      duration: duration,
      vsync: this,
    );

    _endValue = _lines.fold(0, (prev, next) => prev + next.length + _blinkTime);

    _consoleAnimation = StepTween(begin: 0, end: _endValue).animate(_controller)
      ..addStatusListener(_animationEndCallback);

    _controller.forward();
  }

  void _setPause() {
    _isCurrentlyPausing = true;
    if (mounted) setState(() {});
  }

  void _animationEndCallback(state) {
    if (state == AnimationStatus.completed) {
      _setPause();
      _isFirstRun = false;
      _timer = Timer(Duration(), _nextAnimation);
    }
  }

  void _onTap() {
    if (widget.displayFullTextOnTap) {
      _controller.stop();
      _setPause();

      _isFirstRun = true;
      widget.onFinished?.call();
    }
  }
}
