import 'dart:async';
import 'package:flutter/material.dart';

/// SplashScreen class
/// Stateful Widget
class SplashScreen extends StatefulWidget {
    @override
    _SplashScreenState createState() => new _SplashScreenState();
}

/// SplashScreen class
/// Configure state
class _SplashScreenState extends State<SplashScreen> {

    /// Start timer splashscreen
    startTime() async {
        var _duration = new Duration(seconds: 4);
        return new Timer(_duration, navigationPage);
    }

    /// Navigate to route
    void navigationPage() {
        Navigator.of(context).pushReplacementNamed('/login');
    }

    /// When state is started
    @override
    void initState() {
        super.initState();
        startTime();
    }

    /// Buld widget
    @override
    Widget build(BuildContext context) {
        return Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [
                        Color(0xFF1b1e44),
                        Color(0xFF2d3447),
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    tileMode: TileMode.clamp
                )
            ),
            child: Column(
                children: <Widget>[
                    Image.network("https://upload.wikimedia.org/wikipedia/commons/thumb/e/e9/Imgur_logo.svg/1200px-Imgur_logo.svg.png")
                ],
            )
        );
    }

}