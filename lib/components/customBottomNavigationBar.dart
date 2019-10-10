import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatelessWidget {

    final Widget child;

    CustomBottomNavigationBar({this.child});

    void addNewPhoto() {

    }

    void goToMenu() {

    }

    void searchImage() {

    }

    /// Build content and display bottom navigation bar
    @override
    Widget build(BuildContext context) {
        return new Scaffold(
            floatingActionButton: FloatingActionButton.extended(
                elevation: 4.0,
                icon: const Icon(Icons.photo_camera),
                label: const Text('Upload'),
                backgroundColor: Colors.green,
                onPressed: this.addNewPhoto,
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
            bottomNavigationBar: BottomAppBar(
                color: Color(0xFF1b1e40),
                elevation: 800,
                child: new Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                        Row(
                            children: <Widget>[
                                SizedBox(width: 15),
                                IconButton(
                                    icon: Icon(Icons.people),
                                    color: Colors.white,
                                    onPressed: this.goToMenu,
                                ),
                                SizedBox(width: 15),
                                IconButton(
                                    icon: Icon(Icons.favorite),
                                    color: Colors.white,
                                    onPressed: this.goToMenu,
                                ),
                            ],
                        ),
                        Row(
                            children: <Widget>[
                                IconButton(
                                    icon: Icon(Icons.settings),
                                    color: Colors.white,
                                    onPressed: this.searchImage,
                                ),
                                SizedBox(width: 15),
                                IconButton(
                                    icon: Icon(Icons.search),
                                    color: Colors.white,
                                    onPressed: this.searchImage,
                                ),
                                SizedBox(width: 15),
                            ],
                        )
                    ],
                ),
            ),
            body: this.child,
        );
    }
}