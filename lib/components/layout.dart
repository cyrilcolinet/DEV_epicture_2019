import 'package:epicture/components/customBottomNavigationBar.dart';
import 'package:flutter/material.dart';
import 'Drawer.dart';

/// Header component
/// Must be integrated in all routes
class Layout extends StatelessWidget {
    final Widget body;

    // Constructor
    Layout({this.body});

    /// Build header
    @override
    Widget build(BuildContext context) {
        return CustomBottomNavigationBar(
            child: Container(
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
                child: Scaffold(
                    drawer: new SlideMenu(),
                    backgroundColor: Colors.transparent,
                    body: SafeArea(
                        child: SingleChildScrollView(
                            child: Column(
                                children: <Widget>[this.body],
                            ),
                        ),
                    )
                ),
            ),
        );
    }
}