import 'package:Epicture/components/buttons/goToHomeButton.dart';
import 'package:Epicture/components/layout.dart';
import 'package:flutter/material.dart';

/// Search class with search bar and results
class Search extends StatelessWidget {

    /// Build a [Widget]
    @override
    Widget build(BuildContext context) {
        return Layout(body: this.displayContent(context));
    }

    /// Display content in the [Layout]
    Widget displayContent(BuildContext context) {
        return SingleChildScrollView(
            child: Column(
                children: <Widget>[
                    Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: Row(
                            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                                GoToHomeButton(),
                                Text("Search",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 40.0,
                                        fontFamily: "Calibre-Semibold",
                                        letterSpacing: 1.0,
                                    )
                                ),
                            ],
                        ),
                    ),

                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: Column(
                            children: <Widget>[

                            ],
                        ),
                    ),
                ],
            ),
        );
    }
}