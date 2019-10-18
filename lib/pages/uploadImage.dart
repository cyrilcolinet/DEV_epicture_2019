import 'dart:convert' as cipher;
import 'dart:io';
import 'package:Epicture/components/layout.dart';
import 'package:Epicture/objects/arguments/uploadImageArguments.dart';
import 'package:Epicture/utils/request.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

/// UploadImage page for the result of gallery image or camera
/// Extended from [StatefulWidget] class
class UploadImage extends StatefulWidget {
    _UploadImage createState() => _UploadImage();
}

/// New class state implementation of [UploadImage] class Stateful
/// Get picture and display it for post
/// Contains name, and description text fields
class _UploadImage extends State<UploadImage> {

    // Controllers for text inputs
    final TextEditingController name = TextEditingController();
    final TextEditingController description = TextEditingController();

    Map<String, String> convertDataIntoJson(File picture, String title, String desc) {
        List<int> imageBytes = picture.readAsBytesSync();

        // Add fields and return map
        return {
            "image": cipher.base64Encode(imageBytes),
            "title": title,
            "description": desc
        };
    }

    /// Display image
    /// Return [Widget]
    Widget displayImage(BuildContext context, UploadImageArguments args) {
        return ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                        BoxShadow(
                            color: Colors.black12,
                            offset: Offset(3.0, 6.0),
                            blurRadius: 10.0
                        )
                    ]
                ),
                child: FadeInImage(
                    image: FileImage(args.picture),
                    placeholder: AssetImage("assets/images/placeholder-img.jpg"),
                )
            ),
        );
    }

    /// Display text fields
    Widget displayTextFields(BuildContext context) {
        return Padding(
            padding: EdgeInsets.only(bottom: 20),
            child: Column(
                children: <Widget>[

                    // Title
                    TextField(
                        controller: this.name,
                        autocorrect: false,
                        textInputAction: TextInputAction.continueAction,
                        cursorColor: Colors.green,
                        decoration: InputDecoration(
                            labelText: "Enter image title",
                            labelStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: 16.0,
                                fontFamily: "Calibre-Semibold",
                                letterSpacing: 1.0,
                            ),
                            enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.green)),
                            focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.green)),
                        ),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                            fontFamily: "Calibre-Semibold",
                            letterSpacing: 1.0,
                        ),
                        onChanged: (String text) {
                            if (text.length == 0) {
                                print("Not display");
                                return;
                            }

                            print("Display");
                        },
                    ),

                    SizedBox(height: 10),

                    // Description
                    TextField(
                        controller: this.description,
                        maxLines: null,
                        autocorrect: false,
                        textInputAction: TextInputAction.send,
                        cursorColor: Colors.green,
                        decoration: InputDecoration(
                            labelText: "Enter description",
                            labelStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: 16.0,
                                fontFamily: "Calibre-Semibold",
                                letterSpacing: 1.0,
                            ),
                            enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.green)),
                            focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.green)),
                        ),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                            fontFamily: "Calibre-Semibold",
                            letterSpacing: 1.0,
                        ),
                    )
                ],
            ),
        );
    }

    /// Return a [Widget] of content
    /// Before all, check if image is loaded (VERY IMPORTANT) and post it to view
    Widget displayContent(UploadImageArguments args) {
        return SingleChildScrollView(
            child: GestureDetector(
                onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
                child: Column(
                    children: <Widget>[

                        Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                            child: Column(
                                children: <Widget>[
                                    // Display image
                                    this.displayImage(context, args),

                                    // Set description and title
                                    Align(
                                        alignment: Alignment.centerLeft,
                                        child: Padding(
                                            padding: EdgeInsets.only(top: 20,),
                                            child: Text("Title & Description",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 30.0,
                                                    fontFamily: "Calibre-Semibold",
                                                    letterSpacing: 1.0,
                                                )
                                            ),
                                        ),
                                    ),

                                    // Text field
                                    this.displayTextFields(context),

                                    SizedBox(height: 70)
                                ],
                            ),
                        ),
                    ],
                ),
            ),
        );
    }

    /// Build default [Widget] and display layout with content
    @override
    Widget build(BuildContext context) {
        final UploadImageArguments args = ModalRoute.of(context).settings.arguments;

        return Layout(
            body: this.displayContent(args),
            floatingMethod: () {
                if (this.name.text.length == 0)
                    return;

                // Show loader dialog
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                        return SizedBox(
                            height: MediaQuery.of(context).size.height - 130,
                            child: SpinKitFadingCube(
                                color: Colors.white,
                                size: 60,
                            ),
                        );
                    }
                );

                // Upload file and dismiss loader when ok$
                postRequest("/upload",
                    isAnonymousRequest: false,
                    json: this.convertDataIntoJson(args.picture, this.name.text, this.description.text)
                ).then((data) {
                    Navigator.of(context, rootNavigator: true).pop('dialog');
                    Navigator.of(context).pushReplacementNamed('/dashboard');
                });
            }
        );
    }
}