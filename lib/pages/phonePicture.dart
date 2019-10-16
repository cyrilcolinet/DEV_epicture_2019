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
class PictureScreen extends StatefulWidget {
  final File picture;
  PictureScreen({Key key, this.picture}): super(key: key);
  @override
  _PictureScreen createState() => _PictureScreen();
}

class _PictureScreen extends State<PictureScreen> {

  @override
  void initState() {
    super.initState();
  }

  //final File picture;
  TextEditingController name = new TextEditingController();
  TextEditingController desc = new TextEditingController();


  /*_PictureScreen({
    @required this.picture,
  });
*/
  Map CreateBodyForUpload(String EncodedPicture, String Name, String Description) {
    print("body creation");
    print(Name);
    print(Description);
    Map body = {
      'image': EncodedPicture,
      'name': Name,
      'description': Description,
    };

    return (body);
  }

  Map convertImg(File path, String name, String Description) {
    Map body = {};
    List<int> imageBytes = path.readAsBytesSync();
    String test = base64Encode(imageBytes);
    print("boddy started creating");
    body = CreateBodyForUpload(test, name, Description);
    print("boddy finished creating");
    return body;
  }

  @override Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1b1e44),
      body: Container(
        child: Column(
          children: <Widget>[
            Image.file(widget.picture, height: 300.0, width: 300.0),
            TextField(
              controller: this.name,
              decoration: InputDecoration(
                  hintText: "Name"
              ),
              autocorrect: true,
            ),
            TextField(
              controller: this.desc,
              decoration: InputDecoration(
                  hintText: "Description"
              ),
              autocorrect: true,
            ),
            Row(
              children: <Widget>[
                RaisedButton(
                    padding: EdgeInsets.all(50.0),
                    onPressed: () {
                      print(name.text);
                      print(desc.text);
                      postRequest("/upload", isAnonymousRequest:false, json:convertImg(widget.picture, this.name.text, this.desc.text));
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