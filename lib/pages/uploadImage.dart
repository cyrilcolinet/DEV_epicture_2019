import 'package:Epicture/components/buttons/goToHomeButton.dart';
import 'package:Epicture/components/buttons/uploadButton.dart';
import 'package:Epicture/components/layout.dart';
import 'package:Epicture/objects/arguments/uploadImageArguments.dart';
import 'package:flutter/material.dart';

/// UploadImage page for the result of gallery image or camera
/// Extended from [StatefulWidget] class
class UploadImage extends StatefulWidget {
    _UploadImage createState() => _UploadImage();
}

/// New class state implementation of [UploadImage] class Stateful
/// Get picture and display it for post
/// Contains name, and description text fields
class _UploadImage extends State<UploadImage> {

    /// Display image
    /// Return [Widget]
    Widget displayImage(BuildContext context, UploadImageArguments args) {
        return Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: ClipRRect(
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
                        autofocus: true,
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
                            padding: EdgeInsets.only(top: 20),
                            child: Row(
                                children: <Widget>[
                                    GoToHomeButton(),
                                    Text("Upload",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 40.0,
                                            fontFamily: "Calibre-Semibold",
                                            letterSpacing: 1.0,
                                        )
                                    ),
                                ],
                            ),
                        ),

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

                                    // Upload button
                                    Padding(
                                        padding: EdgeInsets.only(bottom: 40, top: 20),
                                        child: UploadButton(),
                                    )
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

        return Layout(body: this.displayContent(args));
    }
}