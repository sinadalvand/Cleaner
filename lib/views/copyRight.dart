import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:link/link.dart';

class CopyRight extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Container(
            alignment: Alignment.bottomCenter,
            width: constraints.maxWidth,
            height: constraints.maxHeight,
            child: Padding(
              padding: EdgeInsets.only(bottom: 5),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Link(
                    child: Row(
                      children: <Widget>[
                        Container(
                            width: 20.0,
                            height: 20.0,
                            decoration: new BoxDecoration(
                                shape: BoxShape.circle,
                                image: new DecorationImage(
                                    fit: BoxFit.fill,
                                    image: new NetworkImage(
                                        "https://avatars3.githubusercontent.com/u/7107442?s=400&u=eaf79cc4541df93c820d6c092cef25b52dd690b1&v=4")))),
                        SizedBox(width: 5),
                        Text(
                          'Sina Dalvand',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                    url: 'https://github.com/sinadalvand',
                    onError: () {},
                  ),
                 SizedBox(width: 20),
                  Link(
                    child: Row(
                      children: <Widget>[
                        Container(
                            width: 20.0,
                            height: 20.0,
                            decoration: new BoxDecoration(
                                shape: BoxShape.circle,
                                image: new DecorationImage(
                                    fit: BoxFit.fill,
                                    image: new NetworkImage(
                                        "https://avatars1.githubusercontent.com/u/47270033?s=460&u=46a69a46515ab1fb5fe2b56e4fe8644721d41fc4&v=4")))),
                        SizedBox(width: 5),
                        Text(
                          'Zahra Mansoori',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                    url: 'https://github.com/ZahraMansoori',
                    onError: () {},
                  ),
                ],
              ),
            ));
      },
    );
  }
}
