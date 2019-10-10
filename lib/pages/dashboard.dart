import 'package:epicture/components/cardScrollFeed.dart';
import 'package:epicture/components/cardScroller.dart';
import 'package:epicture/components/customIcons.dart';
import 'package:epicture/components/layout.dart';
import 'package:epicture/request/request.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Dashboard extends StatefulWidget {
    @override
    _DashboardState createState() => new _DashboardState();
}

class _DashboardState extends State<Dashboard> {

    // Configure controller
    PageController _controller;

    var currentPage;
    var loaded = false;

    // Class variables
    List<String> images = [];
    List<String> titles = [];

    /// Get viral links from API
    void getViralUrls(String section, String sort, String window, String page) {
        String url = "https://api.imgur.com/3/gallery/" + section + "/" + sort + "/" + window + "/" + page;
        Future<Map<String, dynamic>> request = getRequest(url, "data");
        List<String> tmpImages = [];
        List<String> tmpTitles = [];

        // Wait for request result
        request.then((data) {
            List<dynamic> values = data["data"];
            values.where((item) => item['images'] != null).forEach((image) {
                List<dynamic> listImg = image['images'];

                // Add to images list
                if (listImg[0]['link'] != null && image['title'] != null
                    && listImg[0]['type'].toString().startsWith("image")) {
                    tmpImages.add(listImg[0]['link']);
                    tmpTitles.add(image['title']);
                }
            });

            // Configure controller
            _controller = PageController(initialPage: tmpImages.length - 1);
            _controller.addListener(() {
                setState(() {
                    currentPage = _controller.page;
                });
            });

            // Change and set state to loaded
            setState(() {
                this.currentPage = tmpImages.length - 1.0;
                this.images = tmpImages.toList();
                this.titles = tmpTitles.toList();
                this.loaded = true;
            });
        });
    }

    /// Init state when state called
    @override
    void initState() {
        super.initState();
        this.getViralUrls("hot", "viral", "day", "0");
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
                        padding: EdgeInsets.only(left: 20.0, top: 20),
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
                    CardScrollFeed(
                        images: this.images,
                        titles: this.titles
                    ),
                ],
            ),
        );
    }

}

