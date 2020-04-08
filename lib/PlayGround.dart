import 'package:cleaner/Models/GlobalData.dart';
import 'package:cleaner/Utils/Consts.dart';
import 'package:cleaner/views/Tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class PlayGround extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _PlayGroundHolder();
  }
}

class _PlayGroundHolder extends State<PlayGround> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: FractionallySizedBox(
        heightFactor: 0.8,
        child: AspectRatio(
          aspectRatio: 1,
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: FractionallySizedBox(
                  widthFactor: 0.3,
                  child: Center(
                    child: Card(
                      child: Container(
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: 10, right: 10, bottom: 30, top: 5),
                          child: Text('   Work Ground   '),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 30,
                bottom: 0,
                left: 0,
                right: 0,
                child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: <Widget>[
                        Expanded(
                          flex: 9,
                          child: ScopedModelDescendant<GlobalData>(
                            builder: (context, child, GlobalData model) {
                              print("size: ${model.tileList.length}");
                              return GridView.count(
                                primary: false,
                                padding: const EdgeInsets.all(3),
                                crossAxisSpacing: 3,
                                mainAxisSpacing: 3,
                                crossAxisCount: 8,
                                children: model.tileList
                                    .map((e) => TinyTile(e))
                                    .toList(),
                              );
                            },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 10),
                          child: Opacity(
                            opacity: 0.5,
                            child: Text(
                              "For detele ${Consts.dirtySymbole} or ${Consts.broomSymbole} just click on Tile !",
                              style: TextStyle(
                                color: Consts.primaryColor,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
