import 'package:epicture/components/customIcons.dart';
import 'package:flutter/material.dart';
import 'package:epicture/request/request.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:epicture/views/cameraController.dart';
import 'package:camera/camera.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

Future<CameraDescription> getCamera() async {
    // Obtain a list of the available cameras on the device.
    final cameras = await availableCameras();

    // Get a specific camera from the list of available cameras.
    final firstCamera = cameras.first;

    return firstCamera;
}

class SlideMenu extends StatefulWidget {
    @override
    _SlideMenu createState() => new _SlideMenu();
}

class _SlideMenu extends State<SlideMenu> {
    var camera;
    var loaded = false;
    @override
    void initState() {
        super.initState();
        getCamera().then((value) {
            this.setState(() {
                this.camera = value;
                this.loaded = true;
            });
        });
    }

    @override
    Widget build(BuildContext context) {
        if (!loaded) {
            return SizedBox(
                height: MediaQuery.of(context).size.height - 130,
                child: SpinKitFadingCube(
                    color: Colors.white,
                    size: 60,
                ),
            );
        }
        return new Drawer(
            child: new ListView(
                children: <Widget>[
                    new ListTile(
                        title: new Text("Account"),
                        trailing: new Icon(Icons.arrow_upward),
                        onTap: () {
                            Navigator.of(context).pushReplacementNamed('/account');
                        }
                    ),
                    new ListTile(
                        title: new Text("Picture"),
                        trailing: new Icon(Icons.arrow_upward),
                        onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => TakePictureScreen(camera: this.camera)),
                            );
                        }
                    ),
                    new ListTile(
                        title: new Text("Disconnect"),
                        trailing: new Icon(Icons.arrow_upward),
                        onTap: () {}
                    )
                ],
            ),
        );
    }
}