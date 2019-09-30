import 'package:epicture/components/customIcons.dart';
import 'package:flutter/material.dart';

/// Header component
/// Must be integrated in all routes
class Layout extends StatelessWidget {
    final Widget content;

    // Constructor
    Layout(this.content);

    /// Build header
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
            child: Scaffold(
                backgroundColor: Colors.transparent,
                body: SingleChildScrollView(
                    child: Column(
                        children: <Widget>[
                            Padding(
                                padding: const EdgeInsets.only(
                                    left: 12.0,
                                    right: 12.0,
                                    top: 30.0,
                                    bottom: 8.0
                                ),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                        IconButton(
                                            icon: Icon(
                                                CustomIcons.menu,
                                                color: Colors.white,
                                                size: 30.0,
                                            ),
                                            onPressed: () {},
                                        ),
                                        IconButton(
                                            icon: Icon(
                                                Icons.search,
                                                color: Colors.white,
                                                size: 30.0,
                                            ),
                                            onPressed: () {},
                                        )
                                    ],
                                ),
                            ),

                            // Implement custom content
                            this.content
                        ],
                    ),
                )
            ),
        );
    }
}