import 'package:flutter/material.dart';

/// GoToHome class
/// StatelessWidget extended
class GoToHomeButton extends StatelessWidget {

    Function performBackAction(BuildContext context) {
        return () {
            NavigatorState nav = Navigator.of(context);

            // Check if navigator can pop and go back
            if (nav.canPop()) {
                nav.pop(false);
                return;
            }

            // Redirect to home if can't pop navigation
            nav.pushNamed('/dashboard');
        };
    }

    /// Build widget
    @override
    Widget build(BuildContext context) {
        if (ModalRoute.of(context).settings.name == '/dashboard')
            return Container();

        // Adding go to home button
        return Padding(
            padding: EdgeInsets.only(bottom: 10, left: 10),
            child: IconButton(
                onPressed: this.performBackAction(context),
                icon: Icon(Icons.arrow_back_ios,
                    color: Colors.white,
                    size: 25,
                ),
            )
        );
    }
}