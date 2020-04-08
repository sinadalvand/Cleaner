import 'package:cleaner/Models/GlobalData.dart';
import 'package:cleaner/Models/TileData.dart';
import 'package:cleaner/Utils/Consts.dart';
import 'package:cleaner/Utils/Utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class TinyTile extends StatefulWidget {
  _TileStateHolder stateHolder = _TileStateHolder();
  TileData tileData;
  Function functionCLean;
  TinyTile(this.tileData);

  @override
  State<StatefulWidget> createState() {
    return stateHolder;
  }

  void cleanIt() {
    stateHolder._cleanIt();
  }
}

class _TileStateHolder extends State<TinyTile>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> alpha;

  var _broomDegre = -30.0;
  var _animationRepeatCount = 3;
  var _disable;

  _TileStateHolder() {
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500))
          ..addListener(() {
            setState(() {
              _broomDegre = alpha.value;
            });
          })
          ..addStatusListener((status) {
            print("Status: $status");
            if (status == AnimationStatus.forward) {
              _animationRepeatCount--;
              if (_animationRepeatCount < 1) {
                _controller.stop(canceled: true);
                setState(() {
                  widget.tileData.setDirty(false);
                });
              }
            }
          });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var globalData = ScopedModel.of<GlobalData>(context);
    widget.tileData.cleanCommand = _cleanIt;
    return ScopedModelDescendant<GlobalData>(
      builder: (context, child, GlobalData model) {
        _disable = model.isDisable();
        return child;
      },
      child: GestureDetector(
        onTap: () {
          if (_disable) return;
          setState(() {
            if (widget.tileData.getCleaner) {
              globalData.setCleanerPicked(false);
            }
            widget.tileData.setDirty(false);
            widget.tileData.setCleaner(false);
            // _cleanIt();
          });
        },
        child: Card(
          elevation: 2,
          color: Utils.hexToColor("#ff7c7c"),
          child: DragTarget<Text>(
            onAccept: (Text value) {
              setState(() {
                if (value.data == Consts.dirtySymbole)
                  widget.tileData.setDirty(true);
                if (value.data == Consts.broomSymbole)
                  widget.tileData.setCleaner(true);
              });
            },
            builder: (context, fList, sList) {
              return Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                    padding: EdgeInsets.only(bottom: 5),
                    child: Stack(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: _getShity(),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: RotationTransition(
                            turns: AlwaysStoppedAnimation(_broomDegre / 360),
                            child: _getCleaner(),
                          ),
                        )
                      ],
                    )),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _getShity() => widget.tileData.getDirty
      ? Text(
          Consts.dirtySymbole,
          style: TextStyle(fontSize: 22),
        )
      : Container();

  Widget _getCleaner() => widget.tileData.getCleaner
      ? Text(
          Consts.broomSymbole,
          style: TextStyle(fontSize: 35),
        )
      : Container();

  void _cleanIt() {
    alpha = Tween<double>(begin: -30, end: -60).animate(_controller);
    _controller.repeat(reverse: true);
  }
}
