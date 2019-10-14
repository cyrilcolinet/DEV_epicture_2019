import 'package:flutter/material.dart';

/// GoToHome class
/// StatelessWidget extended
class GoToHomeButton extends StatelessWidget {

    /// Build widget
    @override
    Widget build(BuildContext context) {
        if (ModalRoute.of(context).settings.name == '/dashboard')
            return Container();

        // Adding go to home button
        return Padding(
            padding: EdgeInsets.only(right: 10, bottom: 10),
            child: InkWell(
                onTap: () => Navigator.of(context).pop(),
                child: Icon(Icons.arrow_back_ios,
                    color: Colors.white,
                    size: 25,
                ),
            ),
        );
    }
}