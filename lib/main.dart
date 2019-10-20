import 'package:Epicture/pages/account.dart';
import 'package:Epicture/pages/dashboard.dart';
import 'package:Epicture/pages/favPictures.dart';
import 'package:Epicture/pages/favoritePictureInformation.dart';
import 'package:Epicture/pages/login.dart';
import 'package:Epicture/pages/pictureInformation.dart';
import 'package:Epicture/pages/search.dart';
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
          darkTheme: new ThemeData(
              brightness: Brightness.dark,
              primaryColor: Colors.white,
              backgroundColor: Color(0xFF1b1e44),
              bottomAppBarColor: Color(0xFF1b1e44),
              scaffoldBackgroundColor: Color(0xFF1b1e44),
              textTheme: TextTheme(
                  title: TextStyle(
                      color: Colors.black,
                      fontFamily: "Calibre-Semibold",
                      letterSpacing: 1.0,
                      fontSize: 25
                  )
              )
          ),
          routes: {
              '/login': (context) => Login(),
              '/dashboard': (context) => Dashboard(),
              '/account': (context) => Account(),
              '/fav': (context) => FavPictures(),
              '/search': (context) => Search(),
              '/pictureInformation': (context) => PictureInformation(),
              '/uploadImage': (context) => UploadImage(),
              '/favoritePictureInformation': (context) => FavoritePictureInformation()
          },
      );
  }

}

/// Start main and build application
void main() => runApp(new Epicture());