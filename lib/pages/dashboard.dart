import 'package:Epicture/components/cardScrollFeed.dart';
import 'package:Epicture/components/layout.dart';
import 'package:Epicture/objects/image.dart' as object;
import 'package:Epicture/utils/request.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Dashboard extends StatefulWidget {
    @override
    _DashboardState createState() => new _DashboardState();
}

class _DashboardState extends State<Dashboard> {

    bool loaded = false;

    // Class variables
    List<object.Image> images = [];
    List<String> titles = [];
    List<String> links = [];

    Future getDataFutures() {
        return Future.wait([this.getViralUrls("hot", "viral", "day", "0"), this.parseAccountFavPictures()]);
    }

    /// Get viral links from API
    Future getViralUrls(String section, String sort, String window, String page) {
        String url = "/gallery/" + section + "/" + sort + "/" + window + "/" + page;
        Future<Map<String, dynamic>> request = getRequest(url, "data");
        List<object.Image> tmpImages = [];

        print("getting viral url");
        // Wait for request result
        return request.then((data) {
            List<dynamic> values = data["data"];
            values.where((item) => item['images'] != null).forEach((tmp) {
                object.Image image = object.Image.fromJson(tmp);
                
                // Check for valid type of codec
                if (image.images[0].type.startsWith("image")) {
                    image.link = image.images[0].link;
                    tmpImages.add(image);
                }
            });
            print("returning viral images");
            return tmpImages;
            // Change and set state to loaded
        });
    }

    Future parseAccountFavPictures() {
        Future request = getRequest("/account/me/favorites/", "data");

        print("getting fav pictures");
        return request.then((data) {
            List<String> links = [];
            List<dynamic> values = data["data"];

            // Get all images
            values.forEach((tmp) {
                object.Images image = object.Images.fromJson(tmp);
                if (image.type.startsWith("image")) {
                    image.link = image.link;
                    links.add(image.link);
                }
            });
            print("returning fav pictures");
            return links;
        });
    }

    /// Init state when state called
    @override
    void initState() {
        super.initState();

        this.getDataFutures().then((res) => this.setState(() {
            this.images = res[0];
            this.links = res[1];
            print(links);
            this.loaded = true;
        }));
    }

    /// Build widget
    /// Adding controller to manager scrolling
    @override
    Widget build(BuildContext context) {
        return new Layout(body: this.displayContent());
    }

    /// Default content management
    Widget displayContent() {
        // If content not loaded, display loader
        if (!loaded) {
            return SizedBox(
                height: MediaQuery.of(context).size.height - 130,
                child: SpinKitFadingCube(
                    color: Colors.white,
                    size: 60,
                ),
            );
        }

        // Content loaded and images available
        return SingleChildScrollView(
            child: Column(
                children: <Widget>[
                    Padding(
                        padding: EdgeInsets.only(left: 20.0, top: 20, bottom: 2),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                                Text("Timeline",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 40.0,
                                        fontFamily: "Calibre-Semibold",
                                        letterSpacing: 1.0,
                                    )
                                )
                            ],
                        ),
                    ),
                    CardScrollFeed(images: this.images, links: this.links),
                ],
            ),
        );
    }

}

