import 'package:flutter/material.dart';

class Touchable extends StatelessWidget {
    final Widget child;
    final Function onPress;
    final EdgeInsets padding;

    const Touchable({Key key, @required this.child, @required this.onPress,
        @required this.padding}) : super(key: key);

    @override
    Widget build(BuildContext context) {
        return ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Material(
                color: Colors.transparent,
                child: InkWell(
                    child: Padding(
                        padding: padding,
                        child: child,
                    ),
                    onTap: this.onPress
                ),
            ),
        );
    }
}