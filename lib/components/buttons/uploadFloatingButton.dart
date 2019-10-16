import 'dart:io';
import 'package:Epicture/objects/arguments/uploadImageArguments.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:Epicture/pages/phonePicture.dart';


class UploadFloatingButton extends StatefulWidget {
    @override
    _UploadFloatingButton createState() => new _UploadFloatingButton();
}

class _UploadFloatingButton extends State<UploadFloatingButton>
    with TickerProviderStateMixin {

    AnimationController animController;

    /// Take or get a picture from camera/gallery and pass it to [UploadImage]
    /// route.
    Function takePictureFromFileOrCamera(BuildContext context, ImageSource source) {
        return () async {
            File picture = await ImagePicker.pickImage(source: source);

            // Redirect to route
            Navigator.pushNamed(context, '/uploadImage',
                arguments: UploadImageArguments(picture)
            );
        };
    }

    /// When widget start init of state
    @override
    void initState() {
        super.initState();

        // Configure animation controller
        this.animController = new AnimationController(
            vsync: this,
            duration: const Duration(milliseconds: 500),
        );
    }

    /// Build default [Widget] and display with contents
    @override
    Widget build(BuildContext context) {
        return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[

                // Other buttons
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[

                        // Choose file button
                        Container(
                            height: 70,
                            alignment: FractionalOffset.topCenter,
                            child: ScaleTransition(
                                scale: CurvedAnimation(
                                    parent: this.animController,
                                    curve: Interval(0.0, 1.0 - 1 / 4.0,
                                        curve: Curves.easeOut
                                    ),
                                ),
                                child: FloatingActionButton.extended(
                                    heroTag: "choose",
                                    elevation: 10,
                                    icon: const Icon(Icons.library_add),
                                    label: const Text('Choose'),
                                    backgroundColor: Colors.blue,
                                    onPressed: this.takePictureFromFileOrCamera(context, ImageSource.gallery),
                                )
                            ),
                        ),

                        SizedBox(width: 50),

                        // Take a picture and upload
                        Container(
                            height: 70,
                            alignment: FractionalOffset.topCenter,
                            child: ScaleTransition(
                                scale: CurvedAnimation(
                                    parent: this.animController,
                                    curve: Interval(0.0, 1.0 - 2 / 4.0,
                                        curve: Curves.easeOut
                                    ),
                                ),
                                child: FloatingActionButton.extended(
                                    heroTag: "take",
                                    elevation: 10,
                                    icon: const Icon(Icons.photo_camera),
                                    label: const Text('Take'),
                                    backgroundColor: Colors.blue,
                                    onPressed: this.takePictureFromFileOrCamera(context, ImageSource.camera),
                                )
                            ),
                        )
                    ],
                ),

                // Default floating button
                FloatingActionButton.extended(
                    heroTag: "upload",
                    icon: const Icon(Icons.add_photo_alternate),
                    label: const Text('Add'),
                    backgroundColor: Colors.green,
                    onPressed: () {
                        if (this.animController.isDismissed) {
                            this.animController.forward();
                        } else {
                            this.animController.reverse();
                        }
                    },
                ),

                SizedBox(height: 60)

            ],
        );
    }
}

