import 'package:flutter/material.dart';

/// UploadImage page for the result of gallery image or camera
/// Extended from [StatefulWidget] class
class UploadButton extends StatefulWidget {

    // Class variables
    final Key key;
    final Function onPressed;

    /// Constructor
    UploadButton({this.key, @required this.onPressed});

    /// Create [_UploadButton] state
    _UploadButton createState() => _UploadButton();
}

/// New class state implementation of [UploadButton] class Stateful
/// Get picture and display it for post
/// Contains name, and description text fields
class _UploadButton extends State<UploadButton> {

    @override
    Widget build(BuildContext context) {
        return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                        Padding(
                            padding: EdgeInsets.only(bottom: 50, right: 15),
                            child: FloatingActionButton.extended(
                                elevation: 10,
                                heroTag: "reset_form",
                                icon: const Icon(Icons.close),
                                label: const Text('Reset'),
                                backgroundColor: Colors.red,
                                onPressed: () => Navigator.of(context).pop(),
                            ),
                        ),

                        Padding(
                            padding: EdgeInsets.only(bottom: 50, left: 15),
                            child: FloatingActionButton.extended(
                                elevation: 10,
                                heroTag: "send_form",
                                icon: const Icon(Icons.file_upload),
                                label: const Text('Upload'),
                                backgroundColor: Colors.green,
                                onPressed: this.widget.onPressed,
                            ),
                        ),
                    ],
                ),
            ],
        );
    }
}