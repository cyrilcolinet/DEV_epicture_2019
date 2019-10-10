import 'package:flutter/material.dart';
import 'package:epicture/views/home.dart';
import 'package:epicture/views/login.dart';
import 'package:epicture/views/Account.dart';
import 'package:epicture/views/splashscreen.dart';
import 'package:epicture/views/cameraController.dart';

/// Application starter class
/// Stateless Widget
class Epicture extends StatelessWidget {

  /// Build widget
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: new ThemeData(primarySwatch: Colors.blue),
      home: new SplashScreen(),
      routes: {
        '/login': (context) => new LoginPage(),
        '/dashboard': (context) => new Home(),
        '/account': (context) => new AccountView()
      },
      debugShowCheckedModeBanner: false,
    );
  }

}

/// Start main and build application
void main() => runApp(new Epicture());