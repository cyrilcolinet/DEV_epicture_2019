import 'dart:math';
import 'package:epicture/components/cardScroller.dart';
import 'package:epicture/components/customIcons.dart';
import 'package:epicture/components/layout.dart';
import 'package:epicture/request/request.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

/// Home class
/// Stateful with state
class Home extends StatefulWidget {
    @override
    _HomeState createState() => new _HomeState();
}

/// Home State
/// State of Home class
class _HomeState extends State<Home> {
    var currentPage;
    var loaded = false;

    // Images and titles
    List<String> images = [];
    List<String> titles = [];

    // Configure controller
    PageController _controller;

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
        return Column(
            children: <Widget>[
                Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                            Text("Gallery",
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
                Stack(
                    children: <Widget>[
                        CardScroller(
                            currentPage: this.currentPage,
                            images: this.images,
                            titles: this.titles,
                        ),
                        Positioned.fill(
                            child: PageView.builder(
                                itemCount: images.length,
                                controller: _controller,
                                reverse: true,
                                itemBuilder: (context, index) {
                                    return Container();
                                },
                            ),
                        )
                    ],
                ),
                Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                            Text("Favourites",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 46.0,
                                    fontFamily: "Calibre-Semibold",
                                    letterSpacing: 1.0,
                                )
                            ),
                            IconButton(
                                icon: Icon(
                                    CustomIcons.option,
                                    size: 12.0,
                                    color: Colors.white,
                                ),
                                onPressed: () {},
                            )
                        ],
                    ),
                ),
                SizedBox(
                    height: 20.0,
                ),
                Row(
                    children: <Widget>[
                        Padding(
                            padding: EdgeInsets.only(left: 18.0),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(20.0),
                                child: Image.asset("assets/image_02.jpg",
                                    width: 296.0, height: 222.0),
                            ),
                        )
                    ],
                )
            ],
        );
    }
}