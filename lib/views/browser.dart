import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:http/http.dart' as http;
import '../request/request.dart' as request;
import '../main.dart' as main;
import 'dart:convert';
import 'dart:io';


class BrowserView extends StatefulWidget {
  @override
  State createState() => new BrowserViewState();
}

class BrowserViewState extends State<BrowserView>
    with SingleTickerProviderStateMixin {
  Animation<double> _iconAnimation;
  AnimationController _iconAnimationController;

  @override
  void initState() {
    super.initState();
    _iconAnimationController = new AnimationController(
        vsync: this, duration: new Duration(milliseconds: 500));
    _iconAnimation = new CurvedAnimation(
      parent: _iconAnimationController,
      curve: Curves.bounceOut,
    );
    _iconAnimation.addListener(() => this.setState(() {}));
    _iconAnimationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> test;
    request.getRequest("https://api.imgur.com/3/gallery/hot/viral/day/0", "data").then((test) {
      print(test);
    });
    return new Scaffold(
      backgroundColor: Colors.black,
      body: new Stack(fit: StackFit.expand, children: <Widget>[
      new Column(
      mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Container(
            padding: const EdgeInsets.all(40.0),
            child: new Form(
              autovalidate: true,
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  new TextField(
                    autocorrect: true,
                  ),
                  new MaterialButton(
                    height: 50.0,
                    minWidth: 150.0,
                    color: Colors.green,
                    splashColor: Colors.teal,
                    textColor: Colors.white,
                    child: Text("Browse"),
                    onPressed: (

                        ) {
                    },
                  )
                ],
              ),
            ),
          )
        ],
      ),
      ]),
    );
  }
}