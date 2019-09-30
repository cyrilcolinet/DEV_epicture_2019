import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'views/home.dart';
import 'views/login.dart';

String acces_token;
String refresh_token;
String account_username;
String account_id;
Map<String, String> header;

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: new ThemeData(primarySwatch: Colors.blue),
      home: new RedirectionPage(),
    );
  }
}
