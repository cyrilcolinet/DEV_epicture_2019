import 'package:flutter/material.dart';

/// New class state implementation of [UploadButton] class Stateful
/// Get picture and display it for post
/// Contains name, and description text fields
class UploadButton extends StatelessWidget {

    // Class variables
    final Key key;
    final Function onPressed;

    /// Constructor
    UploadButton({this.key, @required this.onPressed});

    /// Build as a [Widget] and return it
    @override
    Widget build(BuildContext context) {
        return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                        Padding(
                            padding: EdgeInsets.only(right: 15),
                            child: FloatingActionButton.extended(
                                elevation: 10,
                                heroTag: "reset_form",
                                icon: const Icon(Icons.close, color: Colors.white),
                                label: const Text('Reset', style: TextStyle(color: Colors.white)),
                                backgroundColor: Colors.red,
                                onPressed: () => Navigator.of(context).pop(),
                            ),
                        ),

                        Padding(
                            padding: EdgeInsets.only(left: 15),
                            child: FloatingActionButton.extended(
                                elevation: 10,
                                heroTag: "send_form",
                                icon: const Icon(Icons.file_upload, color: Colors.white),
                                label: const Text('Upload', style: TextStyle(color: Colors.white)),
                                backgroundColor: Colors.green,
                                onPressed: this.onPressed,
                            ),
                        ),
                    ],
                ),
            ],
        );
    }
}