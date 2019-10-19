import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// SplashScreen class
/// Stateful Widget
class SplashScreen extends StatefulWidget {
    @override
    _SplashScreenState createState() => new _SplashScreenState();
}

/// SplashScreen class
/// Configure state
class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {

    Animation<Color> animation;
    AnimationController animController;

    /// Start timer splash screen
    startTime() async {
        var _duration = new Duration(seconds: 5);
        return new Timer(_duration, navigationPage);
    }

    /// Navigate to route
    void navigationPage() {
        SharedPreferences.getInstance().then((prefs) {
            if (prefs.containsKey("account_id")) {
                // Redirect to dashboard route
                Navigator.of(context).pushReplacementNamed('/dashboard');
                return;
            }

            // Not connected, redirect to login page
            Navigator.of(context).pushReplacementNamed('/login');
        });
    }

    /// When state is started
    @override void initState() {
        super.initState();
        startTime();

        // Configure blinking logo
        this.animController = new AnimationController(
            vsync: this,
            duration: Duration(milliseconds: 1500)
        );
        this.animController.repeat();

        final CurvedAnimation curve = CurvedAnimation(
            parent: this.animController, curve: Curves.linear);
        this.animation = ColorTween(begin: Colors.white, end: Colors.blue).animate(curve);
        this.animation.addStatusListener((status) {
            if (status == AnimationStatus.completed) {
                this.animController.reverse();
            } else if (status == AnimationStatus.dismissed) {
                this.animController.forward();
            }

            // Rebuild
            setState(() {});
        });
        this.animController.forward();

        // TODO: Only debugging
        //SharedPreferences.getInstance().then((prefs) => prefs.clear());
    }

    /// On page dispose
    @override void dispose() {
        this.animController.dispose();
        super.dispose();
    }

    /// Build widget
    @override
    Widget build(BuildContext context) {
        return Container(
            decoration: BoxDecoration(
                color: Color(0xFF1b1e44),
                /*gradient: LinearGradient(
                    colors: [
                        Color(0xFF1b1e44),
                        Color(0xFF2d3447),
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    tileMode: TileMode.clamp
                )*/
            ),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                    SizedBox(
                        width: MediaQuery.of(context).size.width * 2 / 3,
                        child: FadeTransition(
                            opacity: this.animController,
                            child: Image.asset("assets/images/logo.png"),
                        ),
                    )
                ],
            )
        );
    }

}