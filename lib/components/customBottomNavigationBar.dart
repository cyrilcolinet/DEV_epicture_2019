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

    void goToMenu(BuildContext context) {
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
                                    icon: Icon(Icons.dashboard),
                                    color: ModalRoute.of(context).settings.name == '/dashboard' ? Colors.green : Colors.white,
                                    onPressed: () {
                                        if (ModalRoute.of(context).settings.name != '/dashboard')
                                            Navigator.of(context).pushReplacementNamed('/dashboard');
                                    },
                                ),
                                SizedBox(width: 15),
                                IconButton(
                                    icon: Icon(Icons.favorite),
                                    color: ModalRoute.of(context).settings.name == '/fav' ? Colors.green : Colors.white,
                                    onPressed: () {
                                        Navigator.of(context).pushReplacementNamed("/fav");
                                    }
                                ),
                            ],
                        ),
                        Row(
                            children: <Widget>[
                                IconButton(
                                    icon: Icon(Icons.people),
                                    color: ModalRoute.of(context).settings.name == '/account' ? Colors.green : Colors.white,
                                    onPressed: () {
                                        if (ModalRoute.of(context).settings.name != '/account')
                                            Navigator.of(context).pushReplacementNamed('/account');
                                    },
                                ),
                                SizedBox(width: 15),
                                IconButton(
                                    icon: Icon(Icons.settings),
                                    color: ModalRoute.of(context).settings.name == '/settings' ? Colors.green : Colors.white,
                                    onPressed: () {
                                        if (ModalRoute.of(context).settings.name != '/settings')
                                            Navigator.of(context).pushReplacementNamed('/settings');
                                    },
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