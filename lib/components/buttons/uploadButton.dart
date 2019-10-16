import 'package:flutter/material.dart';

/// UploadImage page for the result of gallery image or camera
/// Extended from [StatefulWidget] class
class UploadButton extends StatefulWidget {
    final Key key;

    /// Constructor
    UploadButton({this.key});

    /// Create [_UploadButton] state
    _UploadButton createState() => _UploadButton();
}

/// New class state implementation of [UploadButton] class Stateful
/// Get picture and display it for post
/// Contains name, and description text fields
class _UploadButton extends State<UploadButton> {

    @override
    Widget build(BuildContext context) {
        return Container(
            key: this.widget.key,
            width: MediaQuery.of(context).size.width / 2,
            child: InkWell(
                onTap: () {},
                splashColor: Colors.transparent,
                child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: 20.0,
                        vertical: 10.0
                    ),
                    decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(30.0)
                    ),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                            Icon(Icons.file_upload,
                                size: 16,
                                color: Colors.white,
                            ),
                            SizedBox(width: 5),
                            Text("Go upload !",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 23,
                                    fontFamily: "SF-Pro-Text-Regular"
                                )
                            ),
                        ],
                    ),
                ),
            ),
        );
    }
}