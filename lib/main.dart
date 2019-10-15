import 'package:Epicture/pages/account.dart';
import 'package:Epicture/pages/dashboard.dart';
import 'package:Epicture/pages/favPictures.dart';
import 'package:Epicture/pages/login.dart';
import 'package:Epicture/pages/splashscreen.dart';
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
      debugShowCheckedModeBanner: false,
      title: 'Epicture',
      routes: {
          '/login': (context) => Login(),
          '/dashboard': (context) => new Dashboard(),
          '/account': (context) => new Account(),
          '/fav': (context) => new FavPictures()
      },
    );
  }

}

/// Start main and build application
void main() => runApp(new Epicture());