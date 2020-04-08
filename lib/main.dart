import 'package:cleaner/Models/GlobalData.dart';
import 'package:cleaner/OptionPanel.dart';
import 'package:cleaner/PlayGround.dart';
import 'package:cleaner/views/copyRight.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:url_launcher/url_launcher.dart';
import 'Utils/Consts.dart';

void main() => runApp(MainApp());

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModel<GlobalData>(
      model: GlobalData(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: Consts.backgroundColor,
          body: Container(
              child: Stack(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  OptionPanel(),
                  SizedBox(width: 70),
                  PlayGround(),
                ],
              ),
              CopyRight()
            ],
          )),
        ),
      ),
    );
  }
}
