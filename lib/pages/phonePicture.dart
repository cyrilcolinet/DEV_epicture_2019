import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:Epicture/request/request.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' show join;
import 'package:path_provider/path_provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

// A screen that allows users to take a picture using a given camera.
class PictureScreen extends StatelessWidget {
  final File picture;

  const PictureScreen({
    Key key,
    @required this.picture,
  }) : super(key: key);
  //PictureScreen({this.picture});

  Map CreateBodyForUpload(String EncodedPicture) {
    Map body = {
      'image': EncodedPicture
    };

    return (body);
  }

  Map convertImg(File path) {
    Map body = {};
    List<int> imageBytes = path.readAsBytesSync();
    String test = base64Encode(imageBytes);
    body = CreateBodyForUpload(test);
    return body;
  }

  @override Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1b1e44),
      body: Container(
        child: Column(
          children: <Widget>[
            Image.file(this.picture, height: 300.0, width: 300.0),
            Row(
              children: <Widget>[
                RaisedButton(
                    padding: EdgeInsets.all(50.0),
                    onPressed: () {
                      postRequest("/upload", isAnonymousRequest:false, json:convertImg(this.picture));
                      Navigator.of(context).pushReplacementNamed('/dashboard');
                    },
                    color: Colors.blueAccent,
                    splashColor: Colors.white70,
                    child: Icon(Icons.share, color: Colors.white70,)
                ),
                RaisedButton(
                    padding: EdgeInsets.all(50.0),
                    onPressed: () {

                    },
                    color: Colors.redAccent,
                    splashColor: Colors.white70,
                    child: Icon(Icons.cancel, color: Colors.white70,)
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
