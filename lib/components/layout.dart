import 'package:Epicture/components/customBottomNavigationBar.dart';
import 'package:flutter/material.dart';

/// Header component
/// Must be integrated in all routes
class Layout extends StatelessWidget {

    // Configure default values
    final Widget body;
    final Function floatingMethod;

    // Class variables
    int selectedPage = 0;

    // Constructor
    Layout({@required this.body, this.floatingMethod});

    /// Build header
    @override
    Widget build(BuildContext context) {
        return CustomBottomNavigationBar(
            floatingMethod: this.floatingMethod,
            child: Container(
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
                child: this.body
            ),
        );
    }
}