import 'package:Epicture/components/buttons/goToHomeButton.dart';
import 'package:Epicture/components/layout.dart';
import 'package:Epicture/components/masonryView.dart';
import 'package:Epicture/objects/image.dart' as object;
import 'package:Epicture/utils/request.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class FavPictures extends StatefulWidget {
    @override
    _FavPicturesState createState() => _FavPicturesState();
}

class _FavPicturesState extends State<FavPictures> {
    bool loaded = false;
    List<object.Images> images = [];
    List<TileSize> tileSizes = [];

    Future<List<object.Images>> parseAccountPictures() {
        Future request = getRequest("/account/me/favorites/", "data");

        return request.then((data) {
            List<object.Images> tmpImages = [];
            List<dynamic> values = data["data"];

            // Get all images
            values.forEach((tmp) {
                object.Images image = object.Images.fromJson(tmp);
                if (image.type.startsWith("image")) {
                    image.link = image.link;
                    tmpImages.add(image);
                    tileSizes.add(new TileSize(2, 2.0));
                }
            });

            return tmpImages;
        });
    }

    @override
    void initState() {
        super.initState();

        parseAccountPictures().then((res) => this.setState(() {
            images = res;
            loaded = true;
        }));
    }

    @override
    Widget build(BuildContext context) {
        return Layout(body: this.displayContent());
    }

    Widget displayContent() {
        if (!loaded) {
            return SizedBox(
                height: MediaQuery
                    .of(context)
                    .size
                    .height - 130,
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
                        padding: EdgeInsets.only(left: 20.0, top: 20),
                        child: Row(
                            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                                GoToHomeButton(),
                                Text("My Favourites",
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
                                                height: MediaQuery.of(context).size.height - 250,
                                                child: GridView.count(
                                                    children: List.generate(this.images.length, this.buildImagesGrid),
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

    Widget buildImagesGrid(int index) {
        return Padding(
            padding: EdgeInsets.only(left: 5, right: 5, bottom: 10),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
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
                    child: AspectRatio(
                        aspectRatio: 3 / 2,
                        child: CachedNetworkImage(
                            imageUrl: this.images[index].link,
                            placeholder: (BuildContext context, String str) {
                                return SpinKitFadingCube(
                                    color: Colors.black26,
                                    size: 30,
                                );
                            },
                        ),
                    ),
                ),
            ),
        );
    }
}
