import 'dart:async';

import 'package:cleaner/Models/GlobalData.dart';
import 'package:cleaner/Utils/Consts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:core';

import 'package:scoped_model/scoped_model.dart';

class DragCounter extends StatefulWidget {
  final int min;
  final int max;
  final int deviationPixel;
  final int currentValue;
  final Function(int value) increaseCallback;
  final Function(int value) decreaseCallback;
  _DragCounterState _state;

  DragCounter(
      {@required this.currentValue,
      this.min = 0,
      this.max = 100,
      this.deviationPixel = 100,
      this.increaseCallback,
      this.decreaseCallback});

  @override
  State<StatefulWidget> createState() {
    return _state = _DragCounterState();
  }

  disable(bool disable) {
    _state.disable(disable);
  }
}

class _DragCounterState extends State<DragCounter>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> alpha;
  var _startPoint, _draging = 0.0;
  var _count;
  var _justOnce = false;
  var _disable = false;

  _DragCounterState() {
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 100))
          ..addListener(() {
            setState(() {
              _draging = alpha.value;
            });
          })
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {}
          });
  }

  @override
  void initState() {
    _count = widget.currentValue;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraint) {
        return ScopedModelDescendant<GlobalData>(
          builder: (context, child, GlobalData model) {
            _disable = model.isDisable();
            return child;
          },
          child: GestureDetector(
            child: getWidget(constraint.maxHeight, constraint.maxWidth),
            onTapDown: (TapDownDetails details) {
              _startPoint = details.localPosition.dx;
            },
            onTapUp: (TapUpDetails details) {
              _startPoint = 0;
            },
            onHorizontalDragUpdate: (DragUpdateDetails details) {
              if (details.localPosition.dx < 0 ||
                  details.localPosition.dx > constraint.maxWidth ||
                  _disable) return;
              setState(() {
                _draging =
                    (details.localPosition.dx - ((constraint.maxWidth) / 2)) /
                        ((constraint.maxWidth) / 2);
                if (_draging.abs() > 0.2) {
                  if (!_justOnce) {
                    _updateValue();
                    _scheduleTimer();
                    _justOnce = true;
                  }
                } else {
                  _resetTimer();
                }
              });
            },
            onHorizontalDragEnd: (DragEndDetails details) {
              _startReturnAnimation();
            },
          ),
        );
      },
    );
  }

  Widget getWidget(height, width) {
    return Container(
      child: Stack(
        children: <Widget>[
          Positioned(
            child: Align(
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0x07FFFFFF),
                  borderRadius: BorderRadius.all(
                    Radius.circular(7.0),
                  ),
                ),
                width: (height * 0.8) + (widget.deviationPixel * 2),
                height: (height * 0.8),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                            padding: EdgeInsets.only(left: 30),
                            child: Text("-",
                                style: TextStyle(
                                    color: Colors.white54,
                                    fontWeight: FontWeight.w700))),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                            padding: EdgeInsets.only(right: 30),
                            child: Text("+",
                                style: TextStyle(
                                    color: Colors.white54,
                                    fontWeight: FontWeight.w700))),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            left: (width / 2) -
                ((height / 2) * 0.8) +
                (widget.deviationPixel * _draging),
            child: Container(
              height: height,
              child: GestureDetector(
                onTapUp: (TapUpDetails details) {
                  _startPoint = 0;
                },
                child: FractionallySizedBox(
                  heightFactor: 0.8,
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: Card(
                      elevation: _disable ? 0.8 : 3,
                      color:
                          _disable ? Consts.disableColor : Consts.primaryColor,
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Align(
                          alignment: AlignmentDirectional.center,
                          child: Text(
                            _count.toString(),
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _startReturnAnimation() {
    _resetTimer();
    alpha = Tween<double>(begin: _draging, end: 0.0).animate(_controller);
    _controller.reset();
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Timer timer;
  final int timerInterval = 50;
  int timerFireCount = 0;

  int get timerFireCountModulo {
    if (timerFireCount > 80) {
      return 1; // 0.05 sec * 1 = 0.05 sec
    } else if (timerFireCount > 50) {
      return 2; // 0.05 sec * 2 = 0.1 sec
    } else {
      return 10; // 0.05 sec * 10 = 0.5 sec
    }
  }

  void _resetTimer() {
    _justOnce = false;
    if (timer != null) {
      timer.cancel();
      timer = null;
      timerFireCount = 0;
    }
  }

  void _scheduleTimer() {
    timer =
        Timer.periodic(Duration(milliseconds: timerInterval), _timerCallback);
  }

  void _timerCallback(Timer timer) {
    timerFireCount++;

    if (timerFireCount % timerFireCountModulo == 0) {
      _updateValue();
    }
  }

  void _updateValue() {
    setState(() {});
    if (_draging > 0) {
      if (_count < widget.max) {
        _count++;
        widget.increaseCallback(_count);
      }
    } else {
      if (_count > widget.min) {
        _count--;
        widget.decreaseCallback(_count);
      }
    }
  }

  void disable(bool disable) {
    setState(() {
      this._disable = disable;
    });
  }
}
