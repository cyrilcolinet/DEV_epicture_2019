import 'package:Epicture/components/buttons/uploadButton.dart';
import 'package:Epicture/components/buttons/uploadFloatingButton.dart';
import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatelessWidget {

    // Class variables
    final Widget child;
    final Function floatingMethod;

    /// CustomBottomNavigationBar constructor
    CustomBottomNavigationBar({@required this.child, this.floatingMethod});

    Widget displayFloatingButton(BuildContext context) {
        // Current route is upload too, bye bye
        if (ModalRoute.of(context).settings.name == '/uploadImage') {
            return UploadButton(onPressed: this.floatingMethod);
        }

        return UploadFloatingButton();
    }

    Widget displayBottomNavigationBar(BuildContext context) {
        // Current route is upload, bye
        if (ModalRoute.of(context).settings.name == '/uploadImage')
            return null;

        return BottomAppBar(
            color: Color(0xFF1b1e44),
            elevation: 20,
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
        );
    }

    /// Build content and display bottom navigation bar
    @override
    Widget build(BuildContext context) {
        return new Scaffold(
            floatingActionButton: this.displayFloatingButton(context),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
            bottomNavigationBar: this.displayBottomNavigationBar(context),
            body: this.child,
        );
    }
}