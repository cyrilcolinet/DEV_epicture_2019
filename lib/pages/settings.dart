import 'package:Epicture/components/buttons/goToHomeButton.dart';
import 'package:Epicture/components/layout.dart';
import 'package:Epicture/components/touchable.dart';
import 'package:flutter/material.dart';

class Settings extends StatelessWidget {

    @override
    Widget build(BuildContext context) {
        return Layout(body: this.displayContent(context));
    }

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
                                Text("Settings",
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
                        child: Stack(
                            children: <Widget>[
                                Container(
                                    child: Column(
                                        children: <Widget>[
                                            Stack(
                                                children: <Widget>[
                                                    Touchable(
                                                        padding: EdgeInsets.only(left: 20, right: 20, top: 20),
                                                        onPress: () {},
                                                        child: Row(
                                                            crossAxisAlignment: CrossAxisAlignment.center,
                                                            children: <Widget>[
                                                                Padding(
                                                                    padding: EdgeInsets.all(10),
                                                                    child: Text("Yes",
                                                                        style: TextStyle(
                                                                            color: Colors.white,
                                                                            fontSize: 20,
                                                                            fontFamily: "Calibre-Semibold",
                                                                            letterSpacing: 1.0,
                                                                        ),
                                                                    ),
                                                                )
                                                            ],
                                                        ),
                                                    )
                                                ],
                                            ),
                                        ],
                                    ),
                                )
                            ],
                        ),
                    ),
                ],
            ),
        );
    }
}