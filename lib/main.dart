import 'package:Epicture/pages/account.dart';
import 'package:Epicture/pages/dashboard.dart';
import 'package:Epicture/pages/favPictures.dart';
import 'package:Epicture/pages/login.dart';
import 'package:Epicture/pages/pictureInformation.dart';
import 'package:Epicture/pages/settings.dart';
import 'package:Epicture/pages/splashscreen.dart';
import 'package:Epicture/pages/uploadImage.dart';
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
          '/dashboard': (context) => Dashboard(),
          '/account': (context) => Account(),
          '/fav': (context) => FavPictures(),
          '/settings': (context) => Settings(),
          '/pictureInformation': (context) => PictureInformation(),
          '/uploadImage': (context) => UploadImage()
      },
    );
  }

}

/// Start main and build application
void main() => runApp(new Epicture());