import 'package:epicture/views/home.dart';
import 'package:epicture/views/login.dart';
import 'package:epicture/views/splashscreen.dart';
import 'package:flutter/material.dart';


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
        '/dashboard': (context) => new Home()
      },
      debugShowCheckedModeBanner: false,
    );
  }

}

/// Start main and build application
void main() => runApp(new Epicture());