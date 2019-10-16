import 'dart:math' as math;
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:image_picker/image_picker.dart';
import 'package:Epicture/pages/phonePicture.dart';


class UploadFloatingButton extends StatefulWidget {
    @override
    _UploadFloatingButton createState() => new _UploadFloatingButton();
}

class _UploadFloatingButton extends State<UploadFloatingButton>
    with TickerProviderStateMixin {

    File picture;
    bool loaded = false;
    AnimationController animController;

    Future getPicture(bool isCamera) async {
        File Picture;

        if (isCamera) {
            Picture = await ImagePicker.pickImage(source: ImageSource.camera);
        } else {
            Picture = await ImagePicker.pickImage(source: ImageSource.gallery);
        }
        setState(() {
            picture = Picture;
            loaded = true;
        });
    }
    /// When widget start init of state
    @override void initState() {
        super.initState();

        // Configure animation controller
        this.animController = new AnimationController(
            vsync: this,
            duration: const Duration(milliseconds: 500),
        );
    }

    @override Widget build(BuildContext context) {
        if (loaded) {
            return PictureScreen(picture: picture);
        }
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
                                    onPressed: () {
                                        getPicture(false);
                                    },
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
                                    onPressed: () {
                                        getPicture(true);
                                    },
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


        return Column(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(1, (int index) {
                Widget child = Container(
                    height: 70.0,
                    //width: 56.0,
                    alignment: FractionalOffset.topCenter,
                    child: ScaleTransition(
                        scale: CurvedAnimation(
                            parent: this.animController,
                            curve: Interval(0.0, 1.0 - index / 4.0,
                                curve: Curves.easeOut
                            ),
                        ),
                        child: FloatingActionButton.extended(
                            elevation: 20,
                            icon: const Icon(Icons.photo_camera),
                            label: const Text('Upload'),
                            backgroundColor: Colors.green,
                            onPressed: () {},
                        )
                    ),
                );
                return child;
            }).toList()..add(
                FloatingActionButton.extended(
                    elevation: 20,
                    icon: const Icon(Icons.photo_camera),
                    label: const Text('Upload'),
                    backgroundColor: Colors.green,
                    onPressed: () {
                        if (this.animController.isDismissed) {
                            this.animController.forward();
                        } else {
                            this.animController.reverse();
                        }
                    },
                )
            ),
        );
    }
}
