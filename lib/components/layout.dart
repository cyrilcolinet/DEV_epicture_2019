import 'package:Epicture/components/customBottomNavigationBar.dart';
import 'package:flutter/material.dart';

/// Header component
/// Must be integrated in all routes
class Layout extends StatelessWidget {

    // Configure default values
    final Widget body;
    final Function floatingMethod;

    // Constructor
    Layout({@required this.body, this.floatingMethod});

    /// Build header
    @override
    Widget build(BuildContext context) {
        return CustomBottomNavigationBar(
            floatingMethod: this.floatingMethod,
            child: GestureDetector(
                onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
                child: Container(
                    decoration: BoxDecoration(
                        color: Color(0xFF1b1e44),
                    ),
                    child: this.body
                ),
            ),
        );
    }
}