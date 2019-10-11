import 'package:epicture/pages/account.dart';
import 'package:epicture/pages/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:epicture/pages/login.dart';
import 'package:epicture/pages/splashscreen.dart';

/// Application starter class
/// Stateless Widget
class Epicture extends StatelessWidget {

  /// Build widget
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: new ThemeData(primarySwatch: Colors.blue),
      home: new SplashScreen(),
      debugShowCheckedModeBanner: false,
      title: 'Epicture',
      routes: {
          '/login': (context) => Login(),
          '/dashboard': (context) => new Dashboard(),
          '/account': (context) => new Account()
      },
    );
  }

}

/// Start main and build application
void main() => runApp(new Epicture());