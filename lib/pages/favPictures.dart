import 'package:Epicture/components/buttons/goToHomeButton.dart';
import 'package:Epicture/components/layout.dart';
import 'package:Epicture/components/masonryView.dart';
import 'package:Epicture/objects/FavImage.dart';
import 'package:Epicture/request/request.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class FavPictures extends StatefulWidget {
    @override
    _FavPicturesState createState() => _FavPicturesState();
}

class _FavPicturesState extends State<FavPictures> {
    bool loaded = false;
    List<FavImage> images = [];
    List<TileSize> tileSizes = [];

    Future<List<FavImage>> parseAccountPictures() {
        Future request = getRequest("/account/me/gallery_favorites/", "data");

        return request.then((data) {
            List<FavImage> tmpImages = [];
            List<dynamic> values = data["data"];
            List<TileSize> sizes = [];

            // Get all images
            print(values);
            values.where((item) => item['images'] != null).forEach((tmp) {
                FavImage image = FavImage.fromJson(tmp);
                if (image.images[0].type.startsWith("image")) {
                    image.link = image.images[0].link;
                    tmpImages.add(image);
                    tileSizes.add(new TileSize(2, 2.0));
                }
            });
            /*    test.forEach((tmp) {
        object.FavImage image = object.FavImage.fromJson(tmp);

        // Check for valid type of codec
        if (image.type.startsWith("image")) {
          image.link = image.link;
          tmpImages.add(image);

          // Configure size of tile
          tileSizes.add(new TileSize(1, 1.0));
        }
      });
*/
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
                                Text("Account",
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
                        child: Stack(
                            children: <Widget>[
                                Container(
                                    child: Column(
                                        children: <Widget>[
                                            Align(
                                                alignment: Alignment.centerLeft,
                                                child: Padding(
                                                    padding: EdgeInsets.only(top: 20, bottom: 10),
                                                    child: Text("My Favorites Pictures",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 30.0,
                                                            fontFamily: "Calibre-Semibold",
                                                            letterSpacing: 1.0,
                                                        )
                                                    ),
                                                ),
                                            ),

                                            SizedBox(
                                                width: MediaQuery.of(context).size.width,
                                                height: MediaQuery.of(context).size.height - 170,
                                                child: MasonryView.builder(
                                                    itemCount: this.images.length,
                                                    mainAxisSpacing: 10.0,
                                                    crossAxisSpacing: 10.0,
                                                    mainAxisRatio: 1.0,
                                                    crossAxisSpans: 4,
                                                    itemBuilder: this.buildImagesMasonry,
                                                    tileSizeBuilder: (index) {
                                                        if (index >= tileSizes.length) return null;
                                                        return tileSizes[index];
                                                    }
                                                ),
                                            )
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


    Widget buildImagesMasonry(BuildContext context, int index) {
        if (index >= tileSizes.length)
            return null;

        // Image with loader
        return ClipRRect(
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
                child: FadeInImage(
                    image: CachedNetworkImageProvider(this.images[index].link),
                    placeholder: AssetImage("assets/images/placeholder-img.jpg"),
                )
            ),
        );
    }
}
