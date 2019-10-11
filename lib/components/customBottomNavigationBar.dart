import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatelessWidget {

    // Class variables
    final Widget child;

    /// CustomBottomNavigationBar constructor
    CustomBottomNavigationBar({this.child});

    /// Emulate navigation and change current child
    void changeChildContent(Widget newChild) {

    }

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
                                    color: ModalRoute.of(context).settings.name == '/account' ? Colors.green : Colors.white,
                                    onPressed: () {
                                        if (ModalRoute.of(context).settings.name != '/account')
                                            Navigator.of(context).pushNamed('/account');
                                    },
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