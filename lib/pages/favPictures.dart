import 'package:Epicture/components/buttons/goToHomeButton.dart';
import 'package:Epicture/components/imageGridTile.dart';
import 'package:Epicture/components/layout.dart';
import 'package:Epicture/objects/image.dart' as object;
import 'package:Epicture/utils/request.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

/// Class extended from [StatefulWidget]
/// This class create a page with all favorites pictures
class FavPictures extends StatefulWidget {
    @override
    _FavPicturesState createState() => _FavPicturesState();
}

/// State creator of the [FavPictures] class
/// Extended from class [State] and applying setState function
/// Returns a [Widget] to display content
class _FavPicturesState extends State<FavPictures> {
    bool loaded = false;
    List<object.Images> images = [];

    /// Parse account pictures and get favorites
    /// Return a [Future] of [object.Images]
    Future<List<object.Images>> parseAccountPictures() {
        Future request = getRequest("/account/me/favorites/", "data");

        return request.then((data) {
            List<object.Images> tmpImages = [];
            List<dynamic> values = data["data"];

            // Get all images
            values.forEach((tmp) {
                object.Images image = object.Images.fromJson(tmp);
                if (image.type.startsWith("image"))
                    tmpImages.add(image);
            });

            return tmpImages;
        });
    }

    /// Rebuild state
    @override
    void initState() {
        super.initState();

        // Get favorites images and reload
        parseAccountPictures().then((res) => this.setState(() {
            this.images = res;
            this.loaded = true;
        }));
    }

    /// Build a main [Widget]
    @override
    Widget build(BuildContext context) {
        return Layout(body: this.displayContent());
    }

    /// Display content as a [Widget]
    Widget displayContent() {
        if (!loaded) {
            return SizedBox(
                height: MediaQuery.of(context).size.height - 130,
                child: SpinKitFadingCube(
                    color: Colors.white,
                    size: 60,
                ),
            );
        }

        return SingleChildScrollView(
            child: Column(
                children: <Widget>[
                    Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: Row(
                            children: <Widget>[
                                GoToHomeButton(),
                                Text("Favourites",
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
                        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                        child: Stack(
                            children: <Widget>[
                                Container(
                                    child: Column(
                                        children: <Widget>[

                                            SizedBox(
                                                width: MediaQuery.of(context).size.width,
                                                height: MediaQuery.of(context).size.height - 200,
                                                child: GridView.count(
                                                    children: List.generate(this.images.length, (int index) {
                                                        return ImageGridTile(
                                                            image: this.images[index],
                                                            seeMoreRoute: '/favoritePictureInformation',
                                                        );
                                                    }),
                                                    crossAxisCount: 3,
                                                )
                                            ),

                                        ],
                                    ),
                                )
                            ],
                        ),
                    ),
                ],
            ),
        );
    }

}
