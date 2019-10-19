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
            elevation: 0,
            child: Container(
                color: Color(0xFF1b1e44),
                child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                        Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: IconButton(
                                icon: Icon(Icons.dashboard),
                                color: ModalRoute.of(context).settings.name == '/dashboard' ? Colors.green : Colors.white,
                                onPressed: () {
                                    if (ModalRoute.of(context).settings.name != '/dashboard')
                                        Navigator.of(context).pushReplacementNamed('/dashboard');
                                },
                            ),
                        ),
                        IconButton(
                            icon: Icon(Icons.search),
                            color: ModalRoute.of(context).settings.name == '/search' ? Colors.green : Colors.white,
                            onPressed: () {
                                Navigator.of(context).pushReplacementNamed("/search");
                            }
                        ),
                        SizedBox(width: 80),
                        IconButton(
                            icon: Icon(Icons.people),
                            color: ModalRoute.of(context).settings.name == '/account' ? Colors.green : Colors.white,
                            onPressed: () {
                                if (ModalRoute.of(context).settings.name != '/account')
                                    Navigator.of(context).pushReplacementNamed('/account');
                            },
                        ),
                        Padding(
                            padding: EdgeInsets.only(right: 10),
                            child: IconButton(
                                icon: Icon(Icons.favorite),
                                color: ModalRoute.of(context).settings.name == '/fav' ? Colors.green : Colors.white,
                                onPressed: () {
                                    Navigator.of(context).pushReplacementNamed("/fav");
                                }
                            ),
                        ),
                    ],
                ),
            ),
        );
    }

    /// Build content and display bottom navigation bar
    @override
    Widget build(BuildContext context) {
        return Container(
            color: Color(0xFF1b1e44),
            child: SafeArea(
                child: Scaffold(
                    extendBody: true,
                    floatingActionButton: this.displayFloatingButton(context),
                    floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
                    bottomNavigationBar: this.displayBottomNavigationBar(context),
                    body: this.child,
                ),
            ),
        );
    }
}