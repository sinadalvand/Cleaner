import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
import 'package:cleaner/Models/GlobalData.dart';
import 'package:cleaner/Models/TileData.dart';
import 'package:cleaner/views/DragCounter.dart';
import 'package:cleaner/views/LabeledSwitch.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:scoped_model/scoped_model.dart';

import 'Utils/Consts.dart';

class OptionPanel extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _OptionPanelHolder();
  }
}

class _OptionPanelHolder extends State<OptionPanel> {
  GlobalData globalData;
  var _cleanerUsed = false;
  var _disable = false;
  @override
  Widget build(BuildContext context) {
    globalData = ScopedModel.of<GlobalData>(
      context,
    );
    globalData.addListener(() {
      if (globalData.isCleanerPicked() != _cleanerUsed) {
        _cleanerUsed = globalData.isCleanerPicked();
        setState(() {});
      }

      if (globalData.isDisable() != _disable) {
        _disable = globalData.isDisable();
        setState(() {});
      }
    });

    return Center(
      child: Container(
        height: double.infinity,
        child: FractionallySizedBox(
          heightFactor: 0.8,
          child: Padding(
            padding: EdgeInsets.only(top: 35),
            child: Container(
              width: 450,
              decoration: BoxDecoration(
                color: Colors.white10,
                borderRadius: BorderRadius.all(
                  Radius.circular(7.0),
                ),
              ),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Text(
                      "Options",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: SwitchListTileImproved(
                      title: const Text(
                        'Dark',
                        style: TextStyle(color: Colors.white),
                      ),
                      value: true,
                      activeColor: Consts.primaryColor,
                      onChanged: (bool value) {},
                      secondary: const Icon(
                        Icons.lightbulb_outline,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 30),
                    child: Column(
                      children: <Widget>[
                        Text(
                          "Increase or Decrease Tile Count",
                          style: TextStyle(
                            color: Colors.white54,
                          ),
                        ),
                        Container(
                          height: 90,
                          width: double.infinity,
                          child: DragCounter(
                            max: Consts.maxTiles,
                            min: 4,
                            currentValue: Consts.initTilesCount,
                            increaseCallback: (value) {
                              globalData.addTile(
                                  TileData(globalData.tileList.length));
                            },
                            decreaseCallback: (value) {
                              ScopedModel.of<GlobalData>(
                                context,
                              ).removeTile();
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.only(top: 30),
                      child: Column(
                        children: <Widget>[
                          Text(
                            "Drag and Drop Into Tiles",
                            style: TextStyle(color: Colors.white54),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 10),
                            child: Container(
                              height: 90,
                              width: double.infinity,
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    flex: 1,
                                    child: Container(),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Draggable<Text>(
                                      maxSimultaneousDrags:
                                          _cleanerUsed || _disable ? 0 : null,
                                      onDragCompleted: () {
                                        setState(() {
                                          // _cleanerUsed = true;
                                          globalData.setCleanerPicked(true);
                                        });
                                      },
                                      data: Text(
                                        Consts.broomSymbole,
                                        style: TextStyle(fontSize: 22),
                                      ),
                                      child: Container(
                                        width: double.infinity,
                                        height: double.infinity,
                                        decoration: BoxDecoration(
                                          color: Color(0x19FFFFFF),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(7.0),
                                          ),
                                        ),
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                            _cleanerUsed
                                                ? ""
                                                : Consts.broomSymbole,
                                            style: TextStyle(fontSize: 50),
                                          ),
                                        ),
                                      ),
                                      feedback: Material(
                                        color: Colors.transparent,
                                        child: Text(
                                          Consts.broomSymbole,
                                          style: TextStyle(fontSize: 50),
                                        ),
                                      ),
                                      childWhenDragging: Container(
                                        width: double.infinity,
                                        height: double.infinity,
                                        decoration: BoxDecoration(
                                          color: Color(0x19FFFFFF),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(7.0),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Container(),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Draggable<Text>(
                                      maxSimultaneousDrags: _disable ? 0 : null,
                                      data: Text(
                                        Consts.dirtySymbole,
                                        style: TextStyle(fontSize: 22),
                                      ),
                                      child: Container(
                                        width: double.infinity,
                                        height: double.infinity,
                                        decoration: BoxDecoration(
                                          color: Color(0x19FFFFFF),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(7.0),
                                          ),
                                        ),
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                            Consts.dirtySymbole,
                                            style: TextStyle(fontSize: 50),
                                          ),
                                        ),
                                      ),
                                      feedback: Material(
                                        color: Colors.transparent,
                                        child: Text(
                                          Consts.dirtySymbole,
                                          style: TextStyle(fontSize: 50),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Container(),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      )),
                  Padding(
                    padding: EdgeInsets.only(top: 50),
                    child: LayoutBuilder(builder: (context, constraint) {
                      return ArgonButton(
                        height: 50,
                        width: constraint.maxWidth * 3 / 5,
                        borderRadius: 5.0,
                        color: Consts.primaryColor,
                        child: Text(
                          "Start Cleaning",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w600),
                        ),
                        loader: Container(
                          padding: EdgeInsets.all(10),
                          child: SpinKitRotatingCircle(
                            color: Colors.white,
                            // size: loaderWidth ,
                          ),
                        ),
                        onTap: (startLoading, stopLoading, btnState) {
                          if (btnState == ButtonState.Idle) {
                            globalData.setDisable(true);
                            startLoading();
                            globalData.startEngine(() {
                              stopLoading();
                              globalData.setDisable(false);
                            });
                          } else {
                            globalData.setDisable(false);
                            stopLoading();
                            globalData.stopEngine();
                          }
                        },
                      );
                    }),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
